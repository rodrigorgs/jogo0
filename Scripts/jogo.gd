extends Node2D

var entidades: Array[Node]
@export var pontos := 0
@export var vidas := 1

func _ready():
	$Jogador.scale = Vector2(0.8, 0.8)
	entidades = $Entidades.get_children()
	for entidade in entidades:
		entidade.hit.connect(_on_hit)
	_atualiza_hud()

func _on_hit(entidade: Entidade):
	pontos += entidade.pontos
	vidas -= entidade.dano
	if vidas < 0:
		vidas = 0
	_atualiza_hud()

func _atualiza_hud():
	$CanvasLayer/Pontos.text = "Pontos: %d" % [pontos]
	$CanvasLayer/Vidas.text = "Vidas: %d" % [vidas]
	if vidas == 0:
		_game_over()
	
func _game_over():	
	var scene = load("res://game_over.tscn").instantiate()
	scene.pontos = pontos
	get_tree().root.add_child(scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = scene
