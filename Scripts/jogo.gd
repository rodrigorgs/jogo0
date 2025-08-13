extends Node2D

var entidades: Array[Node]
@export var pontos := 0
@export var vidas := 10

func _ready():
	$Jogador.scale = Vector2(0.8, 0.8)
	entidades = $Entidades.get_children()
	for entidade in entidades:
		entidade.hit.connect(_on_hit)
	_atualiza_hud()

func _on_hit(entidade: Entidade):
	vidas -= entidade.dano
	pontos += entidade.pontos
	_atualiza_hud()
	print('hitou e atualizou o HUD')

func _atualiza_hud():
	#var s = 0.8 + pontos / 100
	#global_scale = Vector2(s, s)
	$CanvasLayer/Pontos.text = "Pontos: %d" % [pontos]
	$CanvasLayer/Vidas.text = "Vidas: %d" % [vidas]
	
