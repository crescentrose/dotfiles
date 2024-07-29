; extends

(
 (line_comment
   doc: (doc_comment) @injection.content
  )
 (#set! injection.language "markdown")
 (#set! injection.include-children)
 )

(
 (macro_invocation
   macro: [(scoped_identifier) (identifier)] @macro_name
   (token_tree
     (string_literal) @injection.content)
   )
 (#any-of? @macro_name
  "sqlx::query" "query"
  )
 (#set! injection.language "sql")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.include-children)
 )

(
 (macro_invocation
   macro: [(scoped_identifier) (identifier)] @macro_name
   (token_tree
     (raw_string_literal) @injection.content)
   )
 (#any-of? @macro_name
  "sqlx::query" "query"
  )
 (#set! injection.language "sql")
 (#offset! @injection.content 0 3 0 -2)
 (#set! injection.include-children)
 )

(
 (macro_invocation
   macro: [(scoped_identifier) (identifier)] @macro_name
   (token_tree
     (identifier)
     (raw_string_literal) @injection.content
     )
   )
 (#any-of? @macro_name
  "sqlx::query_as" "query_as"
  )
 (#set! injection.language "sql")
 (#offset! @injection.content 0 3 0 -2)
 (#set! injection.include-children)
 )

(
 (macro_invocation
   macro: [(scoped_identifier) (identifier)] @macro_name
   (token_tree
     (identifier)
     (string_literal) @injection.content
     )
   )
 (#any-of? @macro_name
  "sqlx::query_as" "query_as"
  )
 (#set! injection.language "sql")
 (#offset! @injection.content 0 1 0 -1)
 (#set! injection.include-children)
 )
