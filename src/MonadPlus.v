Require Import Monad.

Class MonadPlus (M : Type -> Type) : Type := {
  monad :> Monad M
  ; mzero : forall {A}, M A
  ; mplus : forall {A:Type}, M A -> M A -> M A
  (* laws *)
  ; mzero_left : forall A f, bind (@mzero A) f = @mzero A
  ; mzero_right : forall A B (m: M A),
      bind m (fun x => (@mzero B)) = mzero
  ; monoid_left_unit : forall A (m : M A),
      mplus mzero m = m
  ; monoid_right_unit : forall A (m : M A),
      mplus m mzero = m
  ; monoid_assoc : forall A (ma mb mc : M A),
      mplus (mplus ma mb) mc = mplus ma (mplus mb mc)
}.

Instance OptionMonadPlus : MonadPlus option := {
  monad := OptionMonad
  ; mzero A := @None A
  ; mplus A m1 m2 :=
      match m1 with
      | None => m2
      | Some x => m1
      end
}.
Proof.
 reflexivity.

 destruct m; reflexivity.

 reflexivity.

 destruct m; reflexivity.

 destruct ma; reflexivity.
Defined.
