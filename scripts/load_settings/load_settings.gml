
function load_settings() {
	if (not file_exists(SETTINGS_FILE)) return;
	
	var buffer = buffer_load(SETTINGS_FILE);
	var content = buffer_read(buffer, buffer_text);
	buffer_delete(buffer);
	
	// Set values from save file
	var loadedSettings = json_parse(content);
	var names = struct_get_names(loadedSettings);
		
	for (var i = 0; i < array_length(names); i++) {
		var val = variable_struct_get(loadedSettings, names[i]);
		struct_set(Settings, names[i], val);
	}
}

function save_settings() {
	var str = json_stringify(Settings, true);
	var buffer = buffer_create(string_byte_length(str)+1, buffer_fixed, 1);
	
	buffer_write(buffer, buffer_text, str);
	buffer_save(buffer, SETTINGS_FILE);
	buffer_delete(buffer);
}

/*

var file = file_text_open_read(_file);
	
	while (!file_text_eof(file)) {
	  var line = file_text_read_string(file); file_text_readln(file);
		
		
		
		//if (line == "ITEM_REGISTER:") {
    //  var _id = file_text_read_string(file); file_text_readln(file);
    //  var _type = interpreter_item_type( file_text_read_string(file) ); file_text_readln(file);
    //  var _name = file_text_read_string(file); file_text_readln(file);
    //  var _sprite = file_text_read_string(file); file_text_readln(file);
    //  var _comp = file_text_read_string(file); file_text_readln(file);
			
		//	ITEM.register(
		//		real(_id),
		//		_type,
		//		_name,
		//		real(_sprite),			// TODO: Load sprite from path 
		//		json_parse(_comp)
		//	);
			
    //  if (_comp == "HALT") {
    //    break;
    //  }
    //}
	}
	
	file_text_close(file);