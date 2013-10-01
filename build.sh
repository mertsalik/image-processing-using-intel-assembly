#!/usr/bin/env bash

#	Author: mertsalik
#	mail:	salik@itu.edu.tr

#needs two parameter
assemble_with_nasm(){
	nasm -f elf32 $1 -o $2
}

#asseble first
for line in $(find ./src -iname '*.asm'); do
	if [ $line ]; then
		objfile=${line/%asm/o}
		#echo $line$objfile
		assemble_with_nasm $line $objfile
	fi
done

#compile main C file
gcc -c ./src/bitmap.c -o ./src/bitmap.o

#move all objects to objdir
if [ ! -d "./src/objdir" ]; then
	mkdir ./src/objdir
fi
mv ./src/*.o ./src/objdir

#create folder for executable
if [ ! -d "./bin" ]; then
	mkdir ./bin
fi

#link all
gcc ./src/objdir/*.o -o ./bin/bitmap
