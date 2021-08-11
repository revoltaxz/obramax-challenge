[
  import_deps: [:phoenix],
  inputs: ["*.{ex,exs}", "{config,lib,test}/**/*.{ex,exs}"],
  export: [
    locals_without_parens: [add: 2, add: 3]
  ]
]
