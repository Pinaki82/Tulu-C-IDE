#include <windows.h>
#include <stdio.h>	

int main () {
	
	/*Typedef the hello function*/
	typedef void (*pfunc)();
	
	/*Windows handle*/
	HANDLE hdll;
	
	/*A pointer to a function*/
	pfunc hello;
	
	/*LoadLibrary*/
	hdll = LoadLibrary("message.dll");
	
	/*GetProcAddress*/
	hello = (pfunc)GetProcAddress(hdll, "hello");
	
	/*Call the function*/
	hello();
	
	return 0;
}
