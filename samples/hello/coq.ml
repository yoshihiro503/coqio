type __ = Obj.t
let __ = let rec f _ = Obj.repr f in Obj.repr f

type 'm monad = { return_ : (__ -> __ -> 'm);
                  bind : (__ -> 'm -> __ -> (__ -> 'm) -> 'm) }

(** val return_ : 'a1 monad -> 'a2 -> 'a1 **)

let return_ monad0 x =
  let { return_ = return_0; bind = bind0 } = monad0 in
  Obj.magic return_0 __ x

(** val bind : 'a1 monad -> 'a1 -> ('a2 -> 'a1) -> 'a1 **)

let bind monad0 x x0 =
  let { return_ = return_0; bind = bind0 } = monad0 in
  Obj.magic bind0 __ x __ x0

type 'a show =
  'a -> char list
  (* singleton inductive, whose constructor was Build_Show *)

(** val show0 : 'a1 show -> 'a1 -> char list **)

let show0 show1 =
  show1

(** val showString : char list show **)

let showString s =
  s

type 'a iO = 'a

(** val io_return : 'a1 -> 'a1 iO **)

let io_return = (fun x -> x)

(** val io_bind : 'a1 iO -> ('a1 -> 'a2 iO) -> 'a2 iO **)

let io_bind = (fun m f -> f m)

(** val iOMonad : __ iO monad **)

let iOMonad =
  { return_ = (fun _ -> io_return); bind = (fun _ x _ -> io_bind x) }

type ocaml_string = string

(** val implode : char list -> ocaml_string **)

let implode = (fun cs -> String.concat "" (List.map (String.make 1) cs))

(** val print_aux : ocaml_string -> unit iO **)

let print_aux = print_string

(** val println_aux : ocaml_string -> unit iO **)

let println_aux = print_endline

(** val print : 'a1 show -> 'a1 -> unit iO **)

let print s x =
  print_aux (implode (show0 s x))

(** val println : 'a1 show -> 'a1 -> unit iO **)

let println s x =
  println_aux (implode (show0 s x))

(** val main : unit iO **)

let main =
  bind (Obj.magic iOMonad)
    (print showString ('H'::('e'::('l'::('l'::('o'::[])))))) (fun x ->
    println showString
      (','::(' '::('w'::('o'::('r'::('l'::('d'::('!'::[])))))))))

