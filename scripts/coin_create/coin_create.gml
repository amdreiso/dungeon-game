function coin_create(x, y){
	if (instance_number(Coin) >= 100) {
		Level.storedCoins ++;
		return;
	}
	
	var coin = (instance_create_depth(x, y, depth, Coin));
	coin.force.x = random_range(-1.0, 1.0) * 6;
	coin.force.y = -random_range(0.10, 1.00) * 3;
	
	coin.fallingTime = -floor(coin.force.y) * 10;
}