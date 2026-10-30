-- Templated files (e.g. Helm's `values.yaml.tmpl`) show the icon of the file
-- type they produce, since the template suffix alone says nothing useful.
-- Patches both icon providers: mini.icons (oil, statusline) and
-- nvim-web-devicons (telescope).

local M = {}

local template_extensions = { tmpl = true, gotmpl = true, tpl = true, j2 = true }

-- 'values.yaml.tmpl' -> 'values.yaml', 'notes.tmpl' -> nil
local function strip_file_suffix(name)
  if type(name) ~= 'string' then
    return nil
  end
  local stem, ext = name:match '^(.*)%.([^.]+)$'
  if stem == nil or not template_extensions[ext:lower()] or not stem:find '%.' then
    return nil
  end
  return stem
end

-- 'yaml.tmpl' -> 'yaml', 'tmpl' -> nil
local function strip_extension_suffix(ext)
  if type(ext) ~= 'string' then
    return nil
  end
  local base, suffix = ext:match '^(.+)%.([^.]+)$'
  if base == nil or not template_extensions[suffix:lower()] then
    return nil
  end
  return base
end

local function patch_mini_icons()
  local ok, mini_icons = pcall(require, 'mini.icons')
  if not ok then
    return
  end

  local get = mini_icons.get
  mini_icons.get = function(category, name)
    local base
    if category == 'file' then
      base = strip_file_suffix(name)
    elseif category == 'extension' then
      base = strip_extension_suffix(name)
    end

    if base ~= nil then
      local icon, hl, is_default = get(category, base)
      if not is_default then
        return icon, hl, is_default
      end
    end
    return get(category, name)
  end
end

local function patch_devicons()
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then
    return
  end

  local get_icon = devicons.get_icon
  devicons.get_icon = function(name, ext, opts)
    local base_name, base_ext = strip_file_suffix(name), strip_extension_suffix(ext)
    if base_name ~= nil or base_ext ~= nil then
      local probe = vim.tbl_extend('force', opts or {}, { default = false })
      local icon, hl = get_icon(base_name or name, base_ext or ext, probe)
      if icon ~= nil then
        return icon, hl
      end
    end
    return get_icon(name, ext, opts)
  end
end

M.setup = function()
  patch_mini_icons()
  patch_devicons()
end

return M
