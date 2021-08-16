/*
 * Pinaki Sekhar Gupta <appugupta007@gmail.com>
 * Date: 2011/December/06, Tuesday, 10:04 PM.
 * Offered for use in the public domain without any warranty.
 * This header helps to pick up the scan codes from a keyboard, such as arrow-keys,
 * page-up-down key and all except F11 and F12 and some reserved keys like Print_Scren_Sysrq, Scroll_lock etc.
 * These define the scan codes(IBM) for the keys. All numbers are in decimal.
 * This code was originally obtained from http://www.daniweb.com/software-development/cpp/code/216732
 * and modified accordingly to fit the common purposes.
 * To learn more, search google with tags: Reading Scan Codes from the Keyboard, or,
 * How to read Scan Codes from the Keyboard.
*/

#ifndef __SCANCODE_APPU_H__
#define __SCANCODE_APPU_H__

#include <stdio.h>
#include<stdlib.h>
#ifdef __GNUC__
#include <conio2.h>
#else
#ifdef __BORLANDC__
#include <conio.h>
#else
#ifdef __MSVC__
#include <conio.h>
#endif
#endif
#endif

#ifdef __cplusplus
extern "C"
{
#endif

  int scncd(void);  // 'scncd' stands for scan_code. use this header like: returned=scncd();

#ifdef __cplusplus
}
#endif

#endif // __SCANCODE_APPU_H__

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
#define F11 NULL
#define F12 NULL
#define INSERT 82
#define DELETE 83
#define HOME 71
#define END 79
#define PAGE_UP 73
#define PAGE_DOWN 81
#define RIGHT_ARROW 77
#define LEFT_ARROW 75
#define UP_ARROW 72
#define DOWN_ARROW 80

int scncd(void) {
  char keystroke;
  unsigned int IBM_scan_code, real_code;
  int resulting_unwanted_negative_real_code;
  keystroke=getch();
  IBM_scan_code=keystroke;
  real_code=IBM_scan_code;

  if(keystroke == 0 || keystroke == -32) {
    keystroke=getch();
    switch(keystroke) {
      case F1:
        real_code=59;
        break;
      case F2:
        real_code=60;
        break;
      case F3:
        real_code=61;
        break;
      case F4:
        real_code=62;
        break;
      case F5:
        real_code=63;
        break;
      case F6:
        real_code=64;
        break;
      case F7:
        real_code=65;
        break;
      case F8:
        real_code=66;
        break;
      case F9:
        real_code=67;
        break;
      case F10:
        real_code=68;
        break;
      case INSERT:
        real_code=82;
        break;
      case DELETE:
        real_code=83;
        break;
      case HOME:
        real_code=71;
        break;
      case END:
        real_code=79;
        break;
      case PAGE_UP:
        real_code=73;
        break;
      case PAGE_DOWN:
        real_code=81;
        break;
      case RIGHT_ARROW:
        real_code=77;
        break;
      case LEFT_ARROW:
        real_code=75;
        break;
      case UP_ARROW:
        real_code=72;
        break;
      case DOWN_ARROW:
        real_code=80;
        break;
      default:
        real_code=IBM_scan_code;
    }
  }
  resulting_unwanted_negative_real_code=real_code;
  if(resulting_unwanted_negative_real_code==-32 || real_code==0) {
    real_code=0;
  }

  return (real_code);
}

