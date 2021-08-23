#include <stdlib.h>
#include <iup.h>

int main(int argc, char **argv)
{

  IupOpen(&argc, &argv); /* initialize iup toolkit */
  
  /* code */
  
  IupClose(); /* close iup toolkit, free internal memory
                  and close the interface */
  return EXIT_SUCCESS;
}
