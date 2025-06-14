function draw_debug(){

var height = 12;

draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_text(WIDTH, 0, $"{Game.name} {Game.version} by {Game.author}");
draw_text(WIDTH, 1 * height, $"{fps} FPS");



}