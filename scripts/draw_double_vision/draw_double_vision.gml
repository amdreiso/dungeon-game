function draw_double_vision(){

if (!surface_exists(application_surface)) return;

var surf = application_surface;

var offset = sin(current_time * 0.001) * 10;
var alpha = 0.12;

draw_surface_ext(surf, offset, 0, 1, 1, 0, c_orange, alpha);
draw_surface_ext(surf, -offset, 0, 1, 1, 0, c_aqua, alpha);

}