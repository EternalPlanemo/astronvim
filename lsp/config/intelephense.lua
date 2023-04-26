return {
  on_attach = function(client, bufnr)
    if (client.resolved_capabilities ~= nil) then
      client.resolved_capabilities.document_formatting = false
    end
  end,
  settings = {
    intelephense = {
      environment = {
        phpVersion = "8.1.0",
      },
      files = {
        maxSize = 2000000,
      },
      completion = {
        maxItems = 100,
      }
    }
  }
}
