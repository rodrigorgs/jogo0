extends Node2D

var pontos = 0

func _ready():
	$CanvasLayer/Label.text += str(pontos)

func _on_restart_button_pressed() -> void:
	get_tree().change_scene_to_file("res://jogo.tscn")
