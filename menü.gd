extends Control

@onready var endless_start = $EndlessStart
@onready var level = $Level
@onready var market_button = $MarketButton
@onready var highscore_label = $HighscoreLabel
@onready var highscore_manager = $HighscoreManager

func _ready() -> void:
	# Highscore'u HighscoreManager'dan al ve label'a yaz
	if highscore_manager:
		highscore_label.text = "Highscore: " + str(highscore_manager.load_highscore())
	else:
		print("HighscoreManager not found.")

	# Start butonuna tıklama olayını bağla
	endless_start.connect("pressed", Callable(self, "_on_endless_start_button_pressed"))
	level.connect("pressed", Callable(self, "_on_level_button_pressed"))
	market_button.connect("pressed", Callable(self, "_on_market_button_pressed"))

func _on_endless_start_button_pressed() -> void:
	# Oyunu başlat
	get_tree().change_scene_to_file("res://endless/world.tscn") # Oyunun ana sahnesinin yolu

func _on_level_button_pressed() -> void:
	# Oyunu başlat
	get_tree().change_scene_to_file("res://level/world_main.tscn") # Oyunun ana sahnesinin yolu
