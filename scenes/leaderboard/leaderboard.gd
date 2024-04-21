extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	for score in LeaderboardManager.scores:
		var player_tag_label = Label.new()
		player_tag_label.text = score.player_tag
		var score_label = Label.new()
		score_label.text = str(score.score)
		var container = HBoxContainer.new()
		$VBoxContainer.add_child(container)
		player_tag_label.custom_minimum_size.x = 58
		player_tag_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		player_tag_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		container.add_child(player_tag_label)
		score_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		score_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		container.add_child(score_label)
	var main_menu_button = Button.new()
	main_menu_button.text = "MAIN MENU"
	main_menu_button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	$VBoxContainer.add_child(main_menu_button)
	main_menu_button.pressed.connect(on_main_menu_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/start_screen/start_screen.tscn")
