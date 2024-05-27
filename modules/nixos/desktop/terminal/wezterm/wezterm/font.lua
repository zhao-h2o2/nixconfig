local wezterm = require('wezterm')
local module = {}

module.font = wezterm.font_with_fallback({
  'Hack Nerd Font'
})
module.font_size = 14

return module
