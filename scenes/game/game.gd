extends Node2D

const BLOCK_ROWS = 8
const BLOCK_COLUMNS = 16
const MARGIN = 30
const BLOCK_X_PADDING = 60
const BLOCK_Y_PADDING = 15
const COLOR_MAP = {
	0: Color.MAROON, 
	1: Color.LIGHT_CORAL,
	2: Color.LIGHT_SALMON,
	3: Color.LIGHT_YELLOW,
	4: Color.LIGHT_GREEN,
	5: Color.SEA_GREEN,
	6: Color.CORNFLOWER_BLUE,
	7: Color.MEDIUM_PURPLE}
const SFX_PITCH_SCALE = {
	0: 2.4, 
	1: 2.2,
	2: 2,
	3: 1.8,
	4: 1.6,
	5: 1.4,
	6: 1.2,
	7: 1}
const POINTS = {
	0: 10, 
	1: 7,
	2: 4,
	3: 1}
enum {PRE_GAME, PLAYING, PAUSED, GAME_OVER}

var blocks
var block_resource
var pre_game_screen_resource
var pre_game_screen
var game_state

signal toggled_pause 

# Called when the node enters the scene tree for the first time.
func _ready():
	game_state = PRE_GAME
	block_resource = preload("res://scenes/block/block.tscn")
	pre_game_screen_resource = preload("res://scenes/pre_game_screen/pre_game_screen.tscn")
	create_blocks()
	create_pre_game_screen()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_accept") && game_state == PRE_GAME:
		game_state = PLAYING
		pre_game_screen.position.x = - 1000
		pre_game_screen.position.y = - 1000
		$Ball.start_movement()
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		toggled_pause.emit(true)

func create_blocks():
	blocks = Array()
	for i in range(BLOCK_ROWS):
		blocks.append(Array())
		for j in range(BLOCK_COLUMNS):
			blocks[i].append(block_resource.instantiate())
			blocks[i][j].position.x = MARGIN + j * BLOCK_X_PADDING
			blocks[i][j].position.y = MARGIN + i * BLOCK_Y_PADDING
			blocks[i][j].modulate = COLOR_MAP[i]
			blocks[i][j].points = POINTS[i/2]
			blocks[i][j].sfx_pitch_scale = SFX_PITCH_SCALE[i]
			add_child(blocks[i][j])

func create_pre_game_screen():
	pre_game_screen = pre_game_screen_resource.instantiate()
	add_child(pre_game_screen)


func _on_losing_zone_body_entered(body):
	if body is Ball:
		game_state = GAME_OVER
		LeaderboardManager.current_score = $Score.score
		get_tree().change_scene_to_file("res://scenes/game_over_screen/game_over_screen.tscn")
