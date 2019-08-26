shader_type canvas_item;

uniform vec4 c_solid = vec4(1.,0.,1.,1.);
uniform vec4 c_background = vec4(0.89412, 0.09020, 0.30980,1.);    //#144702


void fragment(){
    vec4 c_screen = texture(SCREEN_TEXTURE,SCREEN_UV);
    vec4 c_texture = texture(TEXTURE,UV);
    
    COLOR = c_texture;
    if (c_screen == c_solid){        
        COLOR = c_background;
    }
}