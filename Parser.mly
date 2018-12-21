%{

  open SourceAst

%}

%token <string> IDENT
%token <int> LITINT
%token TRUE FALSE
%token AFF
%token SEP
%token EOF

%start prog
%type <SourceAst.prog> prog

%%

prog:
| p=progs; EOF { p }

progs:
| (* empty *) { Func_Tbl.empty }
| v=var; SEP; p=progs {
    let (id, info) = v in
    Func_Tbl.add id info p
  }

var:
| id=IDENT; AFF; v=vall { (id,v) }

vall:
| i=LITINT                            { IVal(i) }
| TRUE                                { BVal(true) }
| FALSE                               { BVal(false) }
