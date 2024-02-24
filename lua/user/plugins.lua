local fn = vim.fn
-- plugins are just github repositories
-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim" -- plugins keep all of their data at .local/share/nvim -- plugins keep all of their data and std stuff at .local/share/nvim, then inside site you find /opt and /start (where are the plugins that run on start as the name suggests) dove nn si trova altro che i clones dle repos corrispondenti ai plugins (niente di +!)

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
-- qsto e' per evitare che l'errore si propaghi, se ci manca packer verifichiamolo e capiamolo subito terminando l'esecuz
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

-- Lazyloading: 
-- you can set (?) plugins in another way ie con: use {}. Dove in qsta lua table do il nome del plugin e con coppie chiave valore setto i parametri del plugin
-- il Lazyloading consiste nel caricare un plugin NN allo start di neovim ma qndo avviene 1 certo evento/vim command (in qsto caso conviene tenere il plugin in /opt (che capirai sta per optional) al posto che in /start) e il modo di farlo e' settare nla table: cmd = {'command', } ie possono essere tnti gli eventi/comandi che triggerano il plugin (per il bro ha senso se si tratta di 1 comando, con gli eventi e' + dubbioso)

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
