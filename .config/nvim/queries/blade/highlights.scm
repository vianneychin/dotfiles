; (directive) @function
; (directive_start) @function
; (directive_end) @function
; (comment) @comment
; ((parameter) @include (#set! "priority" 110))
; ((php_only) @include (#set! "priority" 110))
; ((bracket_start) @function (#set! "priority" 120))
; ((bracket_end) @function (#set! "priority" 120))
; (keyword) @function
;

([
  (directive)
  (directive_start)
  (directive_end)
] @tag
  (#set! priority 101))

([
  (bracket_start)
  (bracket_end)
] @tag.delimiter
  (#set! priority 101))

((comment) @comment @spell (#set! priority 101))
