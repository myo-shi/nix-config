return {
  {
    "lambdalisue/nvim-aibo",
    cmd = { "Aibo", "AiboSend", "AiboSendPath", "AiboSendWithLocation", "AiboSendCode" },
    config = function()
      require("aibo").setup()

      -- ファイルパスのみ送信
      vim.api.nvim_create_user_command("AiboSendPath", function(opts)
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local relative_path = vim.fn.fnamemodify(filename, ":~:.")

        local line1 = opts.line1
        local line2 = opts.line2

        -- パス+行番号のみ
        local location = string.format("%s:%d-%d", relative_path, line1, line2)

        local aibo_send = require("aibo.command.aibo_send")
        aibo_send.call({
          line1 = line1,
          line2 = line2,
          prefix = location,
          suffix = "",
          replace = opts.args:match("-replace") ~= nil,
          submit = opts.args:match("-submit") ~= nil,
          input = opts.args:match("-input") ~= nil,
        })
      end, {
        range = true,
        nargs = "*",
        desc = "Send only file path with line numbers to Aibo",
      })

      -- ファイルパス+改行+コード内容
      vim.api.nvim_create_user_command("AiboSendWithLocation", function(opts)
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local relative_path = vim.fn.fnamemodify(filename, ":~:.")

        local line1 = opts.line1
        local line2 = opts.line2

        local location = string.format("%s:%d-%d\n\n", relative_path, line1, line2)

        local aibo_send = require("aibo.command.aibo_send")
        aibo_send.call({
          line1 = line1,
          line2 = line2,
          prefix = location,
          submit = opts.args:match("-submit") ~= nil,
          replace = opts.args:match("-replace") ~= nil,
          input = opts.args:match("-input") ~= nil,
        })
      end, {
        range = true,
        nargs = "*",
        desc = "Send buffer content with file location to Aibo",
      })

      -- コードブロック版
      vim.api.nvim_create_user_command("AiboSendCode", function(opts)
        local bufnr = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(bufnr)
        local relative_path = vim.fn.fnamemodify(filename, ":~:.")
        local filetype = vim.bo[bufnr].filetype

        local line1 = opts.line1
        local line2 = opts.line2

        local prefix = string.format("%s:%d-%d\n```%s\n", relative_path, line1, line2, filetype)
        local suffix = "\n```"

        local aibo_send = require("aibo.command.aibo_send")
        aibo_send.call({
          line1 = line1,
          line2 = line2,
          prefix = prefix,
          suffix = suffix,
          submit = opts.args:match("-submit") ~= nil,
          replace = opts.args:match("-replace") ~= nil,
          input = opts.args:match("-input") ~= nil,
        })
      end, {
        range = true,
        nargs = "*",
        desc = "Send code with file location and syntax highlighting",
      })
    end,
    keys = {
      {
        "<leader>ai",
        function()
          local width = math.floor(vim.o.columns * 2 / 5)
          vim.cmd(string.format('Aibo -toggle -opener="%dvsplit" codex', width))
        end,
        mode = "n",
        desc = "Toggle Codex",
      },
      { "<leader>ap", ":'<,'>AiboSendPath<CR>", mode = { "n", "v" }, desc = "Aibo: Send path only" },
      { "<leader>al", ":'<,'>AiboSendWithLocation<CR>", mode = "v", desc = "Aibo: Send with location" },
      { "<leader>ac", ":'<,'>AiboSendCode<CR>", mode = "v", desc = "Aibo: Send code with location" },
      { "<leader>as", ":'<,'>AiboSend<CR>", mode = "v", desc = "Aibo: Send selection" },
      { "<S-Tab>", "<Plug>(aibo-send)<S-Tab>", mode = { "n", "i" }, desc = "Aibo: Send input" },
    },
  },
}
