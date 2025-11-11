// Main code
package scanner;
import java_cup.runtime.Symbol;
import parser.sym;
import java.util.ArrayList;

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
  public ArrayList<String> lexErrors = new ArrayList<>();
  // Here we will keep a list of the error that we'll find during the scanning

  /**
  * This fucntion creates a Symbol and then assign an ID, line and column
  * @param id
  * @return The Symbol with the information of said token
  */
  private Symbol sym(int id) {
      return new Symbol(id, yyline+1, yycolumn+1);
  }

  /**
  * This fucntion creates a Symbol and then assign an ID, line and column
  * @param id
  * @param val
  * @return The Symbol with the information of said token
  */
  private Symbol sym(int id, Object val) {
      return new Symbol(id, yyline+1, yycolumn+1, val);
  }

  /**
  * This fucntion creates a Symbol and then assign an ID, line and column
  * @param id
  * @param val
  * @param line
  * @param column
  * @return The Symbol with the information of said token
  */
  private Symbol symbol(int type, Object val, int line, int column) {
      return new Symbol(type, line, column, val);
  }

  /**
  * Ads the provided string to the list of errors that we will be displaying at the end of the compiling
  * @param msg
  */
  private void addLexError(String msg) {
      lexErrors.add("Línea " + (yyline + 1) + ", Columna " + (yycolumn + 1) + ": " + msg);
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

%% // Rules

// ===== Reserved words for the grammar ===== //
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

// =============== Data Types =============== //
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

// =============== Literals ================= //

// Numbers
{HEX}           { return sym(sym.HEX_LIT, yytext()); }
{OCT}           { return sym(sym.INT_LIT, yytext()); }
{NUMBER}        {
          String t = yytext();
          if (t.indexOf('.') >= 0 || t.indexOf('e')>=0 || t.indexOf('E')>=0)
              return sym(sym.REAL_LIT, t);
          else
              return sym(sym.INT_LIT, t);
      }

// Text
\"{TEXT}\"            { return sym(sym.STR_LIT, yytext()); }
\'{CHAR}\'            { return sym(sym.CHAR_LIT, yytext()); }

// =============== Identifiers ============== //
{ID}                  { return sym(sym.ID, yytext()); }

// =============== Comments ================= //
{INLINECOM}           { /* ignore */ }
{BLOCKCOM}            { /* ignore */ }
{WS}                  { /* ignore */ }

// ============== Error Token =============== //
.                     {
          addLexError("Carácter no reconocido: '" + yytext() + "'");
          return sym(sym.ERROR, yytext());
}