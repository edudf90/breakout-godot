class_name Highscore
extends Node

var player_tag :String
var score :int

func save():
	var save_dict = {
		"type" : "Highscore",
		"player_tag" : player_tag,
		"score" : score
	}
	return save_dict

func load_data(data):
	player_tag = data["player_tag"]
	score = data["score"]
	add_to_group("LeaderboardPersistentScore")
