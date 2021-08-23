// Last Change: 2013-06-18 02:50:27
#include <windows.h>
#include <dos.h>
#include <errno.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/* replace PASCAL with WINAPI */
int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
  MSG msg;

  char prog[] = "my_prog.exe";

  WinExec(prog, SW_HIDE);

  return (msg.wParam);
}

