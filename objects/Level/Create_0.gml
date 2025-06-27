
busy = false;

storedCoins = 0;

roomSize = [
	dim(320, 180),
	dim(400, 400),
	dim(520, 380),
];

levelSurface = surface_create(WIDTH, HEIGHT);

setRoomSize = function(israndom, index=0) {
	if (israndom) {
		roomIndex = irandom(array_length(roomSize) - 1);
	} else {
		roomIndex = index;
	}
	
	width = roomSize[roomIndex].width * 2;
	height = roomSize[roomIndex].height * 2;
}

setRoomSize(true);

getRoomSize = function() {
	roomIndex = irandom(array_length(roomSize) - 1);

	width = roomSize[roomIndex].width * 2;
	height = roomSize[roomIndex].height * 2;
}

getRoomSize();

roomUpdate = true;

enum ROOM_TYPE {
	Normal,
	Shop,
	Treasure,
	Health,
	Boss,
	Count,
}

createLevel = function(normal, shop, treasure) {
	var arr = [];
	
	repeat(normal) {array_push(arr, ROOM_TYPE.Normal);}
	repeat(shop) {array_push(arr, ROOM_TYPE.Shop);}
	repeat(treasure) {array_push(arr, ROOM_TYPE.Treasure);}
	
	return arr;
}

shuffleLevel = function(level) {
	var len = array_length(level);
	for (var i = len - 1; i > 0; i--) {
		var j = irandom(i);
		var temp = level[i];
		level[i] = level[j];
		level[j] = temp;
	}
	array_push(level, ROOM_TYPE.Boss);
	return level;
}

generateLevel = function(level) {
	return shuffleLevel(level);
}

layout = generateLevel(createLevel(10, 1, 1));


// Infinite
infiniteConfig = {
	maxEnemiesOnScreen: 50,
	maxEnemiesCount: 100,
};

infiniteDifficulty = "easy";

isInfinite = false;

horde = 0;
hordeCooldown = 0;
newHorde = true;
hordeEndCooldown = 120;
hordeEnemyMultiplier = 0.25;

hordeComplete = function() {
	horde ++;
	hordeCooldown = 5 * 60;
	newHorde = true;
	textScale = 3;
	
	if (enemyCountAdd < 10) enemyCountAdd ++;
}

hasEnemies = false;

resetEnemySpawnTime = function() {
	return random_range(1.00, 4.00) * 60;
}

enemyCountDefault = 10;
enemyCount = enemyCountDefault;
enemyCountIndex = 0;
enemyCountAdd = 2;
enemySpawnTime = resetEnemySpawnTime();
enemySpawnTick = 0;

spawnEnemy = function() {
	if (instance_number(Enemy) >= infiniteConfig.maxEnemiesOnScreen || Player.busy) return;
	
	var range = 1000;
	var minDistance = 500;
	var funnyValue = 500;
	
	var pos = irandvec2(Player.x, Player.y, range);
	
	//var pos = vec2(
	//	irandom_range(Player.x - range, Player.x + range),
	//	irandom_range(Player.y - range, Player.y + range)
	//);
	
	// If enemy is closer than minDistance pixels to the player, recalculate position
	var con = (
		point_distance(Player.x, Player.y, pos.x, pos.y) < minDistance
	);
	
	if (con) {
		return false;
	}
	
	// Spawn enemy at random position
	var enemyObj = choose(Enemy_Orc, Enemy_Skeleton);
	var enemy = instance_create_depth(pos.x, pos.y, depth, enemyObj);
	
	enemyCountIndex --;
	
	enemySpawnTick = 0;
	enemySpawnTime = (resetEnemySpawnTime()) - enemyCount / 5;
	
	return true;
}


infiniteMode = function() {
	
	hordeCooldown = max(0, hordeCooldown - GameSpeed);
	hasEnemies = (instance_number(Enemy) > 0);

	if (newHorde && hordeCooldown <= 0) {
		newHorde = false;
	}

	enemySpawnTick += GameSpeed;

	if (enemySpawnTick >= enemySpawnTime && enemyCountIndex > 0) {
		var amount = 1;
		amount = irandom_range(1, enemyCountIndex div (enemyCountDefault / 4));
	
		repeat(amount) spawnEnemy();
	}

	if (hasEnemies) {
		hordeEndCooldown = HORDE_END_COOLDOWN;
	} else {
		hordeEndCooldown -= GameSpeed;
	}

	if (enemyCountIndex <= 0 && !hasEnemies && hordeEndCooldown <= 0) {
		enemyCount = floor(enemyCount + enemyCountAdd);
		enemyCount = clamp(enemyCount, 10, infiniteConfig.maxEnemiesCount);
		
		enemyCountIndex = enemyCount;
		hordeComplete();
	}
	
}

drawInfiniteGUI = function() {
	draw_set_font(fnt_level);

	draw_surface(levelSurface, 0, 0);

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	if (hordeCooldown > 0) {
		textScale += 0.005;
		textAlpha = lerp(textAlpha, 1, 0.05);
		textColor = color_lerp(textColor, c_red, 0.05);
	} else {
		textAlpha = lerp(textAlpha, 0, 0.05);
		textColor = color_lerp(textColor, c_white, 0.05);
	}

	draw_text_transformed_color(
		WIDTH / 2, HEIGHT / 1.5, horde, textScale * abs(sin(current_time * 0.0001) * 3), textScale, sin(current_time * 0.005) * 5, 
		textColor, textColor, textColor, textColor, textAlpha
	);

	draw_set_halign(fa_left);
	draw_set_valign(fa_bottom);

	var margin = 5;

	draw_text_transformed(margin, HEIGHT - margin, horde, 3, 3, 0);
	
	draw_set_font(fnt_main);
}

textColor = c_white;
textAlpha = 0;
textScale = 3;


