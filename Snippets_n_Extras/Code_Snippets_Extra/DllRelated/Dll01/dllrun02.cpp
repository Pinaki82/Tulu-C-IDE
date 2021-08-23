#include <windows.h>
 #include <iostream.h>
 #include <stdio.h>
 #include <conio.h>

 #define MAXMODULE 50

 typedef void (WINAPI*cfunc)();

 cfunc NumberList;
 cfunc LetterList;

 void main() {
   
       HINSTANCE hLib=LoadLibrary("DLLTEST.DLL");


       if(hLib==NULL) {

            cout << "Unable to load library!" << endl;
            getch();
            return;
       }

       char mod[MAXMODULE];

       GetModuleFileName((HMODULE)hLib, (LPTSTR)mod, MAXMODULE);
       cout << "Library loaded: " << mod << endl;


       NumberList=(cfunc)GetProcAddress((HMODULE)hLib, "NumberList");
       LetterList=(cfunc)GetProcAddress((HMODULE)hLib, "LetterList");

       if((NumberList==NULL) || (LetterList==NULL)) {

            cout << "Unable to load function(s)." << endl;
            FreeLibrary((HMODULE)hLib);
            return;
       }

       NumberList();
       LetterList();

       FreeLibrary((HMODULE)hLib);

       getch();
 }
