%{
/* The LibVMI Library is an introspection library that simplifies access to 
 * memory in a target virtual machine or in a file containing a dump of 
 * a system's physical memory.  LibVMI is based on the XenAccess Library.
 *
 * Copyright 2011 Sandia Corporation. Under the terms of Contract
 * DE-AC04-94AL85000 with Sandia Corporation, the U.S. Government
 * retains certain rights in this software.
 *
 * Author: Bryan D. Payne (bdpayne@acm.org)
 *
 * This file is part of LibVMI.
 *
 * LibVMI is free software: you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or (at your
 * option) any later version.
 *
 * LibVMI is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Lesser General Public
 * License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with LibVMI.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <string.h>
#include "config_parser.h"
#include "grammar.h"

#ifdef VMI_DEBUG
#define YY_INPUT(buf,result,max_size)  {\
    result = GetNextChar(buf, max_size); \
    if (  result <= 0  ) \
      result = YY_NULL; \
    }
#endif

%}

%%
linux_tasks             { BeginToken(yytext); return LINUX_TASKS; }
linux_mm                { BeginToken(yytext); return LINUX_MM; }
linux_name              { BeginToken(yytext); return LINUX_NAME; }
linux_pid               { BeginToken(yytext); return LINUX_PID; }
linux_pgd               { BeginToken(yytext); return LINUX_PGD; }
linux_addr              { BeginToken(yytext); return LINUX_ADDR; }
ntoskrnl                { BeginToken(yytext); return WIN_NTOSKRNL; }
win_tasks               { BeginToken(yytext); return WIN_TASKS; }
win_pdbase              { BeginToken(yytext); return WIN_PDBASE; }
win_pid                 { BeginToken(yytext); return WIN_PID; }
win_peb                 { BeginToken(yytext); return WIN_PEB; }
win_iba                 { BeginToken(yytext); return WIN_IBA; }
win_ph                  { BeginToken(yytext); return WIN_PH; }
win_pname               { BeginToken(yytext); return WIN_PNAME; }
win_kdvb                { BeginToken(yytext); return WIN_KDVB; }
win_sysproc             { BeginToken(yytext); return WIN_SYSPROC; }
sysmap                  { BeginToken(yytext); return SYSMAPTOK; }
ostype                  { BeginToken(yytext); return OSTYPETOK; }
0x[0-9a-fA-F]+|[0-9]+   {
    BeginToken(yytext);
    yylval.str = strdup(yytext);
    return NUM;
    }
[a-zA-Z0-9][a-zA-Z0-9._-]+      {
    BeginToken(yytext);
    yylval.str = strdup(yytext);
    return WORD;
    }
[a-zA-Z0-9\/._-]+            {
    BeginToken(yytext);
    yylval.str = strdup(yytext);
    return FILENAME;
    }
\"                      { BeginToken(yytext); return QUOTE; }
\{                      { BeginToken(yytext); return OBRACE; }
\}                      { BeginToken(yytext); return EBRACE; }
;                       { BeginToken(yytext); return SEMICOLON; }
=                       { BeginToken(yytext); return EQUALS; }
\n                      /* ignore EOL */;
[ \t]+                  /* ignore whitespace */;
#[^\n]*\n               /* ignore comment lines */;
%%
