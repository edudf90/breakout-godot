extends StaticBody2D

class_name Block

var points = 0
var sfx_pitch_scale = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_sfx():
	get_node("CollisionSFX").pitch_scale = sfx_pitch_scale
	get_node("CollisionSFX").play()
