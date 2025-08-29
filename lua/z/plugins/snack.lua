local icons = require("z.lib.icons")
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config,
  opts = {
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        {
          icon = icons.ui.Keyboard,
          title = "Keymaps",
          section = "keys",
          indent = 2,
          padding = 1,
        },
        {
          icon = icons.documents.File,
          title = "Recent Files",
          section = "recent_files",
          indent = 2,
          padding = 1,
        },
        {
          icon = icons.documents.OpenFolder,
          title = "Projects",
          section = "projects",
          indent = 2,
          padding = 1,
        },
        { section = "startup" },
      },
    },
    explorer = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 2000,
      width = { min = 40, max = 0.4 },
      height = { min = 1, max = 0.6 },
      margin = { top = 0, right = 1, bottom = 0 },
      padding = true,
      sort = { "level", "added" },
      level = vim.log.levels.TRACE,
      style = "compact",
      top_down = true,
      date_format = "%R",
      more_format = " ↓ %d lines ",
      refresh = 50,
    },
    notify = { enabled = true },
    rename = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = false },
    words = {
      enabled = true,
      notify_end = true,
      foldopen = true,
      jumplist = true,
    },
    win = { enabled = true },
    styles = {
      notification = {},
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Tìm tệp thông minh",
    },
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Danh sách bộ đệm",
    },
    {
      "<leader>/",
      function()
        Snacks.picker.grep()
      end,
      desc = "Tìm kiếm toàn văn",
    },
    {
      "<leader>:",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Lịch sử lệnh",
    },
    {
      "<leader>n",
      function()
        Snacks.picker.notifications()
      end,
      desc = "Lịch sử thông báo",
    },
    {
      "<leader>e",
      function()
        Snacks.explorer()
      end,
      desc = "Trình khám phá tệp",
    },
    -- find
    {
      "<leader>fb",
      function()
        Snacks.picker.buffers()
      end,
      desc = "Danh sách bộ đệm",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Tìm tệp cấu hình",
    },
    {
      "<leader>ff",
      function()
        Snacks.picker.files()
      end,
      desc = "Tìm tệp",
    },
    {
      "<leader>fg",
      function()
        Snacks.picker.git_files()
      end,
      desc = "Tìm tệp Git",
    },
    {
      "<leader>fp",
      function()
        Snacks.picker.projects()
      end,
      desc = "Danh sách dự án",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent()
      end,
      desc = "Tệp gần đây",
    },
    -- git
    {
      "<leader>gb",
      function()
        Snacks.picker.git_branches()
      end,
      desc = "Danh sách nhánh Git",
    },
    {
      "<leader>gl",
      function()
        Snacks.picker.git_log()
      end,
      desc = "Nhật ký Git",
    },
    {
      "<leader>gL",
      function()
        Snacks.picker.git_log_line()
      end,
      desc = "Nhật ký Git cho dòng",
    },
    {
      "<leader>gs",
      function()
        Snacks.picker.git_status()
      end,
      desc = "Trạng thái Git",
    },
    {
      "<leader>gS",
      function()
        Snacks.picker.git_stash()
      end,
      desc = "Danh sách stash Git",
    },
    {
      "<leader>gd",
      function()
        Snacks.picker.git_diff()
      end,
      desc = "So sánh Git (Hunks)",
    },
    {
      "<leader>gf",
      function()
        Snacks.picker.git_log_file()
      end,
      desc = "Nhật ký Git cho tệp",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Dòng trong bộ đệm",
    },
    {
      "<leader>sB",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "Tìm kiếm trong các bộ đệm đang mở",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "Tìm kiếm toàn văn",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Tìm từ hoặc vùng chọn",
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        Snacks.picker.registers()
      end,
      desc = "Danh sách thanh ghi",
    },
    {
      "<leader>s/",
      function()
        Snacks.picker.search_history()
      end,
      desc = "Lịch sử tìm kiếm",
    },
    {
      "<leader>sa",
      function()
        Snacks.picker.autocmds()
      end,
      desc = "Danh sách lệnh tự động",
    },
    {
      "<leader>sb",
      function()
        Snacks.picker.lines()
      end,
      desc = "Dòng trong bộ đệm",
    },
    {
      "<leader>sc",
      function()
        Snacks.picker.command_history()
      end,
      desc = "Lịch sử lệnh",
    },
    {
      "<leader>sC",
      function()
        Snacks.picker.commands()
      end,
      desc = "Danh sách lệnh",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Chẩn đoán lỗi",
    },
    {
      "<leader>sD",
      function()
        Snacks.picker.diagnostics_buffer()
      end,
      desc = "Chẩn đoán lỗi trong bộ đệm",
    },
    {
      "<leader>sh",
      function()
        Snacks.picker.highlights()
      end,
      desc = "Danh sách tô sáng",
    },
    {
      "<leader>sH",
      function()
        Snacks.picker.highlights({ pattern = "hl_group:^Snacks" })
      end,
      desc = "Nhóm tô sáng Snacks",
    },
    {
      "<leader>si",
      function()
        Snacks.picker.icons()
      end,
      desc = "Danh sách biểu tượng",
    },
    {
      "<leader>sj",
      function()
        Snacks.picker.jumps()
      end,
      desc = "Danh sách điểm nhảy",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps()
      end,
      desc = "Danh sách phím tắt",
    },
    {
      "<leader>sl",
      function()
        Snacks.picker.loclist()
      end,
      desc = "Danh sách vị trí",
    },
    {
      "<leader>sm",
      function()
        Snacks.picker.marks()
      end,
      desc = "Danh sách đánh dấu",
    },
    {
      "<leader>sM",
      function()
        Snacks.picker.man()
      end,
      desc = "Trang hướng dẫn",
    },
    {
      "<leader>sp",
      function()
        Snacks.picker.lazy()
      end,
      desc = "Tìm cấu hình plugin",
    },
    {
      "<leader>sq",
      function()
        Snacks.picker.qflist()
      end,
      desc = "Danh sách sửa nhanh",
    },
    {
      "<leader>sR",
      function()
        Snacks.picker.resume()
      end,
      desc = "Tiếp tục tìm kiếm",
    },
    {
      "<leader>su",
      function()
        Snacks.picker.undo()
      end,
      desc = "Lịch sử hoàn tác",
    },
    {
      "<leader>uC",
      function()
        Snacks.picker.colorschemes()
      end,
      desc = "Danh sách giao diện màu",
    },
    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Đi đến định nghĩa",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Đi đến khai báo",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "Danh sách tham chiếu",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Đi đến triển khai",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Đi đến định nghĩa kiểu",
    },
    {
      "<leader>ss",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "Biểu tượng LSP",
    },
    {
      "<leader>sS",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "Biểu tượng LSP trong không gian làm việc",
    },
    -- Other
    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Bật/tắt chế độ Zen",
    },
    {
      "<leader>Z",
      function()
        Snacks.zen.zoom()
      end,
      desc = "Bật/tắt phóng to",
    },
    {
      "<leader>.",
      function()
        Snacks.scratch()
      end,
      desc = "Bật/tắt bộ đệm tạm",
    },
    {
      "<leader>S",
      function()
        Snacks.scratch.select()
      end,
      desc = "Chọn bộ đệm tạm",
    },
    {
      "<leader>n",
      function()
        Snacks.notifier.show_history()
      end,
      desc = "Lịch sử thông báo",
    },
    {
      "<leader>bd",
      function()
        Snacks.bufdelete()
      end,
      desc = "Xóa bộ đệm",
    },
    {
      "<leader>cR",
      function()
        Snacks.rename.rename_file()
      end,
      desc = "Đổi tên tệp",
    },
    {
      "<leader>gB",
      function()
        Snacks.gitbrowse()
      end,
      desc = "Duyệt Git",
      mode = { "n", "v" },
    },
    {
      "<leader>gg",
      function()
        Snacks.lazygit()
      end,
      desc = "Mở Lazygit",
    },
    {
      "<leader>un",
      function()
        Snacks.notifier.hide()
      end,
      desc = "Ẩn tất cả thông báo",
    },
    {
      "<c-/>",
      function()
        Snacks.terminal()
      end,
      desc = "Bật/tắt cửa sổ dòng lệnh",
    },
    {
      "<c-_>",
      function()
        Snacks.terminal()
      end,
      desc = "which_key_ignore",
    },
    {
      "]]",
      function()
        Snacks.words.jump(vim.v.count1)
      end,
      desc = "Tham chiếu tiếp theo",
      mode = { "n", "t" },
    },
    {
      "[[",
      function()
        Snacks.words.jump(-vim.v.count1)
      end,
      desc = "Tham chiếu trước đó",
      mode = { "n", "t" },
    },
    {
      "<leader>N",
      desc = "Tin tức Neovim",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    },
  },
  init = function()
    -- BỎ HẾT CODE CŨ VÀ THAY BẰNG CODE MỚI AN TOÀN HỠN
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup globals for debugging
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd

        -- Create toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle
          .option("background", { off = "light", on = "dark", name = "Dark Background" })
          :map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
