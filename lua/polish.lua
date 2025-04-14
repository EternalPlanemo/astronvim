-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

if vim.g.neovide then vim.g.neovide_scale_factor = 1.25 end

local function hex_to_rgb_string(hex)
  hex = hex:gsub("#", "")
  if #hex == 3 then
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
    return nil
  end
end

local function get_visual_selection_range()
  local start_pos = vim.fn.getpos "v"
  local end_pos = vim.fn.getpos "."
  local start_row, start_col = start_pos[2], start_pos[3]
  local end_row, end_col = end_pos[2], end_pos[3]

  -- Normalize direction
  if start_row > end_row or (start_row == end_row and start_col > end_col) then
    start_row, end_row = end_row, start_row
    start_col, end_col = end_col, start_col
  end

  return start_row, start_col, end_row, end_col
end

function ReplaceHexWithRGB()
  local bufnr = vim.api.nvim_get_current_buf()
  local start_row, start_col, end_row, end_col = get_visual_selection_range()

  -- Only support single line
  if start_row ~= end_row then
    print "Only single-line selection supported"
    return
  end

  local line = vim.api.nvim_buf_get_lines(bufnr, start_row - 1, start_row, false)[1]
  if not line then
    print "Line not found"
    return
  end

  -- Clamp end_col if it goes past the line
  local line_len = #line
  if end_col > line_len then end_col = line_len end

  local selection = line:sub(start_col, end_col)
  local trimmed = selection:match "^%s*(#?[%x]+)%s*$"
  if not trimmed or (#trimmed ~= 7 and #trimmed ~= 4) then
    print("Invalid hex color selection: " .. (trimmed or "nil"))
    return
  end

  local rgb = hex_to_rgb_string(trimmed)
  if not rgb then
    print "Failed to convert hex"
    return
  end

  vim.api.nvim_buf_set_text(bufnr, start_row - 1, start_col - 1, start_row - 1, end_col, { rgb })
end

-- Use in visual mode
vim.keymap.set("v", "<leader>hr", function()
  -- Allow marks to update
  vim.schedule(ReplaceHexWithRGB)
end, { desc = "Replace hex with RGB" })
