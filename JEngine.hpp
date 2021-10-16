#include <SDL2/SDL.h>
#include <SDL2/SDL_ttf.h>
#include <SDL2/SDL_image.h>
#include <SDL2/SDL_mixer.h>

#ifndef JENGINE_HPP
#define JENGINE_HPP

using namespace std;

class JEngine {
    private:
        void sync_render(void);
        void process_input(SDL_Event *e);
        bool quit;
    protected:
        //Screen dimension constants
        int SCREEN_WIDTH;
        int SCREEN_HEIGHT;
        // Frames count
        unsigned int frames;
        //The window we'll be rendering to
        SDL_Window *sdl_window;
        //The window renderer
        SDL_Renderer* sdl_renderer;
        // Display mode
        SDL_DisplayMode sdl_display_mode;
        //Game Controllers 
        SDL_Joystick *sdl_gamepads[2];
    public:
        JEngine(void);
        ~JEngine(void);
        void init(void);
        void close(void);
        void run(void);
        void render(void);
        virtual void render_game(void);
        virtual void update_game(void);        
};

#endif
