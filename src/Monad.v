Require Import Functor.

Class Monad (m : Type -> Type) : Type := {
  return_ : forall {A}, A -> m A
  ; bind : forall {A}, m A -> forall {B}, (A -> m B) -> m B
  (* monad laws *)
  ; right_unit : forall A (a : m A), a = bind a (@return_ A)
  ; left_unit : forall A (a : A) B (f : A -> m B),
      f a = bind (return_ a) f
  ; associativity : forall A (ma : m A) B f C (g : B -> m C),
      bind ma (fun x => bind (f x) g) = bind (bind ma f) g
}.

Notation "a >>= f" := (bind a f) (at level 50, left associativity).
Notation "a >> b" := (a >>= (fun _ => b)) (at level 50, left associativity).
Notation "'do' a <- e ; c" :=
  (e >>= (fun a => c)) (at level 60, right associativity).

Require Import List.
Fixpoint sequence {M : Type -> Type} {m : Monad M} {A : Type}
  (ms : list (M A)) : M (list A) :=
  match ms with
  | nil => return_ nil
  | m :: ms' => m >>= (fun x => sequence ms' >>= fun xs => return_ (x::xs))
  end.

Fixpoint sequence_ {M : Type -> Type} {m : Monad M} {A : Type}
  (ms : list (M A)) : M unit :=
  match ms with
  | nil => return_ tt
  | m :: ms' => m >> sequence_ ms' >> return_ tt
  end.

Definition mapM {M} {_ : Monad M}{A B:Type} (f:A->M B) xs :=
  sequence (fmap f xs).

Definition mapM_ {M} {_ : Monad M}{A B:Type} (f:A->M B) xs :=
  sequence_ (fmap f xs).

Instance OptionMonad : Monad option := {
  return_ := Some
  ; bind A m B f :=
      match m with
      | None => None
      | Some a => f a
      end
}.
Proof.
 destruct a; reflexivity.

 reflexivity.

 destruct ma.
  intros B f C g. destruct (f a); reflexivity.

  reflexivity.
Defined.