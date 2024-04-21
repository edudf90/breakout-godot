extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_start_game_button_button_up():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")


func _on_leaderboards_button_button_up():
	get_tree().change_scene_to_file("res://scenes/leaderboard/leaderboard.tscn")


func _on_quit_button_up():
	get_tree().quit()
	pass # Replace with function body.
