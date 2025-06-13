function effects_apply(obj){
	for (var i = 0; i < array_length(effects); i++) {
		var e = effects[i];
		e.time -= GameSpeed;
		
		var effect = EFFECT.get(e.effectID);
		
		if (e.time <= 0) {
			effect.destroy(obj);
			array_delete(effects, i, 1);
		}
		
		effect.update(obj);
	}
}