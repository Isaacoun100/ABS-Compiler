// Main code
package scanner; 
import java_cup.runtime.Symbol;
import parser.sym;    

%% // Declarations

%class absScanner
%unicode
%line
%column
%public
%type token
%ignorecase
%cup
%type java_cup.runtime.Symbol

%{


  private Symbol sym(int id) {
    return new Symbol(id, yyline+1, yycolumn+1);
  }
  private Symbol sym(int id, Object val) {
    return new Symbol(id, yyline+1, yycolumn+1, val);
  }
%}

//MACROS

OCT  = 0[0-7]+
HEX  = 0[xX][0-9a-fA-F]+
INT           = [0-9]+
REAL          = {INT}\.{INT}
SCI_INT       = {INT}[eE][+-]?{INT}
SCI_FLOAT     = {REAL}[eE][+-]?{INT}
NUMBER        = {SCI_FLOAT}|{SCI_INT}|{REAL}|{INT}

ID   =      [A-Za-z_][A-Za-z0-9_]{0,126}
TEXT =      [a-zA-Z0-9_ ]*
CHAR =      [a-zA-Z0-9_ ]

ASSIGN_OP  = ":="
WS         = [ \t\r\n\u00A0\u2007\u202F\uFEFF]+
INLINECOM  = "{" [^]* "}"
BLOCKCOM   = "(*" .*? "*)"

// %% // Rules

// "ABSOLUTE"        {return new token("KEYWORD", yytext(), yyline);}
// "CONST"           {return new token("KEYWORD", yytext(), yyline);}
// "DOWNTO"          {return new token("KEYWORD", yytext(), yyline);}
// "FUNCTION"        {return new token("KEYWORD", yytext(), yyline);}
// "INTERFACE"       {return new token("KEYWORD", yytext(), yyline);}
// "OBJECT"          {return new token("KEYWORD", yytext(), yyline);}
// "RECORD"          {return new token("KEYWORD", yytext(), yyline);}
// "THEN"            {return new token("KEYWORD", yytext(), yyline);}
// "VAR"             {return new token("KEYWORD", yytext(), yyline);}
// "AND"             {return new token("KEYWORD", yytext(), yyline);}
// "CONSTRUCTOR"     {return new token("KEYWORD", yytext(), yyline);}
// "ELSE"            {return new token("KEYWORD", yytext(), yyline);}
// "GOTO"            {return new token("KEYWORD", yytext(), yyline);}
// "INTERRUPT"       {return new token("KEYWORD", yytext(), yyline);}
// "OF"              {return new token("KEYWORD", yytext(), yyline);}
// "REPEAT"          {return new token("KEYWORD", yytext(), yyline);}
// "TO"              {return new token("KEYWORD", yytext(), yyline);}
// "VIRTUAL"         {return new token("KEYWORD", yytext(), yyline);}
// "ARRAY"           {return new token("KEYWORD", yytext(), yyline);}
// "DESTRUCTOR"      {return new token("KEYWORD", yytext(), yyline);}
// "END"             {return new token("KEYWORD", yytext(), yyline);}
// "IF"              {return new token("KEYWORD", yytext(), yyline);}
// "LABEL"           {return new token("KEYWORD", yytext(), yyline);}
// "OR"              {return new token("KEYWORD", yytext(), yyline);}
// "SET"             {return new token("KEYWORD", yytext(), yyline);}
// "TYPE"            {return new token("KEYWORD", yytext(), yyline);}
// "ASM"             {return new token("KEYWORD", yytext(), yyline);}
// "EXTERNAL"        {return new token("KEYWORD", yytext(), yyline);}
// "FILE"            {return new token("KEYWORD", yytext(), yyline);}
// "IMPLEMENTATION"  {return new token("KEYWORD", yytext(), yyline);}
// "MOD"             {return new token("KEYWORD", yytext(), yyline);}
// "PACKED"          {return new token("KEYWORD", yytext(), yyline);}
// "SHL"             {return new token("KEYWORD", yytext(), yyline);}
// "UNIT"            {return new token("KEYWORD", yytext(), yyline);}
// "BEGIN"           {return new token("KEYWORD", yytext(), yyline);}
// "DIV"             {return new token("KEYWORD", yytext(), yyline);}
// "FOR"             {return new token("KEYWORD", yytext(), yyline);}
// "IN"              {return new token("KEYWORD", yytext(), yyline);}
// "NIL"             {return new token("KEYWORD", yytext(), yyline);}
// "PRIVATE"         {return new token("KEYWORD", yytext(), yyline);}
// "WHILE"           {return new token("KEYWORD", yytext(), yyline);}
// "WITH"            {return new token("KEYWORD", yytext(), yyline);}
// "SHR"             {return new token("KEYWORD", yytext(), yyline);}
// "UNTIL"           {return new token("KEYWORD", yytext(), yyline);}
// "XOR"             {return new token("KEYWORD", yytext(), yyline);}
// "CASE"            {return new token("KEYWORD", yytext(), yyline);}
// "DO"              {return new token("KEYWORD", yytext(), yyline);}
// "FORWARD"         {return new token("KEYWORD", yytext(), yyline);}
// "INLINE"          {return new token("KEYWORD", yytext(), yyline);}
// "NOT"             {return new token("KEYWORD", yytext(), yyline);}
// "PROCEDURE"       {return new token("KEYWORD", yytext(), yyline);}
// "STRING"          {return new token("KEYWORD", yytext(), yyline);}
// "INT"             {return new token("KEYWORD", yytext(), yyline);}
// "CHAR"            {return new token("KEYWORD", yytext(), yyline);}
// "REAL"            {return new token("KEYWORD", yytext(), yyline);}
// "READ"            {return new token("KEYWORD", yytext(), yyline);}
// "WRITE"            {return new token("KEYWORD", yytext(), yyline);}
// "USES"            {return new token("KEYWORD", yytext(), yyline);}

