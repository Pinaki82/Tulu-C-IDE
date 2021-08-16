#include<stdio.h>
#include<stdlib.h>

int main(void){
 unsigned int no_of_led_series, max_leds_in_voltage_std; // no_of_led_parallel;
 float voltage_max, voltage_min, voltage_std, voltage_avrg, resistor, head_voltage;
 float voltage_dangerous, voltage_at_no_glow;
 float v_drop_across_1_led, led_current, led_current_max, led_current_min;
 char answer;
 printf("Calculate LED resistor in series, light up LEDs in high voltage main line.\n");
 printf("Input your supply voltage max.\n(only this will be considerd in calculation) : ");
 scanf("%f",&voltage_max);
 printf("\nInput your supply voltage min. : ");
 scanf("%f",&voltage_min);

 if(voltage_max < voltage_min){
   printf("\n ..invalid input");
   getchar();
   getchar();
   exit(0);
   return 0;
 }

 fflush(stdin);
 answer=fflush(stdin);
 printf("\nHave you checked your standard/on-going supply voltage with a multimeter?\ny/n: ");
 scanf("%c",&answer);

 if ((answer=='n')||(answer=='N')){
  printf("\nUsing calculated average voltage.");
  voltage_avrg=(voltage_max + voltage_min)/2;
  voltage_std=voltage_avrg;
  printf("\nCalculated average voltage: %f\n",voltage_std);
 }
 else {
  printf("\nInput your standard supply voltage : ");
  scanf("%f",&voltage_std);
 }

 if((voltage_std < voltage_min)||(voltage_std > voltage_max)){
   printf("\n ..invalid input");
   getchar();
   getchar();
   exit(0);
   return 0;
 }

 printf("\n\nInput voltage drop across one LED\n(e.g. 1.7v for crystal green, 3.4v for bright white) : ");
 scanf("%f",&v_drop_across_1_led);

 printf("\nInput current you want supply to one LED in mA\n(** Max 25mA, Min 1mA, safest within 17 to 20 mA **): ");
 scanf("%f",&led_current);

 while ((led_current < 1)||(led_current > 25)){
   printf("\n ..out of range");
   printf("\ninput LED current in mA, correctly: ");
   scanf("%f",&led_current);
 }

 led_current=led_current/1000;
 max_leds_in_voltage_std=voltage_std/v_drop_across_1_led;

 printf("\nYou can put maximum %u LED under the standard supply voltage.",max_leds_in_voltage_std);

 printf("\nInput no. of LEDs required (in series only) : ");
 scanf("%u",&no_of_led_series);

 while (no_of_led_series > max_leds_in_voltage_std){
  printf("\nInsufficient supply voltage, try to decrease no. of LEDs.");
  printf("\nInput no. of LEDs required (in series only) correctly : ");
  scanf("%u",&no_of_led_series);
 }

 head_voltage=voltage_max-(no_of_led_series*v_drop_across_1_led);
 resistor=head_voltage/led_current; //E=I*R; Ohms Law.

 printf("\n------------------------------------------------------------\n");
 printf("\nYou need a %f Ohms i.e. a %f kOhms resistor in series.",resistor,resistor/1000);
 printf("\nPower dissipation/wastage by the resistor in this case:\n %f Watt i.e. %f mW.",head_voltage*led_current,head_voltage*led_current*1000); //Voltage*ampere=Wattage.
 printf("\nPower consumption total:\n%f Watt by LEDs+%f Watt by resistor\n=total %f Watt.\n\n",(no_of_led_series*v_drop_across_1_led*led_current),head_voltage*led_current,(no_of_led_series*v_drop_across_1_led*led_current)+head_voltage*led_current);
 printf("\n");
 printf("Situations when:\n");
 printf("supply is Max. i.e. %f Volt, current across one LED %fmA\n",voltage_max,(voltage_max-(no_of_led_series*v_drop_across_1_led))*1000/resistor);
 printf("supply is Min. i.e. %f Volt, current across one LED %fmA\n",voltage_min,(voltage_min-(no_of_led_series*v_drop_across_1_led))*1000/resistor);
 printf("supply is Standard. i.e. %f Volt, current across one LED %fmA\n",voltage_std,(voltage_std-(no_of_led_series*v_drop_across_1_led))*1000/resistor);
 voltage_dangerous=voltage_max;
 led_current_max=led_current;
 while (led_current_max <= 0.025){
  led_current_max=(voltage_dangerous-(no_of_led_series*v_drop_across_1_led))/resistor;
  voltage_dangerous+=1;
 }
 printf("Maximum voltage should not exceed %f Volt,\n LEDs will be blown above %fmA.\n",voltage_dangerous-1,led_current_max*1000);
 voltage_at_no_glow=voltage_min;
 led_current_min=led_current;
 while (led_current_min >= 0.001){
  led_current_min=(voltage_at_no_glow-(no_of_led_series*v_drop_across_1_led))/resistor;
  voltage_at_no_glow-=1;
 }
 printf("Minimum voltage should not be below %f Volt,\n LEDs will not glow below %fmA.\n",voltage_at_no_glow+1,led_current_min*1000);
 system("PAUSE");
 return 0;
}

