extends Node2D

func _ready() -> void:
	$"Button Anterior".pressed.connect(func(): get_tree().change_scene_to_file("res://Pagina02/pagina02.tscn"))
	$"Button Proximo".pressed.connect(func(): get_tree().change_scene_to_file("res://Contracapa/contracapa.tscn"))