// \"{TEXT}\"        {return new token("LITERAL", yytext(), yyline);}

// {HEX}             {return new token("NUMBER", yytext(), yyline);}

// {OCT}             { return new token("NUMBER", yytext(), yyline); }

// {NUMBER}          { return new token("NUMBER", yytext(), yyline); }

// \'{CHAR}\'        {return new token("LITERAL", yytext(), yyline);}
// “{TEXT}”          { return new token("LITERAL", yytext(), yyline); }
// ‘{CHAR}’          { return new token("LITERAL", yytext(), yyline); }

// "+"               {return new token("OPERATOR", yytext(), yyline);}
// ">"               {return new token("OPERATOR", yytext(), yyline);}
// "++"              {return new token("OPERATOR", yytext(), yyline);}
// ":"               {return new token("OPERATOR", yytext(), yyline);}
// "-"               {return new token("OPERATOR", yytext(), yyline);}
// "<="              {return new token("OPERATOR", yytext(), yyline);}
// "--"              {return new token("OPERATOR", yytext(), yyline);}
// "."               {return new token("OPERATOR", yytext(), yyline);}
// "*"               {return new token("OPERATOR", yytext(), yyline);}
// ">="              {return new token("OPERATOR", yytext(), yyline);}
// "("               {return new token("OPERATOR", yytext(), yyline);}
// "^"               {return new token("OPERATOR", yytext(), yyline);}
// "/"               {return new token("OPERATOR", yytext(), yyline);}
// "="               {return new token("OPERATOR", yytext(), yyline);}
// ")"               {return new token("OPERATOR", yytext(), yyline);}
// "**"              {return new token("OPERATOR", yytext(), yyline);}
// "<>"              {return new token("OPERATOR", yytext(), yyline);}
// ","               {return new token("OPERATOR", yytext(), yyline);}
// "["               {return new token("OPERATOR", yytext(), yyline);}
// "<"               {return new token("OPERATOR", yytext(), yyline);}
// ";"               {return new token("OPERATOR", yytext(), yyline);}
// "]"               {return new token("OPERATOR", yytext(), yyline);}

