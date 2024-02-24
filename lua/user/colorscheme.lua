local colorscheme = "default" -- here we are declaring a variable (I believe that one could declare as variables also functions) and local is needed because by default lua creates global variables

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme) -- the .. is string concatenation, and the _ is because we are not interested/going to use that variable (it would be the output of the command executed in the protected call)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
