function coin_add(val){

if (!instance_exists(Player)) {
	err("player doesn't exist!");
	return;
}

with (Player) {
	coins += val + Level.storedCoins;
	Level.storedCoins = 0;
			
	ini_open(SAVE_FILE);
	ini_write_real("PlayerData", "Coins", coins);
	ini_close();
}

}