// Main code
package scanner; 
import obj.token;
// This object will contain the token name and line where is located

%% // Declarations

%class absScanner
%unicode
%line
%column
%public
%type token
%ignorecase

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
%% // Rules

"ABSOLUTE"        {return new token("KEYWORD", yytext(), yyline);}
"CONST"           {return new token("KEYWORD", yytext(), yyline);}
"DOWNTO"          {return new token("KEYWORD", yytext(), yyline);}
"FUNCTION"        {return new token("KEYWORD", yytext(), yyline);}
"INTERFACE"       {return new token("KEYWORD", yytext(), yyline);}
"OBJECT"          {return new token("KEYWORD", yytext(), yyline);}
"RECORD"          {return new token("KEYWORD", yytext(), yyline);}
"THEN"            {return new token("KEYWORD", yytext(), yyline);}
"VAR"             {return new token("KEYWORD", yytext(), yyline);}
"AND"             {return new token("KEYWORD", yytext(), yyline);}
"CONSTRUCTOR"     {return new token("KEYWORD", yytext(), yyline);}
"ELSE"            {return new token("KEYWORD", yytext(), yyline);}
"GOTO"            {return new token("KEYWORD", yytext(), yyline);}
"INTERRUPT"       {return new token("KEYWORD", yytext(), yyline);}
"OF"              {return new token("KEYWORD", yytext(), yyline);}
"REPEAT"          {return new token("KEYWORD", yytext(), yyline);}
"TO"              {return new token("KEYWORD", yytext(), yyline);}
"VIRTUAL"         {return new token("KEYWORD", yytext(), yyline);}
"ARRAY"           {return new token("KEYWORD", yytext(), yyline);}
"DESTRUCTOR"      {return new token("KEYWORD", yytext(), yyline);}
"END"             {return new token("KEYWORD", yytext(), yyline);}
"IF"              {return new token("KEYWORD", yytext(), yyline);}
"LABEL"           {return new token("KEYWORD", yytext(), yyline);}
"OR"              {return new token("KEYWORD", yytext(), yyline);}
"SET"             {return new token("KEYWORD", yytext(), yyline);}
"TYPE"            {return new token("KEYWORD", yytext(), yyline);}
"ASM"             {return new token("KEYWORD", yytext(), yyline);}
"EXTERNAL"        {return new token("KEYWORD", yytext(), yyline);}
"FILE"            {return new token("KEYWORD", yytext(), yyline);}
"IMPLEMENTATION"  {return new token("KEYWORD", yytext(), yyline);}
"MOD"             {return new token("KEYWORD", yytext(), yyline);}
"PACKED"          {return new token("KEYWORD", yytext(), yyline);}
"SHL"             {return new token("KEYWORD", yytext(), yyline);}
"UNIT"            {return new token("KEYWORD", yytext(), yyline);}
"BEGIN"           {return new token("KEYWORD", yytext(), yyline);}
"DIV"             {return new token("KEYWORD", yytext(), yyline);}
"FOR"             {return new token("KEYWORD", yytext(), yyline);}
"IN"              {return new token("KEYWORD", yytext(), yyline);}
"NIL"             {return new token("KEYWORD", yytext(), yyline);}
"PRIVATE"         {return new token("KEYWORD", yytext(), yyline);}
"WHILE"           {return new token("KEYWORD", yytext(), yyline);}
"WITH"            {return new token("KEYWORD", yytext(), yyline);}
"SHR"             {return new token("KEYWORD", yytext(), yyline);}
"UNTIL"           {return new token("KEYWORD", yytext(), yyline);}
"XOR"             {return new token("KEYWORD", yytext(), yyline);}
"CASE"            {return new token("KEYWORD", yytext(), yyline);}
"DO"              {return new token("KEYWORD", yytext(), yyline);}
"FORWARD"         {return new token("KEYWORD", yytext(), yyline);}
"INLINE"          {return new token("KEYWORD", yytext(), yyline);}
"NOT"             {return new token("KEYWORD", yytext(), yyline);}
"PROCEDURE"       {return new token("KEYWORD", yytext(), yyline);}
"STRING"          {return new token("KEYWORD", yytext(), yyline);}
"INT"             {return new token("KEYWORD", yytext(), yyline);}
"CHAR"            {return new token("KEYWORD", yytext(), yyline);}
"REAL"            {return new token("KEYWORD", yytext(), yyline);}
"READ"            {return new token("KEYWORD", yytext(), yyline);}
"WRITE"            {return new token("KEYWORD", yytext(), yyline);}
"USES"            {return new token("KEYWORD", yytext(), yyline);}

\"{TEXT}\"        {return new token("LITERAL", yytext(), yyline);}

{HEX}             {return new token("NUMBER", yytext(), yyline);}

{OCT}             { return new token("NUMBER", yytext(), yyline); }

{NUMBER}          { return new token("NUMBER", yytext(), yyline); }

\'{CHAR}\'        {return new token("LITERAL", yytext(), yyline);}
“{TEXT}”          { return new token("LITERAL", yytext(), yyline); }
‘{CHAR}’          { return new token("LITERAL", yytext(), yyline); }

"+"               {return new token("OP_SUM", yytext(), yyline);}
">"               {return new token("OP_GREATER", yytext(), yyline);}
"++"              {return new token("OP_INCREASE", yytext(), yyline);}
":"               {return new token("OP_COLON", yytext(), yyline);}
"-"               {return new token("OP_MINUS", yytext(), yyline);}
"<="              {return new token("OP_LESSEQUAL", yytext(), yyline);}
"--"              {return new token("OP_DECREASE", yytext(), yyline);}
"."               {return new token("OP_PERIOD", yytext(), yyline);}
"*"               {return new token("OP_MULT", yytext(), yyline);}
">="              {return new token("OP_GREATEREQUAL", yytext(), yyline);}
"("               {return new token("OP_OPENPARENTHESIS", yytext(), yyline);}
"^"               {return new token("OP_POWER", yytext(), yyline);}
"/"               {return new token("OP_SLASH", yytext(), yyline);}
"="               {return new token("OP_EQUALS", yytext(), yyline);}
")"               {return new token("OR_CLOSEPARENTHESIS", yytext(), yyline);}
"**"              {return new token("OP_DOUBLEASTERISK", yytext(), yyline);}
"<>"              {return new token("OP_TYPE", yytext(), yyline);}
","               {return new token("OP_COMMA", yytext(), yyline);}
"["               {return new token("OP_OPENBRACKET", yytext(), yyline);}
"<"               {return new token("OP_LESS", yytext(), yyline);}
";"               {return new token("OP_SEMICOLON", yytext(), yyline);}
"]"               {return new token("OP_CLOSEBRACKET", yytext(), yyline);}
{ID}              {return new token("IDENTIFIER", yytext(), yyline);}
"{" [^}]* "}"     { /* Inline comment */ }
"(*" .*? "*)"     { /* Multiblock comment */ }
[ \t\r\n]+      { /* Ignore */ }
.                 { return new token("ERROR", yytext(), yyline); }