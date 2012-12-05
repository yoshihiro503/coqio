Require Import Monad IO.
Open Scope string_scope.

Definition main : IO unit :=
  do _ <- print "Hello"
  ; println ", world!".
