type __ = Obj.t

type 'm monad = { return_ : (__ -> __ -> 'm);
                  bind : (__ -> 'm -> __ -> (__ -> 'm) -> 'm) }

val return_ : 'a1 monad -> 'a2 -> 'a1

val bind : 'a1 monad -> 'a1 -> ('a2 -> 'a1) -> 'a1

type 'a show =
  'a -> char list
  (* singleton inductive, whose constructor was Build_Show *)

val show0 : 'a1 show -> 'a1 -> char list

val showString : char list show

type 'a iO = 'a

val io_return : 'a1 -> 'a1 iO

val io_bind : 'a1 iO -> ('a1 -> 'a2 iO) -> 'a2 iO

val iOMonad : __ iO monad

type ocaml_string = string

val implode : char list -> ocaml_string

val print_aux : ocaml_string -> unit iO

val println_aux : ocaml_string -> unit iO

val print : 'a1 show -> 'a1 -> unit iO

val println : 'a1 show -> 'a1 -> unit iO

val main : unit iO

