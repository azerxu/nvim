-- Load custom treesitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- setting orgmode
require('orgmode').setup({
  org_agenda_files = { '~/source/org/*' },
  org_default_notes_file = '~/source/org/tips.org',
  org_todo_keywords = { "TODO(t)", "NEXT(n)",  "WAIT", "|", "Done(d)", "DELEGATED" },
  org_todo_keywords_faces = {
      WAIT = ':foreground blue :weight bold',
      DELEGATED = ':background #FFFFFF :slant italic :underline on',
      TODO = ':background #000000 :foreground red',
  },
  win_split_mode = "float",
})
