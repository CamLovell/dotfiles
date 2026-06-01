return {
  cmd = { "basedpyright-langserver", "--stdio" },
  on_init = function(client, _)
    client.server_capabilities.semanticTokensProvider = nil
  end,
  filetypes = { "python" },
  root_markers = { "pyproject.toml" },
  settings = {
    basedpyright = {
      disableOrganizeImports = true,
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = 'openFilesOnly',
        typeCheckingMode = 'standard',

        -- Diabble features provided by ruff
        diagnosticSeverityOverrides = {
          reportUnusedImport = false,
          -- reportMissingImports = false,
          reportMissingTypeStubs = true,
          reportUnusedVariable = false,
          reportPrivateLocalImportUsage = true,
          -- reportUnusedParameter = false,
          -- reportUnusedFunction = false,
          -- reportDuplicateImport = false,
          -- reportUnnecessaryCast = false,
          -- reportUnnecessaryComparison = false,
          -- reportUnnecessaryIsInstance = false,
          -- reportUnnecessaryTypeIgnoreComment = false,
          -- reportUnreachable = false,
        },
      },
    },
  },
}
