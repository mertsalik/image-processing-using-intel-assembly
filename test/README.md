Build
=====================================

  `g++ bitmap.cpp -o test`
  
Run
=====================================

  `./test # lena.bmp |value|`

Test Methods
=====================================

- Function 1:

  `void brightness(unsigned char *image, int width, int height, int val);`

- Function 2:

  `void contrast(unsigned char *image, int width, int height, int val);`

- Function 3:
  
  `void average(unsigned char *image, unsigned char *image2,
               int width, int height);`

- Function 4:

  `void grow(unsigned char *image, unsigned char *newimage, int width, int height);`

- Function 5:

  `void shrink(unsigned char *image, unsigned char *newimage, int width, int height);`

- Function 6:

  `void blur(unsigned char *image, int width, int height);`

- Function 7:

  `void invert(unsigned char *image, int width, int height);`

- Function 8:

  `void edge(unsigned char *image, int width, int height);`

- Function 9:

  `int atleast(unsigned char *image, int width, int height, int val);`

- Function 10:

  `void clear(unsigned char *image, int width, int height, int val);`
