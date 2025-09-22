// Main code
import java.io.*;
import java.util.ArrayList;

// This object will contain the token name and line where is located

void main(String[] args) throws Exception {
    Reader reader = new FileReader("src/test.txt");
    absScanner scanner = new absScanner(reader);
    scanner.yylex(); // scan the file until EOF
}

class token{

    String tokenName;
    String value;
    int line;

    public token(String tokenName, String value, int line) {
        this.tokenName = tokenName;
        this.value = value;
        this.line = line;
    }
}

public class Yytoken {
    public final String text;
    public final int type;
    public Yytoken(String text, int type) {
        this.text = text;
        this.type = type;
    }
}


// List of the tokens that it found
ArrayList<token> tokenList = new ArrayList<>();

// List of error tokens
ArrayList<token> errorList = new ArrayList<>();

%% // Declarations

%class absScanner
%line
%column

BASE = ([0-9]+'x')?[0-9]+
DIGIT = (\.[0-9]*)?
EXP = ('E'(-)?([0-9])*)?

TEXT = [a-zA-Z0-9_\n]*
%% // Rules

"ABSOLUTE"                      {token newToken = new token("ABSOLUTE", yytext(), yyline); tokenList.add(newToken);}
"CONST"                         {token newToken = new token("CONST", yytext(), yyline); tokenList.add(newToken);}
"DOWNTO"                        {token newToken = new token("DOWNTO", yytext(), yyline); tokenList.add(newToken);}
"FUNCTION"                      {token newToken = new token("FUNCTION", yytext(), yyline); tokenList.add(newToken);}
"INTERFACE"                     {token newToken = new token("INTERFACE", yytext(), yyline); tokenList.add(newToken);}
"OBJECT"                        {token newToken = new token("OBJECT", yytext(), yyline); tokenList.add(newToken);}
"RECORD"                        {token newToken = new token("RECORD", yytext(), yyline); tokenList.add(newToken);}
"THEN"                          {token newToken = new token("THEN", yytext(), yyline); tokenList.add(newToken);}
"VAR"                           {token newToken = new token("VAR", yytext(), yyline); tokenList.add(newToken);}
"AND"                           {token newToken = new token("AND", yytext(), yyline); tokenList.add(newToken);}
"CONSTRUCTOR"                   {token newToken = new token("CONSTRUCTOR", yytext(), yyline); tokenList.add(newToken);}
"ELSE"                          {token newToken = new token("ELSE", yytext(), yyline); tokenList.add(newToken);}
"GOTO"                          {token newToken = new token("GOTO", yytext(), yyline); tokenList.add(newToken);}
"INTERRUPT"                     {token newToken = new token("INTERRUPT", yytext(), yyline); tokenList.add(newToken);}
"OF"                            {token newToken = new token("OF", yytext(), yyline); tokenList.add(newToken);}
"REPEAT"                        {token newToken = new token("REPEAT", yytext(), yyline); tokenList.add(newToken);}
"TO"                            {token newToken = new token("TO", yytext(), yyline); tokenList.add(newToken);}
"VIRTUAL"                       {token newToken = new token("VIRTUAL", yytext(), yyline); tokenList.add(newToken);}
"ARRAY"                         {token newToken = new token("ARRAY", yytext(), yyline); tokenList.add(newToken);}
"DESTRUCTOR"                    {token newToken = new token("DESTRUCTOR", yytext(), yyline); tokenList.add(newToken);}
"END"                           {token newToken = new token("END", yytext(), yyline); tokenList.add(newToken);}
"IF"                            {token newToken = new token("IF", yytext(), yyline); tokenList.add(newToken);}
"LABEL"                         {token newToken = new token("LABEL", yytext(), yyline); tokenList.add(newToken);}
"OR"                            {token newToken = new token("OR", yytext(), yyline); tokenList.add(newToken);}
"SET"                           {token newToken = new token("SET", yytext(), yyline); tokenList.add(newToken);}
"TYPE"                          {token newToken = new token("TYPE", yytext(), yyline); tokenList.add(newToken);}
"ASM"                           {token newToken = new token("ASM", yytext(), yyline); tokenList.add(newToken);}
"EXTERNAL"                      {token newToken = new token("EXTERNAL", yytext(), yyline); tokenList.add(newToken);}
"FILE"                          {token newToken = new token("FILE", yytext(), yyline); tokenList.add(newToken);}
"IMPLEMENTATION"                {token newToken = new token("IMPLEMENTATION", yytext(), yyline); tokenList.add(newToken);}
"MOD"                           {token newToken = new token("MOD", yytext(), yyline); tokenList.add(newToken);}
"PACKED"                        {token newToken = new token("PACKED", yytext(), yyline); tokenList.add(newToken);}
"SHL"                           {token newToken = new token("SHL", yytext(), yyline); tokenList.add(newToken);}
"UNIT"                          {token newToken = new token("UNIT", yytext(), yyline); tokenList.add(newToken);}
"BEGIN"                         {token newToken = new token("BEGIN", yytext(), yyline); tokenList.add(newToken);}
"DIV"                           {token newToken = new token("DIV", yytext(), yyline); tokenList.add(newToken);}
"FOR"                           {token newToken = new token("FOR", yytext(), yyline); tokenList.add(newToken);}
"IN"                            {token newToken = new token("IN", yytext(), yyline); tokenList.add(newToken);}
"NIL"                           {token newToken = new token("NIL", yytext(), yyline); tokenList.add(newToken);}
"PRIVATE"                       {token newToken = new token("PRIVATE", yytext(), yyline); tokenList.add(newToken);}
"SHR"                           {token newToken = new token("SHR", yytext(), yyline); tokenList.add(newToken);}
"UNTIL"                         {token newToken = new token("UNTIL", yytext(), yyline); tokenList.add(newToken);}
"XOR"                           {token newToken = new token("XOR", yytext(), yyline); tokenList.add(newToken);}
"CASE"                          {token newToken = new token("CASE", yytext(), yyline); tokenList.add(newToken);}
"DO"                            {token newToken = new token("DO", yytext(), yyline); tokenList.add(newToken);}
"FORWARD"                       {token newToken = new token("FORWARD", yytext(), yyline); tokenList.add(newToken);}
"INLINE"                        {token newToken = new token("INLINE", yytext(), yyline); tokenList.add(newToken);}
"NOT"                           {token newToken = new token("NOT", yytext(), yyline); tokenList.add(newToken);}
"PROCEDURE"                     {token newToken = new token("PROCEDURE", yytext(), yyline); tokenList.add(newToken);}
"STRING"                        {token newToken = new token("STRING", yytext(), yyline); tokenList.add(newToken);}
"INT"                           {token newToken = new token("INT", yytext(), yyline); tokenList.add(newToken);}
"CHAR"                          {token newToken = new token("CHAR", yytext(), yyline); tokenList.add(newToken);}
"BOOLEAN"                       {token newToken = new token("BOOL", yytext(), yyline); tokenList.add(newToken);}
"FLOAT"                         {token newToken = new token("BOOL", yytext(), yyline); tokenList.add(newToken);}
"USES"                          {token newToken = new token("USES", yytext(), yyline); tokenList.add(newToken);}
\"{TEXT}\"                      {token newToken = new token("LITERAL", yytext(), yyline); tokenList.add(newToken);}
'-'?{BASE}{DIGIT}{EXP}          {token newToken = new token("LITERAL", yytext(), yyline); tokenList.add(newToken);}
"+"                             {token newToken = new token("OP_SUM", yytext(), yyline); tokenList.add(newToken);}
">"                             {token newToken = new token("OP_GREATER", yytext(), yyline); tokenList.add(newToken);}
"++"                            {token newToken = new token("OP_INCREASE", yytext(), yyline); tokenList.add(newToken);}
":"                             {token newToken = new token("OP_COLON", yytext(), yyline); tokenList.add(newToken);}
"-"                             {token newToken = new token("OP_MINUS", yytext(), yyline); tokenList.add(newToken);}
"<="                            {token newToken = new token("OP_LESSEQUAL", yytext(), yyline); tokenList.add(newToken);}
"--"                            {token newToken = new token("OP_DECREASE", yytext(), yyline); tokenList.add(newToken);}
"."                             {token newToken = new token("OP_PERIOD", yytext(), yyline); tokenList.add(newToken);}
"*"                             {token newToken = new token("OP_MULT", yytext(), yyline); tokenList.add(newToken);}
">="                            {token newToken = new token("OP_GREATEREQUAL", yytext(), yyline); tokenList.add(newToken);}
"("                             {token newToken = new token("OP_OPENPARENTHESIS", yytext(), yyline); tokenList.add(newToken);}
"^"                             {token newToken = new token("OP_POWER", yytext(), yyline); tokenList.add(newToken);}
"/"                             {token newToken = new token("OP_SLASH", yytext(), yyline); tokenList.add(newToken);}
"="                             {token newToken = new token("OP_EQUALS", yytext(), yyline); tokenList.add(newToken);}
")"                             {token newToken = new token("OR_CLOSEPARENTHESIS", yytext(), yyline); tokenList.add(newToken);}
"**"                            {token newToken = new token("OP_DOUBLEASTERISK", yytext(), yyline); tokenList.add(newToken);}
"<>"                            {token newToken = new token("OP_TYPE", yytext(), yyline); tokenList.add(newToken);}
","                             {token newToken = new token("OP_COMMA", yytext(), yyline); tokenList.add(newToken);}
"["                             {token newToken = new token("OP_OPENBRACKET", yytext(), yyline); tokenList.add(newToken);}
"<"                             {token newToken = new token("OP_LESS", yytext(), yyline); tokenList.add(newToken);}
";"                             {token newToken = new token("OP_SEMICOLON", yytext(), yyline); tokenList.add(newToken);}
"]"                             {token newToken = new token("OP_CLOSEBRACKET", yytext(), yyline); tokenList.add(newToken);}
"{" [^}]* "}"                   { /* Inline comment */ }
"(*" .*? "*)"                   { /* Multiblock comment */ }
.                               { token newToken = new token("OP_CLOSEBRACKET", yytext(), yyline); errorList.add(newToken); }
<<EOF>>{
          for (token t : tokenList) {
              System.out.println("Token: " + t.tokenName + ", Value: " + t.value + ", Line: " + t.line);
          }

          for (token t : errorList) {
              System.out.println("Error: " + t.tokenName + ", Value: " + t.value + ", Line: " + t.line);
          }
      }