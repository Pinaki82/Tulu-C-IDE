#include<stdio.h>
#include<stdlib.h>

#define TIME_ELEMENTS 4
#define PAL 25
#define NTSC 30

/*
 * TIME_ELEMENTS here means Hour:Minute:Second:Frame.
 * TOTL here means total time length counted, suppose
 * you have 7 different video sequences with different time lenghts,
 * after counting the aggregate we get the TOTL.
 * */

int main(void){
 int time_arr[TIME_ELEMENTS], brdcst_std, frm_rate, total_time=0;
 int i, seq_counter=0, remaining_frms, a=0;
 int hour, mnt, secnd, frm;
 char consent;
 printf("This Program helps to calculate total video time of video sequences.\n");
 printf("Input Hour:Minute:Second:Frame with space gap. when asked.\n");
 printf("Then Press Enter, as long as you need.\n");
 printf("Please state your broadcast standard:\n");
 printf("1. PAL\n2. NTSC\n3. CUSTOM\nPlease State: ");
 scanf("%d",&brdcst_std);
 printf("\n");
 switch(brdcst_std){
  case 1:
            printf("your broadcast standard is 1.PAL\n");
            frm_rate=PAL;
    break;
  case 2:
            printf("your broadcast standard is 2.NTSC\n");
            frm_rate=NTSC;
    break;
  case 3:
            printf("input your custom frame rate: ");
            scanf("%d",&frm_rate);
            printf("\nyour broadcast standard's frame rate is: %d\n",frm_rate);
    break;
  default:
            printf("Not sure? do again.\n");
            getchar();
            return(main());
 }

 while (1){
  fflush(stdin);
  consent=fflush(stdin);

  printf("Continue.. y/n: ");
  scanf("%c",&consent);
  printf("\n");
  if((consent=='n')||(consent=='N')){
   printf("stopped\n");
   break;
  }
  fflush(stdin);
  consent=fflush(stdin);
  printf("You agreed, now input time:\n");

  seq_counter+=1;
  for(i=0;i<=TIME_ELEMENTS-1;i+=1){
   scanf( "%d", (time_arr+i) );
  }
  printf("scanned %d-th sequence\n",seq_counter);
  a=time_arr[0]*60*60*frm_rate+time_arr[1]*60*frm_rate+time_arr[2]*frm_rate+time_arr[3];
  total_time+=a;
 }

 printf("\n");
 printf("Total no. of sequences: %d\n",seq_counter);
 printf("Total time in Frames: %d\n",total_time);

 frm=total_time%frm_rate;
 remaining_frms=(total_time-frm)/frm_rate;
 secnd=remaining_frms%60;
 remaining_frms=(remaining_frms-secnd)/60;
 mnt=remaining_frms%60;
 remaining_frms=(remaining_frms-mnt)/60;
 hour=remaining_frms%60;
 printf("Total time in Timecode fromat: %d:%d:%d:%d\n",hour,mnt,secnd,frm);
 system("PAUSE");
 return 0;
}
/* LOGIC

1 30 20 12
2 20 30 21
346283

90000+45000+500+12=135512
180000+30000+750+21=210771
346283
3 50 51 8


346283%25=8
----------------
346283-8=346275
346275/25=13851
13851%60=51
----------------
13851-51=13800
13800/60=230
230%60=50
----------------
230-50=180
180/60=3
180%60=0

*/

