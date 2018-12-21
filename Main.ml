open Format
exception ParseErr of string

let parseerr_string = Printf.sprintf "Token : \"%s\", Line : %d, Char : %d-%d"

let ext = ".lan"

let set_file s =
  if not (Filename.check_suffix s ext)
  then raise (Arg.Bad ("no "^ext^" extension"))
  else s

let file = set_file Sys.argv.(1)
let c = open_in file
let lb = Lexing.from_channel c

let p =
  try
    Parser.prog Lexer.token lb
  with exn ->
    begin
      let tok = Lexing.lexeme lb in
      let curr = lb.Lexing.lex_curr_p in
      let line = curr.Lexing.pos_lnum in
      let cnum_d = curr.Lexing.pos_cnum - curr.Lexing.pos_bol - (String.length tok) + 1 in
      let cnum_f = cnum_d + (String.length tok) in
      raise (ParseErr (parseerr_string tok line cnum_d cnum_f))

    end

let r = Interpreter.eval p
let res = Printer.print r

let () =
  Printf.printf "%s\n" res;
  close_in c
