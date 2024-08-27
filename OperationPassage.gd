extends Node3D

@export var operations = ["multiply", "divide", "add", "subtract"]
@export var min_value: int = 1
@export var max_value: int = 5

@onready var option1 = $işlem_0
@onready var option2 = $işlem_1

var operation1: String
var operation2: String
var value1: int
var value2: int

func _ready() -> void:
	_set_random_operations()
	_set_random_values()
	_position_options_randomly()

func _set_random_operations() -> void:
	operation1 = operations[randi() % operations.size()]
	operation2 = operations[randi() % operations.size()]

func _set_random_values() -> void:
	value1 = randi() % (max_value - min_value + 1) + min_value
	value2 = randi() % (max_value - min_value + 1) + min_value
	
	option1.get_node("Label").text = _get_display_text(operation1, value1)
	option2.get_node("Label").text = _get_display_text(operation2, value2)

func _get_display_text(operation: String, value: int) -> String:
	match operation:
		"multiply":
			return "x" + str(value)
		"divide":
			return "/" + str(value)
		"add":
			return "+" + str(value)
		"subtract":
			return "-" + str(value)
	return ""

func _position_options_randomly() -> void:
	# Seçeneklerin konumlarını rasgele değiştir
	if randi() % 2 == 0:
		option1.position.x = -1.5
		option2.position.x = 1.5
	else:
		option1.position.x = 1.5
		option2.position.x = -1.5

func _on_İşlem_0_body_entered(body: Node) -> void:
	if body is CharacterBody3D:
		_apply_operation(body, operation1, value1)
		queue_free()

func _on_İşlem_1_body_entered(body: Node) -> void:
	if body is CharacterBody3D:
		_apply_operation(body, operation2, value2)
		queue_free()

func _apply_operation(character: CharacterBody3D, operation: String, value: int) -> void:
	match operation:
		"multiply":
			character.score *= value
		"divide":
			character.score /= value
		"add":
			character.score += value
		"subtract":
			character.score -= value
