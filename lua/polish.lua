-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

if vim.g.neovide then vim.g.neovide_scale_factor = 1.25 end

-- Convert a hex color string (like #3D7FFF) to "61, 127, 255"
local function hex_to_rgb_string(hex)
  hex = hex:gsub("#", "")

  if #hex == 3 then
    -- Shorthand like #abc => aabbcc
    local r = tonumber(hex:sub(1, 1) .. hex:sub(1, 1), 16)
    local g = tonumber(hex:sub(2, 2) .. hex:sub(2, 2), 16)
    local b = tonumber(hex:sub(3, 3) .. hex:sub(3, 3), 16)
    return string.format("%d, %d, %d", r, g, b)
  elseif #hex == 6 then
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    return string.format("%d, %d, %d", r, g, b)
  else
    error("Invalid hex color length: " .. hex)
  end
end

-- Get visual selection
local function get_visual_selection()
  local bufnr = vim.api.nvim_get_current_buf()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")

  local start_row = start_pos[2] - 1
  local start_col = start_pos[3] - 1
  local end_row = end_pos[2] - 1
  local end_col = end_pos[3] - 1 -- ⬅️ make this inclusive

  if start_row ~= end_row then return nil end

  if start_col > end_col then
    start_col, end_col = end_col, start_col
  end

  local line = vim.api.nvim_buf_get_lines(bufnr, start_row, start_row + 1, false)[1]
  local line_length = #line

  -- Clamp end_col to avoid out-of-range
  end_col = math.min(end_col, line_length - 1)

  local selection = line:sub(start_col + 1, end_col + 1)
  return selection, start_row, start_col, end_col + 1 -- ⬅️ important: end_col + 1 for replace
end

-- Main function to replace hex with RGB
function ReplaceHexWithRGB()
  local selection, row, col_start, col_end = get_visual_selection()
  if not selection then
    print "Multi-line selection not supported"
    return
  end

  local trimmed = vim.trim(selection)
  -- Print debug message
  print("Selected text: [" .. trimmed .. "]")

  -- Validate hex pattern
  local hex = trimmed:match "^#?([%x]+)$"
  if not hex or (#hex ~= 3 and #hex ~= 6) then
    print "Selection doesn't look like a valid hex color (e.g. #3D7FFF or #abc)"
    return
  end

  local rgb = hex_to_rgb_string(hex)
  vim.api.nvim_buf_set_text(0, row, col_start, row, col_end, { rgb })
end

vim.keymap.set("v", "<Leader>hr", ReplaceHexWithRGB, { desc = "Replace hex with RGB" })
