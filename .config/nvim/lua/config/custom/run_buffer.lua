local va = vim.api
local HOME = vim.env.HOME
local t_fts = {
  sh = {
    command = "bash --noprofile --norc %s %s",
    input = HOME .. "/repos/bash-playground/bash-scratch.sh",
  },
  lua = {
    command = string.format('bash --noprofile --norc -c "%s %%s %%s"', vim.env.HOME .. "/luajit21/bin/luajit"),
    input = HOME .. "/repos/lua-playground/lua-scratch.lua",
  },
  php = {
    command = [[
      php -d opcache.enable=1 \
      -d opcache.enable_cli=1 \
      -d opcache.jit_buffer_size=256M \
      -d opcache.validate_timestamps=0 \
      -d opcache.fast_shutdown=1 \
      -d opcache.jit=tracing \
      -d mysqlnd.collect_statistics=0 %s %s
    ]],
    input = HOME .. "/repos/php-playground/src/php-scratch.php",
  },
  dart = {
    command = "dart --enable-asserts %s %s",
    input = HOME .. "/repos/dart-playground/playground/bin/playground.dart",
  },
  go = {
    command = "go run %s %s",
    input = HOME .. "/repos/go-playground/playground/main.go",
  },
  v = {
    command = "v crun %s %s",
    input = HOME .. "/repos/v-playground/v_scratch/src/main.v",
  },
  c = {
    command = "tcc -run %s %s",
    input = HOME .. "/repos/c-playground/playground.c",
  },
  perl = {
    command = "perl %s %s",
    input = HOME .. "/repos/perl-playground/playground.pl",
  },
  javascript = {
    command = "bun %s %s",
    input = HOME .. "/repos/javascript-playground/index.ts",
  },
  typescript = {
    command = "bun %s %s",
    input = HOME .. "/repos/javascript-playground/index.ts",
  },
  ruby = {
    command = "ruby %s %s",
    input = HOME .. "/repos/ruby-playground/playground",
  },
  html = {
    command = "cha %s %s", -- second formatter is not used.
    input = HOME .. "/repos/html-playground/scratch.html",
  },
}

function RunBuffer(file, filetype, args)
  args = args or ""
  if t_fts[filetype] then
    local command = string.format(t_fts[filetype].command, file, args)
    Snacks.terminal(command, { auto_close = false })
  else
    vim.notify("This filetype has no runner associated!")
  end
end

va.nvim_create_user_command("RunBufferAsScript", function(opts)
  RunBuffer(vim.fn.expand("%"), vim.bo.filetype, opts.args)
end, {
  force = true,
  nargs = "*",
})

va.nvim_create_user_command("New", function(opts)
  vim.cmd.edit(t_fts[opts.fargs[1]].input)
end, {
  force = true,
  nargs = 1,
  complete = function()
    return vim.tbl_keys(t_fts)
  end,
})

vim.keymap.set("n", "<Leader>rr", function()
  RunBuffer(vim.fn.expand("%"), vim.bo.filetype)
end, { desc = "Run buffer as script" })

vim.keymap.set("n", "<Leader>ra", ":RunBufferAsScript ", { desc = "Run buffer as script with arguments" })
