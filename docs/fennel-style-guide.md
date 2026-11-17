# Fennel Style Guide — Operator Reference

> Derived from the official Fennel style guide: <https://fennel-lang.org/style>
> (CC BY-NC-SA 3.0, © 2007–2011 Taylor R. Campbell, © 2021–2023 Phil Hagelberg
> and contributors; based on the Lisp Style Guide by Taylor R. Campbell.)
>
> This file is a restructured, LLM-oriented rendering of that page. It is not a
> verbatim copy: rules are normalized into `MUST` / `SHOULD` / `AVOID` /
> `PREFER` form, given stable IDs, and paired with concrete Fennel examples.

---

## 0. How an agent should use this document

1. **Precedence.** Correctness > this guide > local file conventions. The guide
   itself says its advice is "a starting point rather than a set of universal
   rules"; use judgement and context.
2. **Tie-breaker.** If you are unsure how to format something, run
   `fennelfmt --check` (configuration in `.fennelfmt.fnl`). When the formatter
   and this document disagree, the formatter wins; §14 lists every place where
   this repository deviates from the upstream layout.
3. **Verify.** After writing Fennel, always check it compiles:
   `fennel --compile file.fnl > /dev/null`. Never emit code you have not
   compiled. Two caveats: (a) blocks in this document marked `;; Don't:` are
   *intentionally* invalid and will fail to parse; (b) macro-module examples
   (code built with syntax-quote, `#`-suffixed gensyms) only compile through
   `import-macros`/`require-macros`, not through `fennel --compile` on a plain
   module. In this repository, `fennel-ls` also reads `flsproject.fnl` and will
   flag unknown globals.
4. **Language model defaults are wrong here.** Do not apply habits from
   JavaScript/Python/Rust/Go/Java: no CamelCase, no `is-` predicate prefixes, no
   `const`-style markers, no closing-bracket-on-its-own-line, no tabs, no
   `when` for value-returning code.
5. **Mental model.** Fennel is Lua semantics + Lisp syntax. Closures and tables
   are *everything*. Structure is conveyed by indentation, not by delimiter
   counting. Write trees, not sequences of statements.

Rule IDs are stable: `PAREN-2`, `IND-3`, etc. Cite them when explaining changes.

---

## 1. Machine-checkable checklist (run before returning code)

| # | Check | Rule |
|---|-------|------|
| 1 | No tab characters; spaces only | PAREN-1 |
| 2 | No trailing whitespace; LF line endings; no stray `\r` | PAREN-1 |
| 3 | No space after `(` / `[` / `{`, none before `)` / `]` / `}` | PAREN-2 |
| 4 | Any text adjacent to a delimiter is separated by exactly one space | PAREN-2 |
| 5 | No line consists only of closing delimiters | PAREN-3 |
| 6 | Body-taking forms are indented 1 space, never aligned under the condition | IND-2 |
| 7 | Call arguments are not aligned; continuation lines step one space in | IND-3 |
| 8 | Lines ≤ 120 columns | LEN-1 |
| 9 | One blank line between top-level forms; adjacent top-level `local`s may be grouped | BLANK-1 |
| 10 | No blank lines inside a function, except before a nested `fn`, or to separate `if`/`match` branches | BLANK-2 |
| 11 | Identifiers are lowercase, hyphen-separated; no CamelCase | NAME-1 |
| 12 | Exported-to-Lua fields may use underscores, internal names may not | NAME-2 |
| 13 | Predicates end in `?`; no `is-` prefix (unless exported to Lua) | NAME-4 |
| 14 | Destructive functions / I/O end in `!` | NAME-5 |
| 15 | `local` only at module top level; `let` inside functions | MOD-2 |
| 16 | All `require` calls at the top of the file | MOD-1 |
| 17 | Module table is constructed at the bottom of the file | MOD-3 |
| 18 | Module returns a table | MOD-6 |
| 19 | `when` only for side-effecting bodies; `if` for value-returning ones | FORM-1 |
| 20 | Comparisons use `<` / `<=`; `>` / `>=` avoided | FORM-7 |
| 21 | No multi-line `#(...)` hashfn; no long-form `(hashfn …)`; prefer `partial` | FORM-9 |
| 22 | No `require-macros`, no `eval-compiler` | FORM-12 |
| 23 | No `lua` special form except as an explicitly marked temporary hack | FORM-13 |
| 24 | `(. t k)` / `(: t k)` only when `t.k` / `(t:k)` cannot compile | FORM-5 |
| 25 | `:colon-strings` for opaque names (keys, enums); `"quoted"` for content-bearing text | FORM-10 |
| 26 | `var` declared close to its use; no page-long reach | FORM-4 |

