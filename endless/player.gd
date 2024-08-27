extends CharacterBody3D

@export var min_x: float = -3.0
@export var max_x: float = 3.0

const SPEED = 5.0

var score: float = 0.0
var highscore: int = 0

@onready var score_label = get_node("/root/World/Player/Camera3D/ScoreLabel")
@onready var highscore_label = get_node("/root/World/Player/Camera3D/HighscoreLabel")
@onready var highscore_manager = get_node("/root/HighscoreManager") # HighscoreManager'ı referans alın

func _ready() -> void:
	highscore = highscore_manager.load_highscore() # Yüksek skoru yükle
	_update_highscore_label()

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction.length() > 0:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	var new_position := position
	new_position.x = clamp(new_position.x, min_x, max_x)
	position = new_position

	_update_score(delta)

	var collision = get_last_slide_collision()
	if collision:
		print("Collided with: ", collision.get_collider())
		_save_highscore()
		print("Game Over! Your score was: ", int(score))
		print("Highscore: ", highscore)
		get_tree().change_scene_to_file("res://Menü.tscn") # Menü sahnesinin yolu

func _update_score(delta: float) -> void:
	score += 10 * delta
	if score_label:
		score_label.text = "Score: " + str(int(score))
	else:
		print("ScoreLabel node not found.")

func _update_highscore_label() -> void:
	if highscore_label:
		highscore_label.text = "Highscore: " + str(highscore)
	else:
		print("HighscoreLabel node not found.")

func _save_highscore() -> void:
	if score > highscore:
		highscore_manager.update_highscore(int(score)) # HighscoreManager'a skoru kaydet
	highscore = highscore_manager.load_highscore() # Yeniden yükle
	_update_highscore_label() # Label'ı güncelle
