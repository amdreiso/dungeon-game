function draw_debug(){

var height = 12;
var px = 0, py = 0;
if (instance_exists(Player)) {
	px = Player.x; 
	py = Player.y;
}

var ec = 0;
if (instance_exists(Level)) {
	ec = Level.enemyCount;
}

draw_set_font(fnt_console);


draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_text(WIDTH, 0, $"{Game.name} {Game.version} by {Game.author}");
draw_text(WIDTH, 1 * height, $"{fps} FPS");
draw_text(WIDTH, 2 * height, $"proj: {instance_number(Projectile)} obj: {instance_count}");
draw_text(WIDTH, 3 * height, $"px: {px} py: {py}");
draw_text(WIDTH, 4 * height, $"ec: {ec}");


draw_set_font(fnt_main);


}