---

## 2. Parentheses and delimiters

**PAREN-1 (MUST).** Indent with spaces, never tabs. No trailing whitespace. Unix
line endings (LF); no carriage returns.

**PAREN-2 (MUST).** Spacing around delimiters is *outside-in*: separate
delimiters from surrounding text with one space; never pad inside.

```fennel
;; Don't:                         ;; Do:
(foo(bar baz)quux)                (foo (bar baz) quux)
(foo ( bar baz ) quux)            (let [x 1] (+ x 2))
(let [ x 1 ] (+ x 2))
```

**PAREN-3 (MUST).** Never put closing delimiters on their own line. Closing
delimiters stack at the end of the last line of content.

```fennel
;; Don't:
(fn factorial [x]
  (if (< x 2)
      1
      (* x (factorial (- x 1
                      )
           )
      )
  )
)

;; Do:
(fn factorial [x]
  (if (< x 2)
      1
      (* x (factorial (- x 1)))))
```

The guide's framing, worth recalling: Lisp programmers do not read delimiters
individually — they read the higher-level tree as expressed by indentation.
Haphazard delimiters are jarring because the reader never intended to look at
them.

### PAREN-4 — Two narrow, opt-in exceptions

Do not invoke these unless you know what you are doing. They do **not** make the
`PAREN-3` counter-example legal.

1. **Commenting out a fragment with line comments** may require breaking before a
   run of closing delimiters:

```fennel
(fn foo [bar]
  (munge [(frob bar)
          (zork bar)
          ;; (zap bar)
          ]))
```

2. **Very long tables** may break immediately after the opening delimiter and
   immediately before the closing one. This eases maintenance and makes version
   diffs clearer:

```fennel
(local color-names ; Add more color names to this list!
       [
        :blue
        :cerulean
        :green
        :magenta
        :purple
        :red
        :scarlet
        :turquoise
        ])
```

---

## 3. Indentation and alignment

**Repository override.** This config indents bodies with **one** space and does
not align call arguments (`:indent 1`, `:align-calls? false` in `.fennelfmt.fnl`).
The rules below keep the upstream rationale, but the examples show the layout
this repository actually uses.

**IND-1 (MUST).** The callee (first element after the opening paren) decides how
the remaining forms are indented. Two regimes exist: *body* forms and
*non-body* forms.

**IND-2 (MUST).** If the callee is a special form or macro that accepts a body,
indent the body **one space** from the opening paren. Never align a body under
the condition. Body-taking forms in Fennel include `fn`, `lambda`, `when`,
`unless`, `do`, `each`, `for`, `while`, `match`, `case`, `let`-style forms with
bodies inside bindings, `with-open`, `fcollect`, `icollect`, `collect`, `doto`,
`->`-family when threading a body, etc.

```fennel
;; Don't:
(when condition
      (print "Running the thing!")
      (run :the-thing))

;; Do:
(when condition
 (print "Running the thing!")
 (run :the-thing))

(with-connection [s "https://fennel-lang.org"]
 (parse (read-body s)))
```

**IND-2a (SHOULD).** To determine whether a given form takes a body, consult the
Fennel reference or call `(fennel.syntax)` — it returns a table of form names,
some with `:body? true`. For your own macros, prefix the name with `with-` or
`def` so third-party tools (editors, `fennelfmt`) recognize it as body-taking.

