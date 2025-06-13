function effect_add(effectID, time){
	
	var e = EFFECT.get(effectID);
	
	for (var i = 0; i < array_length(effects); i++) {
		if (effects[i].effectID == effectID) {
			effects[i].time = effects[i].timeMax;
			return false;
		}
	}
	
	array_push(
		effects,
		{
			effectID: effectID,
			time: time,
			timeMax: time,
		}
	);
	
	e.load(self);
	
	return true;
}