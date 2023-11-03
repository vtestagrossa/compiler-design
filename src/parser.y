/* Compiler Theory and Design
   Dr. Duane J. Jarc */

%{

#include <string>

using namespace std;

#include "listing.h"

int yylex();
void yyerror(const char* message);

%}

%define parse.error verbose

%token IDENTIFIER
%token INT_LITERAL
%token REAL_LITERAL
%token BOOL_LITERAL

%token ADDOP MULOP RELOP ANDOP OROP NOTOP ARROW EXPOP REMOP

%token BEGIN_ BOOLEAN END ENDREDUCE FUNCTION INTEGER IS REDUCE RETURNS IF ELSE THEN ENDIF CASE ENDCASE OTHERS REAL WHEN

%%

function:	
	function_header optional_variable body ;
	
function_header:	
	FUNCTION IDENTIFIER parameters RETURNS type ';' ;

parameters:
	parameter optional_parameter;

parameter:
	IDENTIFIER ':' type;

optional_parameter:
	optional_parameter ',' parameter |
	;


optional_variable:
	optional_variable variable |
	;

variable:
	IDENTIFIER ':' type IS statement_ ;

type:
	INTEGER |
	BOOLEAN |
	REAL;

body:
	BEGIN_ statement_ END ';' ;
    
statement_:
	statement ';' |
	error ';' ;
	
statement:
	expression |
	REDUCE operator reductions ENDREDUCE |
	IF expression THEN statement_ ELSE statement_ ENDIF |
	CASE expression IS optional_case OTHERS ARROW statement_ ENDCASE;

optional_case:
	optional_case WHEN INT_LITERAL ARROW statement_ |
	;

operator:
	ADDOP |
	MULOP ;

reductions:
	reductions statement_ |
	;
		    
expression:
	expression ANDOP relation |
	relation ;

relation:
	relation RELOP term |
	term;

term:
	term ADDOP factor |
	factor ;
      
factor:
	factor MULOP primary |
	primary ;

primary:
	'(' expression ')' |
	INT_LITERAL |
	REAL_LITERAL |
	BOOL_LITERAL | 
	IDENTIFIER ;
    
%%

void yyerror(const char* message)
{
	appendError(SYNTAX, message);
}

int main(int argc, char *argv[])    
{
	firstLine();
	yyparse();
	lastLine();
	return 0;
} 
