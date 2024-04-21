extends Node

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var nodes_to_save = get_tree().get_nodes_in_group("LeaderboardPersistentScore")
	for node in nodes_to_save:
		if !node.has_method("save"):
			print("persistent node '%s' does not have a save() function, skipped" % node.name)
			continue
		var data = node.save()
		var json_formatted_data = JSON.stringify(data)
		print(json_formatted_data)
		save_file.store_line(json_formatted_data)
	save_file.close()
