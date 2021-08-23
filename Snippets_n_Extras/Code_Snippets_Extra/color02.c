#include <stdio.h>
#include <stdlib.h>
#include <windows.h>

int main(void)
{
	const WORD colors[] =
		{
		0x1A, 0x2B, 0x3C, 0x4D, 0x5E, 0x6F,
		0xA1, 0xB2, 0xC3, 0xD4, 0xE5, 0xF6
		};

	HANDLE hstdin  = GetStdHandle( STD_INPUT_HANDLE  );
	HANDLE hstdout = GetStdHandle( STD_OUTPUT_HANDLE );
	WORD   index   = 0;

	// Remember how things were when we started
	CONSOLE_SCREEN_BUFFER_INFO csbi;
	GetConsoleScreenBufferInfo( hstdout, &csbi );

	// Tell the user how to stop
	SetConsoleTextAttribute( hstdout, 0xEC );
	printf("Press any key to quit.\n");

	// Draw pretty colors until the user presses any key
	while (WaitForSingleObject( hstdin, 100 ) == WAIT_TIMEOUT)
	{
		SetConsoleTextAttribute( hstdout, colors[ index ] );
		printf("\t\t\t\t Hello World \t\t\t\t");
		if (++index > sizeof(colors)/sizeof(colors[0]))
			index = 0;
	}
	FlushConsoleInputBuffer( hstdin );

	// Keep users happy
	SetConsoleTextAttribute( hstdout, csbi.wAttributes );
	return 0;
}
