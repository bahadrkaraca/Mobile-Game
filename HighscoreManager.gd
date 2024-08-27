extends Node

var highscore: int = 0

func _ready() -> void:
	highscore = load_highscore()

func update_highscore(new_score: int) -> void:
	if new_score > highscore:
		highscore = new_score
		save_highscore()

func save_highscore() -> void:
	var file = FileAccess.open("res://highscore.save", FileAccess.WRITE)
	if file:
		file.store_string(str(highscore))
		file.close()
	else:
		print("Failed to open file for writing.")

func load_highscore() -> int:
	var file = FileAccess.open("res://highscore.save", FileAccess.READ)
	if file:
		var saved_score = file.get_as_text().to_int()
		file.close()
		return saved_score
	else:
		print("Highscore file does not exist or failed to open.")
	return 0
