Require Import Basics List.

Class Functor (F : Type -> Type) : Type := {
  fmap : forall {A B}, (A -> B) -> (F A -> F B)
  ; law : forall (A B C:Type) (f:A->B) (g:B->C) x, fmap (compose g f) x = compose (fmap g) (fmap f) x
}.

Instance ListFunctor : Functor list := {
  fmap := map
}.
Proof.
 induction x.
  reflexivity.

  simpl. rewrite IHx. reflexivity.
Defined.