---
title: {{format-date now '%Y'}}-W{{format-date now '%W'}} -- {{format-date (date "last week") "full"}} - {{format-date (date "today") "full"}}
date: {{ format-date now "%d/%m/%Y %X" }}
tags: [journal, weekly]
---

# Weekly Review

{{sh "generate-weekly-notes"}}
