local M = {}

-- Smart breakpoint function that uses pudb for Python and DAP for other languages
function M.smart_breakpoint()
  -- Check if current file is Python
-- if vim.bo.filetype == 'python' then
--   -- Get current line and its indentation
--   local line = vim.api.nvim_get_current_line()
--   local indent = line:match("^%s+") or ""
--   
--   -- Create the pudb line with proper indentation
--   local pudb_line = indent .. "import pudb; pudb.set_trace()"
--   
--   -- Get current cursor position
--   local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
--   
--   -- Insert the pudb line above the current line with the same indentation
--   vim.api.nvim_buf_set_lines(0, row-1, row-1, false, {pudb_line})
--   
--   -- Optional: Move cursor to the newly inserted line
--   vim.api.nvim_win_set_cursor(0, {row, #indent})
--   
--   -- Print confirmation message
--   vim.api.nvim_echo({{"Added pudb breakpoint", "Normal"}}, false, {})
-- else
    -- For non-Python files, use DAP
  require('dap').toggle_breakpoint()
--   end
end

-- Return the module
return M
