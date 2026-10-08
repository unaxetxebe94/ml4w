local home = os.getenv("HOME") or ""
local colors_path = home .. "/.local/state/omarchy/current/theme/colors.toml"

local colors = {}
local colors_file = io.open(colors_path, "r")
if colors_file then
  for line in colors_file:lines() do
    local key, value = line:match("^%s*([%w_]+)%s*=%s*\"(#%x%x%x%x%x%x)\"")
    if key then colors[key] = value end
  end
  colors_file:close()
end

local function get(key, fallback)
  return colors[key] or fallback
end

local function component(hex, index)
  return tonumber(hex:sub(index, index + 1), 16) or 0
end

local function to_hex(r, g, b)
  local function clamp(v)
    v = math.floor(v + 0.5)
    if v < 0 then return 0 end
    if v > 255 then return 255 end
    return v
  end
  return string.format("#%02x%02x%02x", clamp(r), clamp(g), clamp(b))
end

local function mix(first, second, amount)
  local r = component(first, 2) + (component(second, 2) - component(first, 2)) * amount
  local g = component(first, 4) + (component(second, 4) - component(first, 4)) * amount
  local b = component(first, 6) + (component(second, 6) - component(first, 6)) * amount
  return to_hex(r, g, b)
end

local function rgba(hex, alpha)
  return string.format("rgba(%s%s)", hex:sub(2):upper(), alpha)
end

local accent = get("accent", "#7fd4c8")
local background = get("background", "#0d1316")
local border_end = mix(accent, background, 0.55)
local border_inactive = mix(accent, background, 0.78)

local active_border = {
  colors = { rgba(accent, "ee"), rgba(accent, "ee"), rgba(border_end, "ee"), rgba(border_end, "ee") },
  angle = 90,
}

hl.config({
  general = {
    gaps_in = 6,
    gaps_out = 14,
    border_size = 2,
    resize_on_border = true,
    col = {
      active_border = active_border,
      inactive_border = rgba(border_inactive, "cc"),
    },
  },

  group = {
    col = {
      border_active = active_border,
      border_inactive = rgba(border_inactive, "cc"),
    },
  },

  decoration = {
    rounding = 10,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 0.9,
    fullscreen_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 32,
      render_power = 2,
      color = "rgba(00000050)",
    },

    blur = {
      enabled = true,
      size = 4,
      passes = 4,
      xray = true,
      ignore_opacity = true,
      new_optimizations = true,
      vibrancy = 0.17,
    },
  },
})

hl.layer_rule({ match = { namespace = "omarchy-bar" }, blur = true })

hl.curve("md3_standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("menu_decel", { type = "bezier", points = { { 0.1, 1 }, { 0, 1 } } })
hl.curve("menu_accel", { type = "bezier", points = { { 0.38, 0.04 }, { 1, 0.07 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "md3_accel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "md3_standard" })
hl.animation({ leaf = "fade", enabled = true, speed = 3, bezier = "md3_decel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.6, bezier = "menu_accel" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "menu_decel" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 4.5, bezier = "menu_accel" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "menu_decel", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "md3_decel", style = "slidevert" })
