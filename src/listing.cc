// Compiler Theory and Design
// Project 2
// 02NOV2023
// Vincent Testagrossa

// This file contains the bodies of the functions that produces the compilation
// listing

// Changed the error string to a vector called errors to store multiple errors per line
// then loop through and display them all when display is called, clearing the 'queue' after
// completion.

// Kept the totalErrors int and added ones for syntax, lexical, and semantic errors to keep the
// count for display in the lastLine function.

// added a check to lastline for 0 total errors, so "Compiled Successfully" can be displayed.

#include <cstdio>
#include <string>
#include <vector>

using namespace std;

#include "listing.h"

static int lineNumber;
static vector<string> errors;
static int totalErrors = 0,
			lexicalErrors = 0,
			syntaxErrors = 0,
			semanticErrors = 0;

static void displayErrors();

void firstLine()
{
	lineNumber = 1;
	printf("\n%4d  ",lineNumber);
}

void nextLine()
{
	displayErrors();
	lineNumber++;
	printf("%4d  ",lineNumber);
}

int lastLine()
{
	printf("\r");
	displayErrors();
	printf("     \n");
	if (totalErrors > 0){
		printf("Lexical errors: %4d\n", lexicalErrors);
		printf("Semantic errors: %4d\n", semanticErrors);
		printf("Syntactic errors: %4d\n", syntaxErrors);
	}
	else {
		printf("Compiled Successfully\n");
	}
	return totalErrors;
}
    
void appendError(ErrorCategories errorCategory, string message)
{
	string messages[] = { "Lexical Error, Invalid Character ", "",
		"Semantic Error, ", "Semantic Error, Duplicate Identifier: ",
		"Semantic Error, Undeclared " };
	errors.push_back(messages[errorCategory] + message);
	switch(errorCategory){
		case LEXICAL:
			lexicalErrors++;
			break;
		case SYNTAX:
			syntaxErrors++;
			break;
		case GENERAL_SEMANTIC:
			semanticErrors++;
			break;
	}
	totalErrors++;
}

void displayErrors()
{
	for (const string& error : errors){
		if (error != ""){
			printf("%s\n", error.c_str());
		}
	}
	errors.clear();
}
