extends Node2D

func _ready() -> void:
	$"Button Anterior".pressed.connect(func(): get_tree().change_scene_to_file("res://Referencias/referencias.tscn"))
	$"Button Inicio".pressed.connect(func(): get_tree().change_scene_to_file("res://Capa/capa.tscn"))
