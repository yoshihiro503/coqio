Require Import List.

CoInductive llist (A : Type) : Type :=
  | LNil : llist A
  | LCons : A -> llist A -> llist A.

Implicit Arguments LNil [A].
Implicit Arguments LCons [A].

CoFixpoint from n := LCons n (from (S n)).

CoFixpoint map {A B:Type} (f : A -> B) xs :=
  match xs with
  | LNil => LNil
  | LCons x xs => LCons (f x) (map f xs)
  end.

Fixpoint take {A:Type} n (xs : llist A) :=
  match (n, xs) with
  | (O, _) => nil
  | (_, LNil) => nil
  | (S p, LCons x xs') => x :: take p xs'
  end.