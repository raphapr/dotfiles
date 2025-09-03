require("raphapr.config.options")
require("raphapr.config.autocmds")
require("raphapr.config.utils")
require("raphapr.lazy")
require("raphapr.keymaps")

local constants = require("raphapr.config.constants")
require("luasnip.loaders.from_lua").load({ paths = { constants.paths.luasnip } })
