#include <stdio.h>
#include <stdlib.h>

// prototypes of the functions to be implemented in assembly level
void brightness(unsigned char *i1, int w, int h, int val);
void contrast(unsigned char *i1, int w, int h, int val);
void average(unsigned char *i1, unsigned char *i2, int w, int h);
void grow(unsigned char *i1, unsigned char *i2, int w, int h);
void shrink(unsigned char *i1, unsigned char *i2, int w, int h);
void blur(unsigned char *i1, int w, int h);
void invert(unsigned char *i1, int w, int h);
void edge(unsigned char *i1, int w, int h);
int  atleast(unsigned char *i1, int w, int h, int val);
void clear(unsigned char* i1, int w, int h, int val);

int main(int argc, char *argv[]){
	// variables
	int value = 0;
	int choice = 0;
	int i,j;
    char information[54];
	int width, height;
	unsigned char *image1,*image2;
	char outfilename[512];
    FILE *input, *output;
	
	// argument check
	if (argc < 3){
		printf("usage: ./program op_num input1.bmp [value|input2.bmp]\n");
		return 1;
	}
	choice = atoi(argv[1]);
	
	// read input image (It must be a 24-bit bmp file)
	input = fopen(argv[2],"rb");
	fread(information, 1, 54, input);
	width = *(int*)(information+18);
	height = *(int*)(information+22);
	image1 = (unsigned char*) calloc(width*height,1); 
	unsigned char blue, green, red;
	for (i=0; i<height; i++)
		for (j=0; j<width; j++){
			blue = getc(input);
            green = getc(input);
            red = getc(input);
			// convert to grayscale
			image1[i*width+j] = (blue+green+red)/3;
		}
	fclose(input);

	// brightness operation
	if (choice == 1){
		if (argc < 4){
			printf("usage: ./program 1 input1.bmp value\n");
			return 1;
		}
		value = atoi(argv[3]);
		if (value < -255 || value > 255){
			printf("value must be in [-255,255] for this operation\n");
			return 1;
		}
		brightness(image1,width,height,value);
	}

	// contrast operation
	else if(choice == 2){
		if (argc < 4){
			printf("usage: ./program 2 input1.bmp value\n");
			return 1;
		}
		value = atoi(argv[3]);
		if (value < 0 || value > 255){
			printf("value must be in [0,255] for this operation\n");
			return 1;
		}
		contrast(image1,width,height,value);
	}

	// average operation
	else if(choice == 3){
		if (argc < 4){
			printf("usage: ./program 3 input1.bmp input2.bmp\n");
			return 1;
		}
		// read the second input image
		input = fopen(argv[3],"rb");
		char information[54];
		fread(information, 1, 54, input);
		int width2 = *(int*)(information+18);
		int height2 = *(int*)(information+22);
		if (width2!=width || height2!=height){
			printf("sizes are not compatible\n");
			return 1;
		}
		image2 = (unsigned char*) calloc(width*height,1);
		for (i=0; i<height; i++)
			for (j=0; j<width; j++){
				blue = getc(input);
				green = getc(input);
				red = getc(input);
				// convert to grayscale
				image2[i*width+j] = (blue+green+red)/3;
			}
		fclose(input);
		average(image1,image2,width,height);
	}

	// grow operation
	else if(choice == 4){
		image2 = (unsigned char*) calloc(width*height*4,1);
		grow(image1,image2,width,height);
		width*=2;
		height*=2;
		free(image1);
		image1 = image2;
	}

	// shrink operation
	else if(choice == 5){
		image2 = (unsigned char*) calloc(width*height/4,1);
		shrink(image1,image2,width,height);
		width/=2;
		height/=2;
		free(image1);
		image1 = image2;
	}

	// blur operation
	else if(choice == 6){
		blur(image1,width,height);
	}	

	// invert operation
	else if(choice == 7){
		invert(image1,width,height);
	}

	// edge operation
	else if(choice == 8){
		edge(image1,width,height);
	}

    // atleast operation
	else if(choice == 9){
		if (argc < 4){
			printf("usage: ./program 9 input1.bmp value\n");
			return 1;
		}
		value = atoi(argv[3]);
		if (value < 0 || value > 255){
			printf("value must be in [0,255] for this operation\n");
			return 1;
		}
		printf("%d pixels above or equal to %d\n", atleast(image1,width,height,value), value);
	}  

	// clear operation
	else if(choice == 10){
		if (argc < 4){
			printf("usage: ./program 10 input1.bmp value\n");
			return 1;
		}
		value = atoi(argv[3]);
		if (value < 0 || value > 255){
			printf("value must be in [0,255] for this operation\n");
			return 1;
		}
		clear(image1,width,height,value);
	}

	// wrong choice for operation
	else{
		printf("op_num must be in [1,10]\n");
		return 1;
	}

	// save the resulting image to a file
	if (choice != 9){
		outfilename[0]='o';
		outfilename[1]='u';
		outfilename[2]='t';
		outfilename[3]='_';
		for (i=0; argv[2][i]!='\0'; i++)
			outfilename[i+4]=argv[2][i];
		outfilename[i+4]='\0';
		output = fopen(outfilename,"wb");
		*(int*)(information+18) = width;
		*(int*)(information+22) = height;
		fwrite(information, 1, 54, output);
		for (i=0; i<height; i++)
			for (j=0; j<width; j++){
				putc(image1[i*width+j],output);
				putc(image1[i*width+j],output);
				putc(image1[i*width+j],output);
			}
		fclose(output);
	}
	free(image1);
	
	return 0;
}
