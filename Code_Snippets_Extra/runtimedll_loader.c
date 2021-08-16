#include <windows.h>
#include <stdio.h>
#include <stdlib.h>

// DLL function signature
typedef double (*importFunction_01)(double, double); //you can add another import for another function
 
int main(int argc, char **argv)
{
        importFunction_01 addNumbers;
        double result;
 
        // Load DLL file
        HINSTANCE hinstLib_01 = LoadLibrary(TEXT("Example.dll")); //by hinstLib_01 create instance for one particular dll
                 //you can write anything to assign one particular dll
        if (hinstLib_01 == NULL) {
                printf("ERROR: unable to load DLL\n");
                system("PAUSE");
                return 1;
        }
 
        // Get function pointer                    //instance for your particular one dll, then give a function
        addNumbers = (importFunction_01)GetProcAddress(hinstLib_01, "AddNumbers");
        if (addNumbers == NULL) {
                printf("ERROR: unable to find DLL function\n");
                FreeLibrary(hinstLib_01);
                system("PAUSE");
                return 1;
        }
 
        // Call function.
        result = addNumbers(1, 2);
 
        // Unload DLL file
        FreeLibrary(hinstLib_01);
 
        // Display result
        printf("The result was: %f\n", result);

        system("PAUSE");
        return 0;
}

