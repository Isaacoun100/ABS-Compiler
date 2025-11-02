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
// %type token
%ignorecase
%cup
// %type java_cup.runtime.Symbol

%{
  
  private Symbol sym(int id) {
    return new Symbol(id, yyline+1, yycolumn+1);
  }
  private Symbol sym(int id, Object val) {
    return new Symbol(id, yyline+1, yycolumn+1, val);
  }
%}

//MACROS 

OCT           = 0[0-7]+
HEX           = 0[xX][0-9a-fA-F]+
INT           = [0-9]+
REAL          = {INT}\.{INT}
SCI_INT       = {INT}[eE][+-]?{INT}
SCI_FLOAT     = {REAL}[eE][+-]?{INT}
NUMBER        = {SCI_FLOAT}|{SCI_INT}|{REAL}|{INT}


TEXT =      [a-zA-Z0-9_ ]*
CHAR =      [a-zA-Z0-9_ ]


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
// las que se necesitan en la gramatica
"PROGRAM"         { return sym(sym.PROGRAM); }
"BEGIN"           { return sym(sym.BEGIN); }
"END"             { return sym(sym.END); }

"DO"              { return sym(sym.DO); }
"ELSE"            { return sym(sym.ELSE); }
"FOR"             { return sym(sym.FOR); }
"FUNCTION"        { return sym(sym.FUNCTION); }
"IF"              { return sym(sym.IF); }
"PROCEDURE"       { return sym(sym.PROCEDURE); }
"THEN"            { return sym(sym.THEN); }
"TO"              { return sym(sym.TO); }
"VAR"             { return sym(sym.VAR); }
"WHILE"           { return sym(sym.WHILE); }

"INT"             { return sym(sym.TINT); }
"REAL"            { return sym(sym.TREAL); }
"STRING"          { return sym(sym.TSTRING); }
"CHAR"            { return sym(sym.TCHAR); }

"READ"            { return sym(sym.READ); }
"WRITE"           { return sym(sym.WRITE); }

"MOD"             { return sym(sym.MOD); }      
"DIV"             { return sym(sym.INTDIV); }  

"OR"              { return sym(sym.OR); }
"AND"             { return sym(sym.AND); }
"NOT"             { return sym(sym.NOT); }

// las que no necesitamos le vamos a poner KEYWORD para simplificar el parser
"ABSOLUTE"        { return sym(sym.KEYWORD); }
"CONST"           { return sym(sym.KEYWORD); }
"DOWNTO"          { return sym(sym.KEYWORD); }
"INTERFACE"       { return sym(sym.KEYWORD); }
"OBJECT"          { return sym(sym.KEYWORD); }
"RECORD"          { return sym(sym.KEYWORD); }
"CONSTRUCTOR"     { return sym(sym.KEYWORD); }
"GOTO"            { return sym(sym.KEYWORD); }
"INTERRUPT"       { return sym(sym.KEYWORD); }
"OF"              { return sym(sym.KEYWORD); }
"REPEAT"          { return sym(sym.KEYWORD); }
"VIRTUAL"         { return sym(sym.KEYWORD); }
"ARRAY"           { return sym(sym.KEYWORD); }
"DESTRUCTOR"      { return sym(sym.KEYWORD); }
"LABEL"           { return sym(sym.KEYWORD); }
"SET"             { return sym(sym.KEYWORD); }
"TYPE"            { return sym(sym.KEYWORD); }
"ASM"             { return sym(sym.KEYWORD); }
"EXTERNAL"        { return sym(sym.KEYWORD); }
"FILE"            { return sym(sym.KEYWORD); }
"IMPLEMENTATION"  { return sym(sym.KEYWORD); }
"PACKED"          { return sym(sym.KEYWORD); }
"SHL"             { return sym(sym.KEYWORD); }
"UNIT"            { return sym(sym.KEYWORD); }
"IN"              { return sym(sym.KEYWORD); }
"NIL"             { return sym(sym.KEYWORD); }
"PRIVATE"         { return sym(sym.KEYWORD); }
"WITH"            { return sym(sym.KEYWORD); }
"SHR"             { return sym(sym.KEYWORD); }
"UNTIL"           { return sym(sym.KEYWORD); }
"XOR"             { return sym(sym.KEYWORD); }
"CASE"            { return sym(sym.KEYWORD); }
"FORWARD"         { return sym(sym.KEYWORD); }
"INLINE"          { return sym(sym.KEYWORD); }
"USES"            { return sym(sym.KEYWORD); }

//OPERADORES
":="            { return sym(sym.ASSIGN); }   
"++"            { return sym(sym.INC); }
"--"            { return sym(sym.DEC); }
"+"             { return sym(sym.PLUS); }
"-"             { return sym(sym.MINUS); }
"*"             { return sym(sym.TIMES); }
"/"             { return sym(sym.DIVIDE); }

"="             { return sym(sym.EQ); }
">="            { return sym(sym.GE); }
">"             { return sym(sym.GT); }
"<="            { return sym(sym.LE); }
"<"             { return sym(sym.LT); }
"<>"            { return sym(sym.NE); }

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

{HEX}       { return sym(sym.HEX_LIT, yytext()); }
{OCT}       { return sym(sym.OCT_LIT, yytext()); }

{NUMBER} {
  String t = yytext();
  if (t.indexOf('.') >= 0 || t.indexOf('e') >= 0 || t.indexOf('E') >= 0)
    return sym(sym.REAL_LIT, t);   // reales y reales con exponente
  else
    return sym(sym.INT_LIT, t);    // enteros decimales y cientificos de entero no existen aqui
}

\"{TEXT}\"      { return sym(sym.STR_LIT, yytext()); } 
\'{CHAR}\'      { return sym(sym.CHAR_LIT, yytext()); }

“{TEXT}”        { return sym(sym.STR_LIT, yytext()); }
‘{CHAR}’        { return sym(sym.CHAR_LIT, yytext()); }

/* Identificadores */

[A-Za-z_][A-Za-z0-9_]* {
  if (yytext().length() > 127)
    return sym(sym.ERROR, yytext());
  else
    return sym(sym.ID, yytext());
}

"{" [^}]* "}"     { /* Comment */ }
"(*" .*? "*)"     { /* Comment */ }
[ \t\r\n]+        { /* Ignore */ }
.                 { return sym(sym.ERROR, yytext()); }

