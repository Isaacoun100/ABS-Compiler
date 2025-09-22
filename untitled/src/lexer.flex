// Main code

// This object will contain the token name and line where is located

%% // Declarations

%class absScanner
%standalone

BASE = ([0-9]+'x')?[0-9]+
DIGIT = (\.[0-9]*)?
EXP = ('E'(-)?([0-9])*)?

TEXT = [a-zA-Z0-9_\n]*
%% // Rules

"ABSOLUTE"                      {System.out.println("ABSOLUTE");}
"CONST"                         {System.out.println("CONST");}
"DOWNTO"                        {System.out.println("DOWNTO");}
"FUNCTION"                      {System.out.println("FUNCTION");}
"INTERFACE"                     {System.out.println("INTERFACE");}
"OBJECT"                        {System.out.println("OBJECT");}
"RECORD"                        {System.out.println("RECORD");}
"THEN"                          {System.out.println("THEN");}
"VAR"                           {System.out.println("VAR");}
"AND"                           {System.out.println("AND");}
"CONSTRUCTOR"                   {System.out.println("CONSTRUCTOR");}
"ELSE"                          {System.out.println("ELSE");}
"GOTO"                          {System.out.println("GOTO");}
"INTERRUPT"                     {System.out.println("INTERRUPT");}
"OF"                            {System.out.println("OF");}
"REPEAT"                        {System.out.println("REPEAT");}
"TO"                            {System.out.println("TO");}
"VIRTUAL"                       {System.out.println("VIRTUAL");}
"ARRAY"                         {System.out.println("ARRAY");}
"DESTRUCTOR"                    {System.out.println("DESTRUCTOR");}
"END"                           {System.out.println("END");}
"IF"                            {System.out.println("IF");}
"LABEL"                         {System.out.println("LABEL");}
"OR"                            {System.out.println("OR");}
"SET"                           {System.out.println("SET");}
"TYPE"                          {System.out.println("TYPE");}
"ASM"                           {System.out.println("ASM");}
"EXTERNAL"                      {System.out.println("EXTERNAL");}
"FILE"                          {System.out.println("FILE");}
"IMPLEMENTATION"                {System.out.println("IMPLEMENTATION");}
"MOD"                           {System.out.println("MOD");}
"PACKED"                        {System.out.println("PACKED");}
"SHL"                           {System.out.println("SHL");}
"UNIT"                          {System.out.println("UNIT");}
"BEGIN"                         {System.out.println("BEGIN");}
"DIV"                           {System.out.println("DIV");}
"FOR"                           {System.out.println("FOR");}
"IN"                            {System.out.println("IN");}
"NIL"                           {System.out.println("NIL");}
"PRIVATE"                       {System.out.println("PRIVATE");}
"SHR"                           {System.out.println("SHR");}
"UNTIL"                         {System.out.println("UNTIL");}
"XOR"                           {System.out.println("XOR");}
"CASE"                          {System.out.println("CASE");}
"DO"                            {System.out.println("DO");}
"FORWARD"                       {System.out.println("FORWARD");}
"INLINE"                        {System.out.println("INLINE");}
"NOT"                           {System.out.println("NOT");}
"PROCEDURE"                     {System.out.println("PROCEDURE");}
"STRING"                        {System.out.println("STRING");}
"INT"                           {System.out.println("INT");}
"CHAR"                          {System.out.println("CHAR");}
"BOOLEAN"                       {System.out.println("BOOL");}
"FLOAT"                         {System.out.println("BOOL");}
"USES"                          {System.out.println("USES");}
\"{TEXT}\"                      {System.out.println("LITERAL");}
'-'?{BASE}{DIGIT}{EXP}          {System.out.println("LITERAL");}
"+"                             {System.out.println("OP_SUM");}
">"                             {System.out.println("OP_GREATER");}
"++"                            {System.out.println("OP_INCREASE");}
":"                             {System.out.println("OP_COLON");}
"-"                             {System.out.println("OP_MINUS");}
"<="                            {System.out.println("OP_LESSEQUAL");}
"--"                            {System.out.println("OP_DECREASE");}
"."                             {System.out.println("OP_PERIOD");}
"*"                             {System.out.println("OP_MULT");}
">="                            {System.out.println("OP_GREATEREQUAL");}
"("                             {System.out.println("OP_OPENPARENTHESIS");}
"^"                             {System.out.println("OP_POWER");}
"/"                             {System.out.println("OP_SLASH");}
"="                             {System.out.println("OP_EQUALS");}
")"                             {System.out.println("OR_CLOSEPARENTHESIS");}
"**"                            {System.out.println("OP_DOUBLEASTERISK");}
"<>"                            {System.out.println("OP_TYPE");}
","                             {System.out.println("OP_COMMA");}
"["                             {System.out.println("OP_OPENBRACKET");}
"<"                             {System.out.println("OP_LESS");}
";"                             {System.out.println("OP_SEMICOLON");}
"]"                             {System.out.println("OP_CLOSEBRACKET");}
"{" [^}]* "}"                   { /* Inline comment */ }
"(*" .*? "*)"                   { /* Multiblock comment */ }
.                               {System.out.println("Error");}