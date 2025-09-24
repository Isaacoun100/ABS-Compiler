// Main code
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

// Variables for the rules
HEX =       [0-9]+[xX][0-9a-fA-F]+
INTEXP =    [0-9]+([eE][+-]?[0-9]+)?
FLOEXP =    [0-9]+\.[0-9]+([eE][+-]?[0-9]+)?
ID   =      [A-Za-z_][A-Za-z0-9_]*
TEXT =      [a-zA-Z0-9_\n]*
CHAR =      [a-zA-Z0-9_\n]
%% // Rules

"ABSOLUTE"        {return new token("ABSOLUTE", yytext(), yyline);}
"CONST"           {return new token("CONST", yytext(), yyline);}
"DOWNTO"          {return new token("DOWNTO", yytext(), yyline);}
"FUNCTION"        {return new token("FUNCTION", yytext(), yyline);}
"INTERFACE"       {return new token("INTERFACE", yytext(), yyline);}
"OBJECT"          {return new token("OBJECT", yytext(), yyline);}
"RECORD"          {return new token("RECORD", yytext(), yyline);}
"THEN"            {return new token("THEN", yytext(), yyline);}
"VAR"             {return new token("VAR", yytext(), yyline);}
"AND"             {return new token("AND", yytext(), yyline);}
"CONSTRUCTOR"     {return new token("CONSTRUCTOR", yytext(), yyline);}
"ELSE"            {return new token("ELSE", yytext(), yyline);}
"GOTO"            {return new token("GOTO", yytext(), yyline);}
"INTERRUPT"       {return new token("INTERRUPT", yytext(), yyline);}
"OF"              {return new token("OF", yytext(), yyline);}
"REPEAT"          {return new token("REPEAT", yytext(), yyline);}
"TO"              {return new token("TO", yytext(), yyline);}
"VIRTUAL"         {return new token("VIRTUAL", yytext(), yyline);}
"ARRAY"           {return new token("ARRAY", yytext(), yyline);}
"DESTRUCTOR"      {return new token("DESTRUCTOR", yytext(), yyline);}
"END"             {return new token("END", yytext(), yyline);}
"IF"              {return new token("IF", yytext(), yyline);}
"LABEL"           {return new token("LABEL", yytext(), yyline);}
"OR"              {return new token("OR", yytext(), yyline);}
"SET"             {return new token("SET", yytext(), yyline);}
"TYPE"            {return new token("TYPE", yytext(), yyline);}
"ASM"             {return new token("ASM", yytext(), yyline);}
"EXTERNAL"        {return new token("EXTERNAL", yytext(), yyline);}
"FILE"            {return new token("FILE", yytext(), yyline);}
"IMPLEMENTATION"  {return new token("IMPLEMENTATION", yytext(), yyline);}
"MOD"             {return new token("MOD", yytext(), yyline);}
"PACKED"          {return new token("PACKED", yytext(), yyline);}
"SHL"             {return new token("SHL", yytext(), yyline);}
"UNIT"            {return new token("UNIT", yytext(), yyline);}
"BEGIN"           {return new token("BEGIN", yytext(), yyline);}
"DIV"             {return new token("DIV", yytext(), yyline);}
"FOR"             {return new token("FOR", yytext(), yyline);}
"IN"              {return new token("IN", yytext(), yyline);}
"NIL"             {return new token("NIL", yytext(), yyline);}
"PRIVATE"         {return new token("PRIVATE", yytext(), yyline);}
"WHILE"           {return new token("WHILE", yytext(), yyline);}
"WITH"            {return new token("WHILE", yytext(), yyline);}
"SHR"             {return new token("SHR", yytext(), yyline);}
"UNTIL"           {return new token("UNTIL", yytext(), yyline);}
"XOR"             {return new token("XOR", yytext(), yyline);}
"CASE"            {return new token("CASE", yytext(), yyline);}
"DO"              {return new token("DO", yytext(), yyline);}
"FORWARD"         {return new token("FORWARD", yytext(), yyline);}
"INLINE"          {return new token("INLINE", yytext(), yyline);}
"NOT"             {return new token("NOT", yytext(), yyline);}
"PROCEDURE"       {return new token("PROCEDURE", yytext(), yyline);}
"STRING"          {return new token("STRING", yytext(), yyline);}
"INT"             {return new token("INT", yytext(), yyline);}
"CHAR"            {return new token("CHAR", yytext(), yyline);}
"BOOLEAN"         {return new token("BOOL", yytext(), yyline);}
"FLOAT"           {return new token("BOOL", yytext(), yyline);}
"USES"            {return new token("USES", yytext(), yyline);}
\"{TEXT}\"        {return new token("LITERAL", yytext(), yyline);}

// To accept hex
{HEX}             {return new token("NUMBER", yytext(), yyline);}

// To accept integers with exp
{INTEXP}          {return new token("NUMBER", yytext(), yyline);}

// To accept decimals with exp
{FLOEXP}          {return new token("NUMBER", yytext(), yyline);}

\'{CHAR}\'        {return new token("LITERAL", yytext(), yyline);}
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
[' '\t\r\n]+      { /* Ignore */ }
.                 { return new token("ERROR", yytext(), yyline); }