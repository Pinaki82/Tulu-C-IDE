    /* This program shows how to pick up the scan codes from a keyboard */

    /* These define the scan codes(IBM) for the keys. All numbers are in decimal.*/

    /*This code was obtained from http://www.daniweb.com/software-development/cpp/code/216732  */
    /* Search google with tags: Reading Scan Codes from the Keyboard, or,
    How to read Scan Codes from the Keyboard*/

    #define PAGE_UP 73
    #define HOME 71
    #define END 79
    #define PAGE_DOWN 81
    #define UP_ARROW 72
    #define LEFT_ARROW 75
    #define DOWN_ARROW 80
    #define RIGHT_ARROW 77
    #define F1 59
    #define F2 60
    #define F3 61
    #define F4 62
    #define F5 63
    #define F6 64
    #define F7 65
    #define F8 66
    #define F9 67
    #define F10 68
    #include <iostream>
    #include <conio2.h>

    using namespace std;

    int main(void)
    {
    char KeyStroke;

    cout << "Press Escape to quit." << endl;

    do
    {
    KeyStroke = getch();

    if (KeyStroke == 0 || KeyStroke == -32)
    {
    KeyStroke = getch(); // Even though there are 2 getch() it reads one keystroke
    switch (KeyStroke)
    {
    case PAGE_UP:
    cout << "PAGE UP" << endl;
    break;
    case PAGE_DOWN:
    cout << "PAGE DOWN" << endl;
    break;
    case HOME:
    cout << "HOME" << endl;
    break;
    case END:
    cout << "END" << endl;
    break;
    case UP_ARROW:
    cout << "UP ARROW" << endl;
    break;
    case DOWN_ARROW:
    cout << "DOWN ARROW" << endl;
    break;
    case LEFT_ARROW:
    cout << "LEFT_ARROW" << endl;
    break;
    case RIGHT_ARROW:
    cout << "RIGHT_ARROW" << endl;
    break;
    case F1:
    cout << "F1" << endl;
    break;
    case F2:
    cout << "F2" << endl;
    break;
    case F3:
    cout << "F3" << endl;
    break;
    case F4:
    cout << "F4" << endl;
    break;
    case F5:
    cout << "F5" << endl;
    break;
    case F6:
    cout << "F6" << endl;
    break;
    case F7:
    cout << "F7" << endl;
    break;
    case F8:
    cout << "F8" << endl;
    break;
    case F9:
    cout << "F9" << endl;
    break;
    case F10:
    cout << "F10" << endl;
    break;
    default:
    cout << "Some other key." << endl;
    }
    }
    else
    cout << KeyStroke << endl;
    }
    while (KeyStroke != 27); // 27 = Escape key
    }
