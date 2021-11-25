#https://stackoverflow.com/questions/17620884/static-linking-of-sdl2-libraries
# apt-get install build-essential libzip-dev

#COMPILER_FLAGS specifies the additional compilation options we're using 
COMPILER_FLAGS = -c -Wall -O2

#LINKER_FLAGS specifies the libraries we're linking against 
LINKER_FLAGS = -lstdc++ -lSDL2 -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lm -lzip

SDL_WIN=/home/emilio/sdl_win/SDL2-2.0.16/x86_64-w64-mingw32
SDL_IMAGE=/home/emilio/sdl_win/SDL2_image-2.0.5/x86_64-w64-mingw32

# Include Windows
INCL_WIN=-I$(SDL_WIN)/include

# lIB Windows
LIB_WIN=-L$(SDL_WIN)/lib -L$(SDL_IMAGE)/lib

all: juego

JEngine.o: JEngine.cpp JEngine.hpp
	gcc $(COMPILER_FLAGS) JEngine.cpp -o JEngine.o
	
Juego.o: Juego.cpp Juego.hpp
	gcc $(COMPILER_FLAGS) Juego.cpp -o Juego.o

Resource.o: Resource.cpp Resource.hpp
	gcc $(COMPILER_FLAGS) Resource.cpp -o Resource.o

main.o: main.cpp
	gcc $(COMPILER_FLAGS) main.cpp -o main.o

juego: main.o JEngine.o Juego.o Resource.o
	gcc $(LINKER_FLAGS) main.o JEngine.o Resource.o Juego.o -o juego
	
debug: JEngine.cpp JEngine.hpp Juego.cpp Juego.hpp Resource.cpp Resource.hpp main.cpp
	gcc -g $(LINKER_FLAGS) JEngine.cpp JEngine.hpp Juego.cpp Juego.hpp Resource.cpp Resource.hpp main.cpp -o debug

clean:
	rm -f *.o *.exe *.zip *.dat juego debug

JEngine.win.o: JEngine.cpp JEngine.hpp
	x86_64-w64-mingw32-gcc $(INCL_WIN) $(LIB_WIN) $(COMPILER_FLAGS) JEngine.cpp -o JEngine.win.o
	
Resource.win.o: Resource.cpp Resource.hpp
	x86_64-w64-mingw32-gcc $(INCL_WIN) $(LIB_WIN) $(COMPILER_FLAGS) Resource.cpp -o Resource.win.o
	
Juego.win.o: Juego.cpp Juego.hpp
	x86_64-w64-mingw32-gcc $(INCL_WIN) $(LIB_WIN) $(COMPILER_FLAGS) Juego.cpp -o Juego.win.o

main.win.o: main.cpp
	x86_64-w64-mingw32-g++ $(INCL_WIN) $(COMPILER_FLAGS) winmain.cpp -o main.win.o

juego.exe: main.win.o JEngine.win.o Juego.win.o
	x86_64-w64-mingw32-g++ $(LIB_WIN) -static main.win.o JEngine.win.o Resource.win.o Juego.win.o `$(SDL_WIN)/bin/sdl2-config --static-libs` -lSDL2_image -o juego.exe

juego.dat: background.png
	zip -j juego.dat background.png

juego.zip: juego.exe juego.dat
	zip -j juego.zip juego.exe juego.dat $(SDL_IMAGE)/bin/libpng16-16.dll $(SDL_IMAGE)/bin/zlib1.dll background.png
