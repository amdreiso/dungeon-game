function effects_transfer(obj){
	
	for (var i = 0; i < array_length(obj.effects); i++) {
		var e = obj.effects[i];
		
		effect_add(e.effectID, e.timeMax);
	}
	
}