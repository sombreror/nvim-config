-- tree-sitter-manager => installs the parsers + enables highlighting --
require("tree-sitter-manager").setup({
	auto_install = true,
	ensure_installed = {
		"lua",
		"python",
		"javascript",
		"php",
		"php_only",
		"html",
		"css",
		"typescript",
		"json",
	},
})
