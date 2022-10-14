// Arquivo para o scanner a ser utilizado
package parser;
// Importar classes do cup - classe Symbol
import java_cup.runtime.*;

%%

%class Scanner
%cup
%unicode
%line
%column

%{
    // type é a classe do token
    // yyline e yycolumn são variáveis reservadas
    // do JFlex para armazenar a linha e a coluna
    // de um token encontrado na entrada (precisa
    //  usar %line e %column)
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }
    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }
%}

ws = [\ \t\f\r\n]
number = \d+(\.\d+)?(["E""e"]["+""-"]?\d+)?
id = [A-Za-z][A-Za-z0-9]*
%%
";"         { return symbol(sym.SEMI); }
"+"         { return symbol(sym.PLUS); }
"-"         { return symbol(sym.MINUS); }
"*"         { return symbol(sym.TIMES); }
"/"         { return symbol(sym.DIVIDE); }
"%"         { return symbol(sym.MOD); }
"("         { return symbol(sym.LPAREN); }
")"         { return symbol(sym.RPAREN); }
"="         { return symbol(sym.ASSIGN); }
{id}        { return symbol(sym.ID, yytext()); }
{number}    { return symbol(sym.NUMBER, Double.valueOf(yytext())); }
{ws}        {/* Ignore */}
.           { throw new Error("Simbolo inválido detectado: \"" + yycharat(0) +
              "\" ( linha: " +  yyline + ", coluna: " + yycolumn + ")"); }