**IND-3 (MUST).** Upstream aligns each argument under the first one; this
repository disables that. Every continuation line steps **one space** past the
opening paren, regardless of where the first argument sits.

```fennel
;; Don't: upstream alignment, not used here
(+ (sqrt -1)
   (* x y)
   (+ p q))

;; Do: what fennelfmt produces here
(+ (sqrt -1)
 (* x y)
 (+ p q))

(+
 (sqrt -1)
 (* x y)
 (+ p q))
```

**IND-4 (MUST).** Indentation must express structure unambiguously. If a reader
cannot derive the tree from indentation alone, fix the indentation (or split the
expression).

---

## 4. Line length

**LEN-1 (SHOULD).** Keep lines ≤ **120 columns** (`:line-length 120` in
`.fennelfmt.fnl`; Lua uses 100 through `stylua.toml`). Upstream suggests 80:
readability drops on long lines, and narrow lines respect readers who must use
large fonts. Break the expression rather than the rule.

---

## 5. Blank lines

**BLANK-1 (MUST).** Separate top-level forms with exactly one blank line
(two line breaks). Exception: a run of related top-level `local` requires can be
grouped with no blank lines between them.

**BLANK-2 (SHOULD).** Inside a function, avoid blank lines, with two exceptions:

- immediately before a nested `fn` definition;
- between several test/body pairs of an `if` or `match`/`case` that would
  otherwise be hard to tell apart.

```fennel
(local box (require :box))
(local line (require :line))

(fn draw-boxes [scene]
  (match (get-box scene.boxes)
    [first-box second-box third-box & _]
    (draw-first-boxes first-box second-box third-box)

    [first-box second-box]
    (draw-two-boxes first-box second-box)

    [box] nil ; single box does not get drawn

    nil (draw-empty-room)))

(fn draw [scene]
  (draw-boxes scene)
  (lines.draw-lines scene.lines)
  (box.draw-overlay scene))

{: draw}
```

---

## 6. Names

**NAME-1 (MUST).** Identifiers are lower-case words joined by hyphens.
CamelCase is frowned upon. Do not abbreviate unless the binding's scope is short:
the greater the distance between definition and use, the more descriptive the
name must be.

**NAME-2 (MUST).** Hyphens are the default; **underscores only** in fields that
are exported for consumption by Lua code (Lua's identifier rules make hyphenated
field access tedious). Use underscores **only** in the exported name, not
internally.

```fennel
;; Don't:
(local XMLHttpRequest (make-request))
(macro for-each [t ...] nil)
(fn append_map [t f] nil)

;; Do:
(local xml-http-request (make-request))
(macro for-each [t ...] nil)
{:append_map append-map} ; when exporting a module for Lua code
```

**NAME-3 (MUST).** Do not mark constants specially. Every `local` is already
constant unless declared with `var`.

**NAME-3a (MUST).** A function intended to be stored in a table and take that
table as its first argument must name the first argument `self` (mirroring Lua's
implicit `function tbl:f()`).

**NAME-3b (SHOULD).** Name ignored parameters `_`, or better, a descriptive name
starting with `_`. Name values that may be nil with a leading `?`. Only `lambda`
and `match` make the compiler care, but the convention still informs human
readers everywhere.

### 6.1 "Funny characters" (punctuation suffixes)

**NAME-4 — Question mark = predicate (MUST).** A function that asks a question
and returns a boolean is a *predicate*: suffix `?`. Pronounce it "huh":
`(pair? object)` → "pair-huh object". Never name predicates `is-foo`; the `is-`
prefix is a workaround from languages that forbid `?` in identifiers. Exception:
the `is-` prefix is allowed when exporting a function meant to be called from
Lua.

**NAME-5 — Exclamation mark = destructive (MUST).** Suffix `!` for functions
whose primary purpose is to mutate a table or perform I/O. Do not scatter `!`
over any function that merely has a side effect: reserve it for functions that
exist *solely* for destructive update, or to distinguish the destructive variant
from a purely functional sibling. Pronounce it "bang": `(append! contents
new-contents)` → "append-bang".

