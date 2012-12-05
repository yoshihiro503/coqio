Require Import Streams Ascii String.
Require Import Show Functor Monad Llist.

Variable IO : Type -> Type.
Variable io_return : forall {A : Type}, A -> IO A.
Variable io_bind : forall {A : Type}, IO A ->
  forall {B:Type}, (A -> IO B) -> IO B.

Axiom io_1 : forall A (a : IO A), a = io_bind a (@io_return A).
Axiom io_2 : forall A (a : A) B (f : A -> IO B),
      f a = io_bind (io_return a) f.
Axiom io_3 : forall A (ma : IO A) B f C (g : B -> IO C),
      io_bind ma (fun x => io_bind (f x) g) = io_bind (io_bind ma f) g.
Axiom io_aux : forall A B (f g : A -> IO B) m,
  (forall x, f x = g x) -> io_bind m f = io_bind m g.

Instance IOMonad : Monad IO := {
  return_ := @io_return
  ; bind := @io_bind
  ; right_unit := io_1
  ; left_unit := io_2
  ; associativity := io_3
}.

Instance FunctorIO : Functor IO := {
  fmap A B f m := m >>= (fun x => return_ (f x))
}.
Proof.
 intros A B C f g x.
 unfold Basics.compose. simpl.
 rewrite <- io_3.
 apply io_aux. intro a. rewrite <- io_2. reflexivity.
Defined.

Variable ocaml_string : Set.
Variable implode : string -> ocaml_string.
Variable explode : ocaml_string -> string.
Variable get_lines_aux : IO (llist ocaml_string).
Variable print_aux : ocaml_string -> IO unit.
Variable println_aux : ocaml_string -> IO unit.

Definition print {A : Set} {s : Show A} (x : A) : IO unit :=
  print_aux (implode (show x)).
Definition println {A : Set} {s : Show A} (x : A) : IO unit :=
  println_aux (implode (show x)).
Definition get_lines : IO (llist string) :=
  fmap (Llist.map explode) get_lines_aux.
