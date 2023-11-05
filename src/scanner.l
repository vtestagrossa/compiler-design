/*	CMSC 430
	Compiler Theory and Design
	Project 2
	Vincent Testagrossa
	05NOV2023 */

/*	This file contains flex input file. Added entries for real,
	changed the regex to match both comment types, modified the 
	identifier regex to allow nonconsecutive underscores between
	letters and numbers, added all the relational operators,
	required reserved words, and the real and bool literals. 
	Added the arrow operator, exponent, and remainder.*/

%{
#include <cstdio>
#include <string>

using namespace std;

#include "listing.h"
#include "tokens.h"

%}

%option noyywrap

ws			[ \t\r]+
comment		^(\/\/|\-\-).*\n
line		[\n]
id			[A-Za-z]+([\_]?[A-Za-z0-9]+)*
digit		[0-9]
int			{digit}+
true		true
false		false
real		{digit}+([\.]{digit}*([eE][\+\-]?{digit}+)?)?
punc		[\(\),:;]
%%

{ws}		{ ECHO; }
{comment}	{ ECHO; nextLine();}
{line}		{ ECHO; nextLine();}
"<"			{ ECHO; return(RELOP); }
"="			{ ECHO; return(RELOP); }
"/="		{ ECHO; return(RELOP); }
">"			{ ECHO; return(RELOP); }
"<="		{ ECHO; return(RELOP); }
">="		{ ECHO; return(RELOP); }
"=>"		{ ECHO; return(ARROW); }
"+"			{ ECHO; return(ADDOP); }
"-"			{ ECHO; return(ADDOP); }	
"*"			{ ECHO; return(MULOP); }	
"/"			{ ECHO; return(MULOP); }
"**"		{ ECHO; return(EXPOP); }
rem			{ ECHO; return(REMOP); }
begin		{ ECHO; return(BEGIN_); }
boolean		{ ECHO; return(BOOLEAN); }
end			{ ECHO; return(END); }
endreduce	{ ECHO; return(ENDREDUCE); }
function	{ ECHO; return(FUNCTION); }
integer		{ ECHO; return(INTEGER); }
is			{ ECHO; return(IS); }
if			{ ECHO; return(IF); }
then		{ ECHO; return(THEN); }
endif		{ ECHO; return(ENDIF); }
case		{ ECHO; return(CASE); }
endcase		{ ECHO; return(ENDCASE); }
else		{ ECHO; return(ELSE); }
others		{ ECHO; return(OTHERS); }
real		{ ECHO; return(REAL); }
when		{ ECHO; return(WHEN); }
reduce		{ ECHO; return REDUCE; }
returns		{ ECHO; return(RETURNS); }
and			{ ECHO; return(ANDOP); }
or			{ ECHO; return(OROP); }
not			{ ECHO; return(NOTOP); }
{true}		{ ECHO; return(BOOL_LITERAL); }
{false}		{ ECHO; return(BOOL_LITERAL); }
{id}		{ ECHO; return(IDENTIFIER);}
{int}		{ ECHO; return(INT_LITERAL); }
{real}		{ ECHO; return(REAL_LITERAL); }
{punc}		{ ECHO; return(yytext[0]); }
.		{ ECHO; appendError(LEXICAL, yytext); }
%%