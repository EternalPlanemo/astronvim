local M = {}

local function trim(s) return (s or ""):gsub("^%s+", ""):gsub("%s+$", "") end

-- Convert "required|string|max:255" -> ['required', 'string', 'max:255']
local function convert_rule_string(rule_str)
  local parts = {}
  for part in string.gmatch(rule_str, "[^|]+") do
    table.insert(parts, string.format("'%s'", trim(part)))
  end
  return "[" .. table.concat(parts, ", ") .. "]"
end

-- Convert a line like: 'field' => 'required|string|max:255',
local function try_convert_line(line)
  local indent, key, value, comma = line:match "^(%s*)(['\"].-['\"])%s*=>%s*['\"](.-)['\"](,?)%s*$"

  if not key or not value then return nil end

  local converted = string.format("%s%s => %s%s", indent, key, convert_rule_string(value), comma ~= "" and "," or "")
  return converted
end

-- Convert visual selection or current line
function M.convert_rules()
  local start_line, end_line
  local mode = vim.api.nvim_get_mode().mode
  if mode == "v" or mode == "V" or mode == "\22" then
    start_line = vim.fn.line "'<"
    end_line = vim.fn.line "'>"
  else
    start_line = vim.fn.line "."
    end_line = start_line
  end

  local lines = vim.fn.getline(start_line, end_line)
  local new_lines, changed = {}, false

  for _, line in ipairs(lines) do
    local converted = try_convert_line(line)
    if converted then
      table.insert(new_lines, converted)
      changed = true
    else
      table.insert(new_lines, line)
    end
  end

  if changed then
    vim.fn.setline(start_line, new_lines)
    print "✅ Laravel validation rules converted."
  else
    print "ℹ️  No convertible Laravel rule lines found."
  end
end

function M.setup()
  vim.api.nvim_create_user_command("LaravelConvertRules", function(opts)
    if opts.range and opts.range ~= 0 then
      local l1, l2 = opts.line1, opts.line2
      local lines = vim.fn.getline(l1, l2)
      local new_lines, changed = {}, false
      for _, line in ipairs(lines) do
        local converted = try_convert_line(line)
        if converted then
          table.insert(new_lines, converted)
          changed = true
        else
          table.insert(new_lines, line)
        end
      end
      if changed then
        vim.fn.setline(l1, new_lines)
        print "✅ Laravel validation rules converted."
      else
        print "ℹ️  No convertible Laravel rule lines found."
      end
    else
      M.convert_rules()
    end
  end, { range = true, nargs = 0, desc = "Convert Laravel pipe validation rules to array syntax" })
end

return M
