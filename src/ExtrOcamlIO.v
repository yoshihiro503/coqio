Require Import Ascii String Streams Monad IO.

Extract Constant IO "'a" => "'a".
Extract Constant io_return => "(fun x -> x)".
Extract Constant io_bind => "(fun m f -> f m)".
Extract Constant ocaml_string => "string".
Extract Constant implode => "(fun cs -> String.concat """" (List.map (String.make 1) cs))".
Extract Constant explode => "(fun s -> let rec explode_rec n =
    if n >= String.length s then
      []
    else
      String.get s n :: explode_rec (succ n)
  in
  explode_rec 0)".

Extract Constant get_lines_aux => "let rec aux () =
    lazy begin
      try LCons (read_line (), aux ()) with
      | End_of_file -> LNil
     end
  in
  aux ()".

Extract Constant println_aux => "print_endline".
Extract Constant print_aux => "print_string".

