module Func_Tbl = Map.Make(String)

type prog = vall Func_Tbl.t

and vall =
  | IVal of int
  | BVal of bool
