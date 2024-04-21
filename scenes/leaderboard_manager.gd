extends Node

const MAX_SIZE = 10

var current_score

var scores = Array()

func _ready():
	scores = GameLoader.load_game()
	scores.sort_custom(compare_highscores)
	for score in scores:
		add_child(score)

func will_current_score_enter_leaderboard():
	return scores.size() < MAX_SIZE or current_score > scores[-1].score

func insert_score_sorted(score):
	print(scores.size())
	if scores.size() >= MAX_SIZE:
		var index = scores.size() - 1
		var score_to_remove = scores[index]
		scores.remove_at(index)
		score_to_remove.free()
		print(scores.size())
	score.add_to_group("LeaderboardPersistentScore")
	scores.append(score)
	add_child(score)
	print(scores.size())
	scores.sort_custom(compare_highscores)
	GameSaver.save_game()

func compare_highscores(a, b):
	return true if a.score > b.score else false
