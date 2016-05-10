ifdef _TASM_
          includelib import32.lib
          extrn ShellExecuteA:Near
ShellExecute equ ShellExecuteA
else
  Includelib Shell32.lib
          extrn _imp_shellExecuteA@24:dWORD
ShellExecute EQU  _imp_shellExecuteA@24
endif
