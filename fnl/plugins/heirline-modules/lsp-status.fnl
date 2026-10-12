(fn [...]
  {:condition (fn []
                ((. (require :heirline.conditions) :lsp_attached)))
   :provider (fn []
               (local names {})
               (each [i server (pairs (vim.lsp.get_clients {:bufnr 0}))]
                 (table.insert names server.name))
               (.. " [ " (table.concat names " ") " ] "))
   :update [:LspAttach :LspDetach]})
