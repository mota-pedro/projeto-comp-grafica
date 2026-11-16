extends Node2D

const BACKGROUNDS := [
	preload("res://Assets/Pagina 2  - Estado 1.png"),
	preload("res://Assets/Pagina 2  - Estado 2.png"),
	preload("res://Assets/Pagina 2  - Estado 3.png"),
]
const OBJECTS := [
	preload("res://Assets/arvore.png"),
	preload("res://Assets/madeira.png"),
	preload("res://Assets/cadeira.png"),
]

var state := 0
var transitioning := false

func _ready() -> void:
	$"Button Anterior".pressed.connect(func(): get_tree().change_scene_to_file("res://Capa/capa.tscn"))
	$"Button Proximo".pressed.connect(func(): get_tree().change_scene_to_file("res://Referencias/referencias.tscn"))
	$Object.input_event.connect(_on_object_input_event)
	_show_state(0, false)

func _on_object_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		_advance_state()
	elif event is InputEventScreenTouch and event.pressed:
		_advance_state()

func _advance_state() -> void:
	if transitioning:
		return
	transitioning = true
	var sprite: Sprite2D = $Object/Sprite
	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property(sprite, "scale", Vector2.ZERO, 0.22).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.tween_property(sprite, "modulate:a", 0.0, 0.18)
	tween.chain().tween_callback(func(): _show_state((state + 1) % 3, true))

func _show_state(next_state: int, animate_in: bool) -> void:
	state = next_state
	$Background.texture = BACKGROUNDS[state]
	$Object.position = Vector2(384, 620 if state != 2 else 650)
	var sprite: Sprite2D = $Object/Sprite
	sprite.texture = OBJECTS[state]
	sprite.position = Vector2.ZERO
	sprite.scale = Vector2.ZERO if animate_in else Vector2.ONE
	sprite.modulate.a = 0.0 if animate_in else 1.0
	if animate_in:
		var tween := create_tween()
		tween.set_parallel(true)
		tween.tween_property(sprite, "scale", Vector2.ONE, 0.35).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
		tween.tween_property(sprite, "modulate:a", 1.0, 0.25)
		tween.chain().tween_callback(func(): transitioning = false)
	else:
		transitioning = false