**NAME-6 — Asterisk = variant (AVOID unless unavoidable).** `*` marks a
variation on a theme. Prefer a meaningful name; the asterisk explains nothing
and effectively means "I couldn't name this".

**NAME-7 — Arrow = conversion (MUST).** Functions converting one thing to
another put `->` in the middle: `bytes->table` ("bytes to table"). Never put
`->` at the end of an identifier unless it is a threading macro that behaves like
`->`.

---

## 7. Comments

**COMMENT-1 (MUST).** Semicolon count encodes scope:

| Semicolons | Use |
|---|---|
| `;;;` (3+) | Section heading |
| `;;` (2) | A whole-line comment that is not a section heading |
| `;` (1) | Trailing comment on the same line as code |

```fennel
;;; Frob Grobl

;; This section of code has some important implications:
;;   1. Foo.
;;   2. Bar.
;;   3. Baz.

(fn fnord [zarquon]
  ;; If zob, then veeblefitz.
  (quux zot
        mumble             ; Zibblefrotz.
        frotz))
```

**COMMENT-2 (SHOULD).** Comment only where the code cannot explain itself.
Prefer self-explanatory code. Most comments should answer **why**, not how;
comments carry context, not description.

---

## 8. Docstrings

**DOC-1 (MUST).** Every function in a library's public API has a docstring.

**DOC-2 (MUST).** Format:

- first line = concise summary of purpose;
- following lines = detail;
- prose is **not** indented;
- code examples **are** indented;
- mention argument types, and the return type when there is one.

