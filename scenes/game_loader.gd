extends Node

func load_game():
	var loaded_data = Array()
	if not FileAccess.file_exists("user://savegame.save"):
		return loaded_data
	clear_current_persist_nodes()
	var loaded_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	while loaded_file.get_position() < loaded_file.get_length():
		var json_string = loaded_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue
		var node_data = json.get_data()
		if node_data["type"] == "Highscore":
			var new_object = Highscore.new()
			new_object.load_data(node_data)
			loaded_data.append(new_object)
	return loaded_data

func clear_current_persist_nodes():
	var nodes_to_persist = get_tree().get_nodes_in_group("LeaderboardPersistentScore")
	for node in nodes_to_persist:
		node.queue_free()
