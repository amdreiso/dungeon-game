function camera_shake(val, pwr = 1){
	if (!instance_exists(Camera)) return;
	
	Camera.shakeValue = val;
	Camera.shakePower = pwr;
}