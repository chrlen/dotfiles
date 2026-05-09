# Shared home-manager config — safe for all machines including work.
{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.shellAliases = {
    ll = "ls -l";

    # tmux
    ta = "tmux attach";
    tls = "tmux list-sessions";
    tas = "tmux attach-session -t";
    tan = "tmux new-session -A -s";

    # git
    gst = "git status";
    gcmsg = "git commit -m";
    gaa = "git add -A";
    gcb = "git checkout -b";
    gps = "git push";
    gpl = "git pull";

    # docker
    dps = "docker ps";
    dil = "docker image list";

    # editor
    v = "nvim";
    conf = "nvim ~/git/nixos";
    cnf = "nvim ~/git/nixos";

    # poetry
    pea = "poetry env activate";
    pi = "poetry install";
    pr = "poetry run";

    # glab
    glrl = "glab repo list";
    glrcr = "glab repo create";
    glrcl = "glab repo clone";
    glct = "glab ci trace";
  };

  programs.git.enable = true;

  home.packages = [
    pkgs.glab
    pkgs.ranger
    pkgs.w3m
    pkgs.tea
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      neo-tree-nvim
      plenary-nvim
      nui-nvim
      nvim-web-devicons
      mini-nvim
      dirbuf-nvim
      rustaceanvim
      nvim-dap
      nvim-dap-ui
      neomutt-vim
    ];
    extraLuaConfig = ''
      vim.opt.termguicolors = false
      vim.cmd.colorscheme("default")

      -- use system clipboard for all yank/put operations
      vim.opt.clipboard = "unnamedplus"

      -- clipboard keymaps
      vim.keymap.set({'n','v'}, '<C-S-c>', '"+y', { noremap = true })
      vim.keymap.set({'n','i','v'}, '<C-S-v>', '"+p', { noremap = true })

      -- neo-tree
      require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_current",
        },
        window = { width = 30 },
      })
      vim.keymap.set('n', '<C-n>', ':Neotree toggle<CR>', { noremap = true, silent = true })

      -- nvim-dap
      local dap = require('dap')
      local dapui = require('dapui')
      dapui.setup()
      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open() end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close() end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close() end
      vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Debug: Continue' })
      vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Debug: Step Over' })
      vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Debug: Step Into' })
      vim.keymap.set('n', '<leader>dO', dap.step_out, { desc = 'Debug: Step Out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
      vim.keymap.set('n', '<leader>du', dapui.toggle, { desc = 'Debug: Toggle UI' })

      -- rustaceanvim
      vim.g.rustaceanvim = { server = { settings = { ['rust-analyzer'] = {} } } }
    '';
  };

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      theme_background = false;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        ZSH_DISABLE_COMPFIX=true
      '')
      (lib.mkAfter ''
        source ~/.config/zsh/functions.sh
      '')
    ];

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "obraun";
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file.".config/zsh/functions.sh".source = ./lib/functions.sh;
}
