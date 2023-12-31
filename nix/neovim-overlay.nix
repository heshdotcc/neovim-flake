{inputs}: final: prev:
with final.pkgs.lib; let
  pkgs = final;

  # Use this to create a plugin from an input
  mkNvimPlugin = src: pname:
    pkgs.vimUtils.buildVimPlugin {
      inherit pname src;
      version = src.lastModifiedDate;
    };

  mkNeovim = pkgs.callPackage ./mkNeovim.nix {};

  all-plugins = with pkgs; [
    # plugins from nixpkgs go in here.
    # https://search.nixos.org/packages?channel=unstable&from=0&size=50&sort=relevance&type=packages&query=vimPlugins
    vimPlugins.nvim-treesitter.withAllGrammars
    vimPlugins.luasnip # snippets | https://github.com/l3mon4d3/luasnip/
    # nvim-cmp (autocompletion) and extensions
    vimPlugins.nvim-cmp # https://github.com/hrsh7th/nvim-cmp
    vimPlugins.cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
    vimPlugins.lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
    vimPlugins.cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
    vimPlugins.cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
    vimPlugins.cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
    vimPlugins.cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
    vimPlugins.cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
    vimPlugins.cmp-cmdline # cmp command line suggestions
    vimPlugins.cmp-cmdline-history # cmp command line history suggestions
    # ^ nvim-cmp extensions
    # git integration plugins
    vimPlugins.diffview-nvim # https://github.com/sindrets/diffview.nvim/
    vimPlugins.neogit # https://github.com/TimUntersberger/neogit/
    vimPlugins.gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
    vimPlugins.vim-fugitive # https://github.com/tpope/vim-fugitive/
    # ^ git integration plugins
    # telescope and extensions
    vimPlugins.telescope-nvim # https://github.com/nvim-telescope/telescope.nvim/
    vimPlugins.telescope-fzy-native-nvim # https://github.com/nvim-telescope/telescope-fzy-native.nvim
    # telescope-smart-history-nvim # https://github.com/nvim-telescope/telescope-smart-history.nvim
    # ^ telescope and extensions
    # UI
    vimPlugins.lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
    vimPlugins.nvim-navic # Add LSP location to lualine | https://github.com/SmiteshP/nvim-navic
    vimPlugins.statuscol-nvim # Status column | https://github.com/luukvbaal/statuscol.nvim/
    vimPlugins.nvim-treesitter-context # nvim-treesitter-context
    # ^ UI
    # language support
    vimPlugins.neodev-nvim # adds support for Neovim's Lua API to lua-language-server | https://github.com/folke/neodev.nvim/
    # ^ language support
    # navigation/editing enhancement plugins
    vimPlugins.vim-unimpaired # predefined ] and [ navigation keymaps | https://github.com/tpope/vim-unimpaired/
    vimPlugins.eyeliner-nvim # Highlights unique characters for f/F and t/T motions | https://github.com/jinh0/eyeliner.nvim
    vimPlugins.nvim-surround # https://github.com/kylechui/nvim-surround/
    vimPlugins.nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
    vimPlugins.nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
    # ^ navigation/editing enhancement plugins
    # Useful utilities
    vimPlugins.nvim-unception # Prevent nested neovim sessions | nvim-unception
    # ^ Useful utilities
    # libraries that other plugins depend on
    vimPlugins.sqlite-lua
    vimPlugins.plenary-nvim
    vimPlugins.nvim-web-devicons
    vimPlugins.vim-repeat
    # ^ libraries that other plugins depend on
    # bleeding-edge plugins from flake inputs
    # (mkNvimPlugin inputs.wf-nvim "wf.nvim") # (example) keymap hints | https://github.com/Cassin01/wf.nvim
    # ^ bleeding-edge plugins from flake inputs
    vimExtraPlugins.github-nvim-theme
  ];

  extraPackages = with pkgs; [
    # language servers, etc.
    lua-language-server
    nil # nix LSP
  ];
in {
  # This is the neovim derivation
  # returned by the overlay
  nvim-pkg = mkNeovim {
    plugins = all-plugins;
    inherit extraPackages;
  };

  # You can add as many derivations as you like.
}