// {ID}              {return new token("IDENTIFIER", yytext(), yyline);}
// "{" [^}]* "}"     { /* Inline comment */ }
// "(*" .*? "*)"     { /* Multiblock comment */ }
// [ \t\r\n]+      { /* Ignore */ }
// .                 { return new token("ERROR", yytext(), yyline); }

%% // Rules

/* ===== Palabras reservadas necesarias para la gramática ===== */
"PROGRAM"       { return sym(sym.PROGRAM); }
"BEGIN"         { return sym(sym.BEGIN); }
"END"           { return sym(sym.END); }
"VAR"           { return sym(sym.VAR); }
"FUNCTION"      { return sym(sym.FUNCTION); }
"PROCEDURE"     { return sym(sym.PROCEDURE); }
"IF"            { return sym(sym.IF); }
"THEN"          { return sym(sym.THEN); }
"ELSE"          { return sym(sym.ELSE); }
"WHILE"         { return sym(sym.WHILE); }
"DO"            { return sym(sym.DO); }
"FOR"           { return sym(sym.FOR); }
"TO"            { return sym(sym.TO); }
"READ"          { return sym(sym.READ); }
"WRITE"         { return sym(sym.WRITE); }

/* Tipos */
"INT"           { return sym(sym.TINT); }
"REAL"          { return sym(sym.TREAL); }
"STRING"        { return sym(sym.TSTRING); }
"CHAR"          { return sym(sym.TCHAR); }

/* Operadores aritméticos y booleanos */
{ASSIGN_OP}     { return sym(sym.ASSIGN); }   // ":="
"++"            { return sym(sym.INC); }
"--"            { return sym(sym.DEC); }
"+"             { return sym(sym.PLUS); }
"-"             { return sym(sym.MINUS); }
"*"             { return sym(sym.TIMES); }
"/"             { return sym(sym.DIVIDE); }
"MOD"           { return sym(sym.MOD); }
"DIV"           { return sym(sym.INTDIV); }

"="             { return sym(sym.EQ); }
">="            { return sym(sym.GE); }
">"             { return sym(sym.GT); }
"<="            { return sym(sym.LE); }
"<"             { return sym(sym.LT); }
"<>"            { return sym(sym.NE); }
"OR"            { return sym(sym.OR); }
"AND"           { return sym(sym.AND); }
"NOT"           { return sym(sym.NOT); }

/* Signos */
"("             { return sym(sym.LPAREN); }
")"             { return sym(sym.RPAREN); }
"["             { return sym(sym.LBRACK); }
"]"             { return sym(sym.RBRACK); }
","             { return sym(sym.COMMA); }
";"             { return sym(sym.SEMI); }
":"             { return sym(sym.COLON); }
"."             { return sym(sym.DOT); }
"^"             { return sym(sym.CARET); }

/* Literales */
{HEX}                 { return sym(sym.HEX_LIT, yytext()); }
{OCT}                 { return sym(sym.INT_LIT, yytext()); }  // o un OCT_LIT si lo usas
{NUMBER}              {
  if (yytext().indexOf('.') >= 0 || yytext().indexOf('e')>=0 || yytext().indexOf('E')>=0)
    return sym(sym.REAL_LIT, yytext());
  else return sym(sym.INT_LIT, yytext());
}
\"{TEXT}\"            { return sym(sym.STR_LIT, yytext()); }
\'{CHAR}\'           { return sym(sym.CHAR_LIT, yytext()); }
/* comillas “ ” y ‘ ’ si las vas a permitir explícitamente:
“{TEXT}”              { return sym(sym.STR_LIT, yytext()); }
‘{CHAR}’             { return sym(sym.CHAR_LIT, yytext()); }
*/


/* Identificadores */
{ID}                  { return sym(sym.ID, yytext()); }

/* Comentarios y espacios */
{INLINECOM}           { /* ignore */ }
{BLOCKCOM}            { /* ignore */ }
\uFEFF               { /* ignore BOM */ }
{WS}                  { /* ignore */ }

/* Cualquier otro char = error léxico */
.                     { return sym(sym.error, yytext()); }