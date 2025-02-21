# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "@hotwired/turbo", to: "turbo.min.js"
pin "rails-ujs", to: "rails-ujs.js"
pin "debounce", to: "https://ga.jspm.io/npm:debounce@1.2.1/index.js"
