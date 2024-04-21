extends Label

const SCORE_TEXT = "SCORE: "

var score

# Called when the node enters the scene tree for the first time.
func _ready():
	score = 0
	change_score(score)

func change_score(new_score):
	score = new_score
	text = SCORE_TEXT + str(score)
