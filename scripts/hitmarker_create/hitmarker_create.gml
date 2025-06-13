function hitmarker_create(val, color = c_red, degrade = true, range = 5, scale = 0.5, prefix = "-"){
	var xx = x + irandom_range(-range, range);
	var yy = y + irandom_range(-range, range);
	
	var hm = instance_create_depth(xx, yy, -99999, Hitmarker);
	hm.scale = scale;
	hm.color = color;
	hm.str = prefix + string(val);
	hm.degrade = degrade;
}