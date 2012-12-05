Require Import Syntax Monad IO.
Open Scope string_scope.

Definition main : IO () :=
  do _ <- println "Hello";
    println ", world!".