**DOC-3 (MUST).** Do not extract docstrings and publish them as "the
documentation". Docstring exports, if any, supplement hand-written human
documentation (per <https://jacobian.org/2009/nov/10/what-to-write/>).

**DOC-4 (SHOULD).** Write docstrings assuming they are read in a REPL or editor,
not rendered in a browser.

---

## 9. Fennel-specific idioms

**FORM-0 (MUST).** You can write OOP in Fennel, but do not import OOP habits
wholesale. Evaluate the aspects separately: encapsulation is good and should be
used everywhere; inheritance is usually a mistake and must not be inseparably
bound to classes; polymorphism is occasionally useful but a poor default.

**FORM-1 (MUST).** Do not use `when` unless the body is specifically
side-effecting. Use `if` for value-returning conditionals. Read `do` (implicit in
`when`) as a marker for side-effecting code.

```fennel
;; Don't: value-returning `when`
(when (> x 0) (.. "positive: " x))

;; Do:
(if (> x 0) (.. "positive: " x) "non-positive")
```

**FORM-2 (SHOULD).** Do not overuse arrow forms (`->`, `->>`, `-?>` …). They fit
a pipeline of operations on one consistent subject. If the subject changes
mid-pipeline, switch to `let`. If naming intermediate steps with `let` makes the
code clearer, do not use an arrow.

**FORM-3 (MUST).** Use relative requires when one module of a multi-file library
depends on another, so the code can be relocated inside an application's
directory structure.

**FORM-3a (MUST).** Avoid sequential tables with gaps (`nil` holes) where
possible; they are a frequent source of bugs.

**FORM-3b (SHOULD).** Separate side-effecting functions from value-returning
functions. Counter-example: Lua's `setmetatable` both mutates and returns the
table — good Lua style (no `doto` in Lua), *not* good Fennel style.

**FORM-3c (SHOULD).** When designing APIs, prefer starting permissive: loosening
restrictions later is backward-compatible, adding them is not.

**FORM-4 (MUST).** Scope `var` as tightly as possible. If a `var` is used more
than about a page away from its definition, restructure the code.

**FORM-5 (MUST).** Use `(. foo :bar)` only when `foo.bar` cannot be used because
the field name is not known at compile time or the table is not a symbol. Do not
call `(: foo :bar)` when `(foo:bar)` works.

**FORM-6 (SHOULD).** Remember that returning multiple values reduces reuse in
some contexts:

```fennel
(fn get-box []
  (let [next-box (table.remove box-queue)
        remaining? (< 0 (length box-queue))]
    (values {} remaining?)))

(table.insert boxes (get-box))
;; bad argument #2 to 'insert' (number expected, got table)
```

**FORM-6a (MUST).** Prefer destructuring over `.` field access.

```fennel
;; Don't:
(let [box (. (get-boxes) 1)
      address (. (get-label) :address)]
  ...)

;; Do:
(let [[box] (get-boxes)
      {: address} (get-label)]
  ...)
```

**FORM-7 (MUST).** Use `<` and `<=`; avoid `>` and `>=`. Read `<` as "are these
numbers in increasing order?", not "is the second greater than the first?" It
accepts any number of arguments and the increasing-order reading is the intuitive
one; `>` asks whether the arguments are in reverse order, which is harder to
parse mentally. (Prefix notation breaks the infix "big end points at the bigger
value" mnemonic.)

```fennel
;; Don't:                          ;; Do:
(> 0 count)                        (< 0 count)
(>= x max)                         (<= max x)
```

**FORM-8 (MUST).** Avoid `= 0 (length t)` for emptiness checks; the idiomatic
and faster form is:

```fennel
(= nil (next t))
```

**FORM-9 (MUST).** Do not use `#(this-style)` for a function longer than a single
line. Never write the long form `(hashfn …)`; only the shorthand exists in
practice. Prefer `partial` to hashfn shorthand where possible.

**FORM-10 (MUST).** `:this-style` and `"this-style"` compile identically but read
differently:

| Syntax | Use for |
|---|---|
| `"quotation marks"` | strings whose **contents matter** |
| `:colon-style` | opaque names — table keys, enums, tags, flags |

Fennel has no keyword type; strings act as keywords, hence the colon form in key
position.

**FORM-10a (NOTE).** The colon is not glued to the name: `:word` and `: word`
read as the same string. So `{:header header}` and `{: header}` compile to the
same table, and `fennelfmt` normalizes the first into the second whenever a
keyword key is paired with a symbol of the same name. That output is valid, not
a formatter bug:

```fennel
{:foo foo :bar 2}   ; fennelfmt prints   {: foo :bar 2}
                     ; both compile to    {foo = foo, bar = 2}
```

Verified with the vendored compiler:

```lua
require('hotpot.vendor.fennel').compileString('{:foo foo :bar 2}')
-- => "return {foo = foo, bar = 2}"
require('hotpot.vendor.fennel').compileString('{: foo :bar 2}')
-- => "return {foo = foo, bar = 2}"
```

**FORM-12 (MUST).** Do not use `require-macros` or `eval-compiler`.

**FORM-13 (MUST).** The `lua` special form exists to port imperative code
quickly; never use it except as a temporary, explicitly-marked hack. Prefer
rewriting in Fennel.

```fennel
;; Acceptable only transiently, with intent visible:
(local width (lua "some.imperative.thing()")) ; TODO: port to Fennel
```

**FORM-14 (MUST).** Whenever possible, separate I/O from pure logic: perform I/O
at the edges of the program rather than deep inside (see also FORM-3b, ERR-2).

---

## 10. Modules

**MOD-1 (MUST).** Gather all top-level `require` calls at the top of the file so
dependencies are visible at a glance.

**MOD-2 (MUST).** Use `local` **only** at module top level, to avoid indenting the
whole module. Inside functions use `let`. If you are tempted to use `local`
inside a function to reduce indentation, the function is too big — split it.

**MOD-3 (MUST).** Build the module table at the **bottom** of the file, not at the
top with incremental additions. Rationale: one place shows everything the module
exports.

**MOD-4 (MUST).** Export the bare minimum. In a library, every module is part of
the public API unless its name contains `internal` or `private`.

**MOD-5 (MUST).** Name fields assuming the module is bound to a local matching the
last path segment. Module `blaster.input` is required as
`(local input (require :blaster.input))`, so expose `get`, not `get-input`,
and call it as `(input.get)`.

**MOD-6 (MUST).** Always return a table from a module, never a bare function —
even when a function seems sufficient today.

**MOD-7 (MUST).** Loading a module must have **no side effects**. Modules are
tables and can be mutated at runtime; resist that except when reloading the whole
module.

**MOD-7a (SHOULD).** Requiring with top-level destructuring interferes with
module reloading:

```fennel
(local {: view} (require :fennel))
```

Often fine (e.g. for `:fennel`), but know the trade-off.

**MOD-8 (SHOULD).** Exposing data to the REPL via a global is often useful, but
the program must never read that global except to preserve state across reloads.
Avoid the `global` special form; prefer table access on `_G`.

**MOD-9 (MUST).** Project layout: library files in `src/`, tests in `test/`,
shell-launched scripts in `bin/`. Do not build a single file that doubles as both
library and CLI — use `--require-as-include` to produce single-file scripts
instead.

---

## 11. Error handling

**ERR-1 (SHOULD).** Preferred style for *expected* failures (missing file, closed
socket): return multiple values — `nil` plus a message. Call such functions inside
`case` (older Fennel: `match` with a `(nil msg)` branch) so success and failure
sit side by side; use `case-try` for a chain of potentially-failing calls.

```fennel
(case (open-file path)
  file (process file)
  (nil msg) (print "could not open:" msg))
```

**ERR-2 (MAY, with care).** When an expected failure is unrecoverable, `assert` /
`error` aborts quickly instead of threading return values up a long stack. This is
acceptable but produces "spooky action at a distance"; manual propagation is more
explicit but verbose. Weigh the trade-off, and keep I/O at the program's edges.

**ERR-3 (MUST).** Never let `assert`/`error` substitute for control flow that the
caller is expected to handle.

---

## 12. Macros

**MACRO-1 (MUST).** Know Fennel's [values](https://fennel-lang.org/values) before
designing macros. Lexical scoping is foundational; a macro that obscures it needs
rework.

**MACRO-2 (MUST).** Minimize surprise. A reader should be able to guess what the
macro means from the call site.

**MACRO-3 (MUST).** Preserve the language invariant: parentheses mean only (a)
calling a function/macro and (b) binding multiple values. A macro that violates
this feels foreign.

**MACRO-4 (MUST).** Before writing a macro, write out the intended macroexpansion
in detail, then the intended call site. Frequently the expansion is perfectly
acceptable as code and the macro is unnecessary.

**MACRO-5 (MUST).** Never provide functionality that can *only* be reached from a
macro. A macro is a more convenient notation for something already expressible
with functions.

**MACRO-6 (MUST).** If the expansion depends on another module, include the
`require` inside the expansion, so the macro works in modules lacking a top-level
require for it.

```fennel
;; In a macro module:
(fn macro2 [x f]
  `(let [{:munge munge# :process process#} (require :mylib)
         val# (munge# ,x)]
     (print "Processing:" val#)
     (process# (,f val#))))

{: macro2}
```

**MACRO-7 (MUST).** Do not introduce identifiers "out of thin air". If the macro
binds a local, take its name as an argument — ideally as a binding table shaped
like `let` or `with-open`.

**MACRO-8 (MUST).** Build code with quoting (`` ` `` and `,`), not by calling
`list` and `sym`.

---

## 13. Anti-pattern → correction table

| Anti-pattern | Correction | Rule |
|---|---|---|
| Tabs / trailing spaces / CRLF | Spaces, LF, trimmed lines | PAREN-1 |
| `(foo ( bar ) quux)` | `(foo (bar) quux)` | PAREN-2 |
| `))))` stacked on separate lines | Close on the last content line | PAREN-3 |
| `(when cond\n      body)` | Body indented 1 space | IND-2 |
| Arguments aligned under the first one | One space in, no alignment | IND-3 |
| 140-column lines | Wrap at ≤ 120 | LEN-1 |
| Blank lines scattered in a body | Remove (keep only the two exceptions) | BLANK-2 |
| `XMLHttpRequest`, `append_map` (internal) | `xml-http-request`, `append-map` | NAME-1/2 |
| `is-empty` | `empty?` | NAME-4 |
| `sort-by` that mutates | `sort-by!` | NAME-5 |
| `process*` meaning "other process" | Descriptive name | NAME-6 |
| `table-of-bytes` converter | `bytes->table` | NAME-7 |
| `;` heading, `;;;` inline | `;;;` heading, `;;` line, `;` inline | COMMENT-1 |
| `when` used as an expression | `if` | FORM-1 |
| `(> 0 n)` | `(< 0 n)` | FORM-7 |
| `(= 0 (length t))` | `(= nil (next t))` | FORM-8 |
| Multi-line `#(…)`, `(hashfn …)` | Named `fn` / `partial` | FORM-9 |
| `"key"` as an opaque table key | `:key` | FORM-10 |
| `(. t :k)` where `t.k` compiles | `t.k` | FORM-5 |
| `(lua "return x")` | Rewrite in Fennel | FORM-13 |
| `local` inside a function | `let`, or split the function | MOD-2 |
| Module table at top, mutated later | Return table literal at bottom | MOD-3 |
| `(fn [] …)` returned as a module | Return a table with fields | MOD-6 |
| Top-level `require` mid-file | Move all requires to top | MOD-1 |
| `(set _G.x 1)` read at runtime | Keep globals REPL-only | MOD-8 |
| `(local ok v) (pcall f)` unchecked chain | `case` / `case-try` | ERR-1 |
| `is-foo` exported to Lua callers | Allowed; document it | NAME-4 |

---

## 14. Local conventions for this repository

These refine the guide for `/Users/tokyob0t/.config/nvim` (Neovim config,
`fnl/` → Fennel compiled on load, `flsproject.fnl`, `stylua.toml` for Lua only).

- **Width.** `.fennelfmt.fnl` sets `:line-length 120` for Fennel; `stylua.toml`
  sets `column_width = 100` for Lua. Do not mix them.
- **Indent.** Fennel uses **1 space** (`:indent 1`); Lua uses 4
  (`indent_width = 4`). Both forbid tabs.
- **Alignment.** `:align-calls? false`: call arguments are never aligned under
  the first one, and multi-line tables put each key on its own line.
- **Formatter.** `fennelfmt` is the gate: `fennelfmt --check fnl/**/*.fnl` before
  committing, `--fix` to apply. `.fennelfmt.fnl` also declares
  `:extra-forms {:plugin! :body}` so `(plugin! repo {...})` indents its spec as a
  body. `plugin!` is a macro of this repo (see §12), not upstream Fennel.
- **Quotes.** `quote_style = "AutoPreferSingle"` is Lua-only; Fennel strings use
  double quotes for content and `:colons` for opaque keys (FORM-10).
- **Globals.** `flsproject.fnl` allows `vim` as a global. Do not add others; use
  `_G` table access if truly necessary (MOD-8).
- **Modules.** One component per file under `fnl/plugins/**`; each returns a
  table-shaped component (MOD-6), with `require` at top (MOD-1) and the return
  value at the bottom (MOD-3).
- **Examples.** Code blocks outside §3 keep upstream's two-space layout because
  they illustrate rules (blank lines, naming, idioms), not exact spacing. When
  generating code, `fennelfmt` decides.
- **Formatting escape hatch.** If a construct cannot fit 120 columns without
  becoming unreadable, prefer restructuring over fighting the formatter; as a
  last resort, match `fennelfmt`'s output exactly.

---

## 15. What this guide does not decide

- Naming a domain concept (only the *shape* of naming is prescribed).
- Whether to use `match` vs `case` in a given Fennel version — check the target
  version's reference.
- Comment volume beyond "only where needed".
- Project layout beyond `src/`, `test/`, `bin/`.

When in doubt: write the tree so its indentation alone explains it, keep it under
120 columns, compile it, and let `fennelfmt` be the tie-breaker.

---

*Source: <https://fennel-lang.org/style> — CC BY-NC-SA 3.0. See the original for
the authoritative wording and attribution.*
