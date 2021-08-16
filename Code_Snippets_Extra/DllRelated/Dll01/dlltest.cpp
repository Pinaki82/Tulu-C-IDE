#include "dlltest.h"

 #define MAXMODULE 50

 char module[MAXMODULE];


 extern "C" __declspec(dllexport)

 void NumberList() {

       GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

       cout << "\n\nThis function was called from "
            << module 
            << endl << endl;

       cout << "NumberList(): ";


       for(int i=0;  i<10; i++) {

            cout << i << " ";
       }

       cout << endl << endl;
 }



 extern "C" __declspec(dllexport)

 void LetterList() {

       GetModuleFileName(NULL, (LPTSTR)module, MAXMODULE);

       cout << "\n\nThis function was called from "
            << module 
            << endl << endl;

       cout << "LetterList(): ";


       for(int i=0;  i<26; i++) {

            cout << char(97 + i) << " ";
       }

       cout << endl << endl;
 }
