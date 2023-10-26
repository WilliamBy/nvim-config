M = {}
function M.setup()
	local mason_root = require("mason.settings").current.install_root_dir
	local root_markers = { ".git", "pom.xml", "mvnw", "gradlew", ".idea", ".iml", ".root", ".vscode" }
	local root_dir = vim.fs.dirname(vim.fs.find(root_markers, { upward = true })[1]) or vim.loop.cwd()
	local home = os.getenv("HOME")
	local jdtls_home = vim.fn.s
	local project_name = vim.fn.fnamemodify(root_dir, ":p:h:t")
	local jdtls_cache = vim.fn.stdpath("cache") .. "/workspace/" .. project_name
	local jdtls_jar = vim.fn.glob(mason_root .. "/packages/jdtls/plugins/*.jar")
	local jdtls_cfg = mason_root .. "/packages/jdtls/config_linux"
    local java_debug_jar = vim.fn.glob(mason_root .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar")
	-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
	local config = {
		-- The command that starts the language server
		-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
		cmd = {

			-- 💀
			"java", -- or '/path/to/java17_or_newer/bin/java'
			-- depends on if `java` is in your $PATH env variable and if it points to the right version.

			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			-- 💀
			"-jar",
			jdtls_jar,
			-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
			-- Must point to the                                                     Change this to
			-- eclipse.jdt.ls installation                                           the actual version

			-- 💀
			"-configuration",
			jdtls_cfg,
			-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
			-- Must point to the                      Change to one of `linux`, `win` or `mac`
			-- eclipse.jdt.ls installation            Depending on your system.

			-- 💀
			-- See `data directory configuration` section in the README
			"-data",
			jdtls_cache,
		},

		-- 💀
		-- This is the default if not provided, you can remove it. Or adjust as needed.
		-- One dedicated LSP server & client will be started per unique root_dir
		root_dir = require("jdtls.setup").find_root({ ".git", "pom.xml", "mvnw", "gradlew" }),

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		-- for a list of options
		settings = {
			java = {
				signatureHelp = { enabled = true },
				completion = {
					favoriteStaticMembers = {},
					filteredTypes = {
						-- "com.sun.*",
						-- "io.micrometer.shaded.*",
						-- "java.awt.*",
						-- "jdk.*",
						-- "sun.*",
					},
				},
				sources = {
					organizeImports = {
						starThreshold = 9999,
						staticStarThreshold = 9999,
					},
				},
				codeGeneration = {
					toString = {
						template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
					},
					useBlocks = true,
				},
				configuration = {
					runtimes = {
						{
							name = "JavaSE-1.8",
							path = "/usr/local/jdk-drg8",
							default = true,
						},
						{
							name = "JavaSE-17",
							path = "/usr/lib/jvm/zulu17",
						},
					},
				},
			},
		},

		-- Language server `initializationOptions`
		-- You need to extend the `bundles` with paths to jar files
		-- if you want to use additional eclipse.jdt.ls plugins.
		--
		-- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
		--
		-- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
		init_options = {
			bundles = {
                java_debug_jar
            },
		},
	}
	local _jdtls, jdtls = pcall(require, "jdtls")
	if not _jdtls then
		config.root_dir = require("lspconfig.util").root_pattern(root_markers)
		require("lspconfig").jdtls.setup(config)
		return
	end
	jdtls.start_or_attach(config)
end

return M
