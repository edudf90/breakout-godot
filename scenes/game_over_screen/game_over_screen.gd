class_name GameOverScreen

extends Node2D

func _ready():
	$VBoxContainer/FinalScore.change_score(LeaderboardManager.current_score)
	if LeaderboardManager.will_current_score_enter_leaderboard():
		$VBoxContainer/Keyboard.visible = true
	else:
		$VBoxContainer/Leaderboards.visible = true
		$VBoxContainer/NewGame.visible = true
		$VBoxContainer/MainMenu.visible = true
		$VBoxContainer/Quit.visible = true
		$VBoxContainer/Leaderboards.pressed.connect(on_leaderboards_button_pressed)
		$VBoxContainer/NewGame.pressed.connect(on_new_game_button_pressed)
		$VBoxContainer/MainMenu.pressed.connect(on_main_menu_button_pressed)
		$VBoxContainer/Quit.pressed.connect(on_quit_button_pressed)


func _on_keyboard_text_submitted():
	var score = Highscore.new()
	score.player_tag = $VBoxContainer/Keyboard/Field.text
	score.score = LeaderboardManager.current_score
	LeaderboardManager.insert_score_sorted(score)
	get_tree().change_scene_to_file("res://scenes/leaderboard/leaderboard.tscn")

func on_leaderboards_button_pressed():
	get_tree().change_scene_to_file("res://scenes/leaderboard/leaderboard.tscn")

func on_new_game_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")

func on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_screen/start_screen.tscn")

func on_quit_button_pressed():
	get_tree().quit()
