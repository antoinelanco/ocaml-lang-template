open SourceAst
open Printf

let rec print (prog : SourceAst.prog) : string =
  let l = Func_Tbl.fold
    (fun k el acc -> (sprintf "%s = %s" k (printVall el) ) :: acc )
    prog [] in
  String.concat "\n" l

and printVall (v : SourceAst.vall) : string =
  match v with
  | IVal i -> string_of_int i
  | BVal true -> "true"
  | BVal false -> "false"
