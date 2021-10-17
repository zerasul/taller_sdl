#COMPILER_FLAGS specifies the additional compilation options we're using 
COMPILER_FLAGS = -c -Wall -O2

#LINKER_FLAGS specifies the libraries we're linking against 
LINKER_FLAGS = -lstdc++ -lSDL2 -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lm

all: juego

JEngine.o: JEngine.cpp JEngine.hpp
	gcc $(COMPILER_FLAGS) JEngine.cpp -o JEngine.o
	
Juego.o: Juego.cpp Juego.hpp
	gcc $(COMPILER_FLAGS) Juego.cpp -o Juego.o

main.o: main.cpp
	gcc $(COMPILER_FLAGS) main.cpp -o main.o

juego: main.o JEngine.o Juego.o
	gcc $(LINKER_FLAGS) main.o JEngine.o Juego.o -o juego

clean:
	rm -f *.o juego debug	
