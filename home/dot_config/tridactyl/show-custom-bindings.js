(() => {
  const id = "tridactyl-custom-bindings";
  const old = document.getElementById(id);

  if (old) {
    old.remove();
    return;
  }

  const render = (text) => {
    const box = document.createElement("pre");
    box.id = id;
    box.textContent = text;
    box.setAttribute(
      "style",
      [
        "position:fixed",
        "top:72px",
        "right:32px",
        "z-index:2147483647",
        "max-width:720px",
        "max-height:80vh",
        "overflow:auto",
        "margin:0",
        "padding:18px 20px",
        "border:1px solid #4b5563",
        "border-radius:12px",
        "background:#111827",
        "color:#f9fafb",
        "box-shadow:0 24px 60px rgba(0,0,0,.45)",
        "font:14px/1.45 ui-monospace,SFMono-Regular,Menlo,Monaco,Consolas,monospace",
        "white-space:pre-wrap",
        "cursor:pointer",
      ].join(";"),
    );

    const close = () => {
      box.remove();
      document.removeEventListener("keydown", onKey, true);
    };

    const onKey = (event) => {
      if (event.key === "q") close();
    };

    box.addEventListener("click", close);
    document.addEventListener("keydown", onKey, true);
    document.documentElement.appendChild(box);
  };

  const readTridactylrc = async () => {
    const result = await tri.native.run("cat ~/.tridactylrc");
    const content =
      typeof result === "string"
        ? result
        : (result && (result.content || result.stdout || "")) || "";

    if (!content) throw new Error("No ~/.tridactylrc content returned");

    return content;
  };

  const parseBindings = (rc) => {
    const sectionComments = new Set([
      "Binds",
      "Hints",
      "Quickmarks",
      "searchurls",
    ]);
    const cleanComment = (line) => line.replace(/^"\s*/, "").trim();
    const oneLine = (value) =>
      String(value || "")
        .replace(/\s+/g, " ")
        .trim();
    const commandDescriptions = {};
    const binds = [];
    const urlBinds = [];
    const quickmarks = [];
    let pendingComment = "";

    for (const raw of rc.split(/\r?\n/)) {
      const line = raw.trim();
      if (!line) continue;

      if (line[0] === String.fromCharCode(34)) {
        const comment = cleanComment(line);
        pendingComment = sectionComments.has(comment) ? "" : comment;
        continue;
      }

      if (line.startsWith("command ")) {
        const match = line.match(/^command\s+(\S+)\s+/);
        if (match && pendingComment)
          commandDescriptions[match[1]] = pendingComment;
        pendingComment = "";
        continue;
      }

      if (line.startsWith("bindurl ")) {
        const parts = line.split(/\s+/);
        const scope = parts[1] || "";
        let index = 2;

        while (parts[index] && parts[index].startsWith("--")) index++;

        const key = parts[index] || "";
        const action = parts.slice(index + 1).join(" ");
        const command = action.split(/\s+/)[0] || "";
        const description =
          pendingComment || commandDescriptions[command] || oneLine(action);
        urlBinds.push({ key, description, scope });
        pendingComment = "";
        continue;
      }

      if (line.startsWith("bind ")) {
        const parts = line.split(/\s+/);
        let index = 1;

        while (parts[index] && parts[index].startsWith("--")) index++;

        const mode = index > 1 ? `${parts.slice(1, index).join(" ")} ` : "";
        const key = mode + (parts[index] || "");
        const action = parts.slice(index + 1).join(" ");
        const command = action.split(/\s+/)[0] || "";
        const description =
          pendingComment || commandDescriptions[command] || oneLine(action);
        binds.push({ key, description });
        pendingComment = "";
        continue;
      }

      if (line.startsWith("quickmark ")) {
        const parts = line.split(/\s+/);
        const key = parts[1] || "";
        const url = parts.slice(2).join(" ");
        quickmarks.push({ key: `go/gn/gw ${key}`, description: url });
        pendingComment = "";
        continue;
      }

      pendingComment = "";
    }

    return { binds, urlBinds, quickmarks };
  };

  const format = (items) => {
    if (!items.length) return "  (none)";

    return items
      .map((item) => `  ${item.key.padEnd(16)}${item.description}`)
      .join("\n");
  };

  const buildPanel = ({ binds, urlBinds, quickmarks }) =>
    [
      "Custom Tridactyl keybindings",
      "",
      "Normal",
      format(binds),
      "",
      "URL-scoped",
      format(urlBinds),
      "",
      "Quickmarks",
      format(quickmarks),
      "",
      "Generated from ~/.tridactylrc.\nClick this panel, press q, or press ,, again to close.",
    ].join("\n");

  (async () => {
    try {
      const rc = await readTridactylrc();
      render(buildPanel(parseBindings(rc)));
    } catch (error) {
      render(
        "Could not read ~/.tridactylrc via native messenger.\n\n" +
          "Run :nativeinstall, then :source.\n\n" +
          (error && (error.message || String(error))),
      );
    }
  })().catch((error) => {
    render(
      "Could not render keybindings.\n\n" +
        (error && (error.stack || error.message || String(error))),
    );
  });
})();
