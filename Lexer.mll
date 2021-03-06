{

  open Lexing
  open Parser
  open Printf

  exception Error of string

  let id_or_keyword =
    let h = Hashtbl.create 30 in
    List.iter (fun (s, k) -> Hashtbl.add h s k)
      [ "true",     TRUE;
        "false",    FALSE;
      ] ;
    fun s ->
      try  Hashtbl.find h s
      with Not_found -> IDENT(s)

}

let digit = ['0'-'9']
let alpha = ['a'-'z' 'A'-'Z']
let ident = (alpha | '_') (alpha | '_' | '\'' | digit)*

rule token = parse
  | [' ' '\t' '\r' ]+
      { token lexbuf }
  | '\n'
      { new_line lexbuf; token lexbuf}
  | ident
      { id_or_keyword (lexeme lexbuf) }
  | digit+
      { LITINT (int_of_string (lexeme lexbuf)) }
  | ";"
      { SEP }
  | "<-"
      { AFF }
  | eof
      { EOF }
  | _
      {raise (Error (sprintf "Unknow Token %s" (lexeme lexbuf)))}
