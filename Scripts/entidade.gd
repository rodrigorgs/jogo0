@tool
class_name Entidade
extends Node2D

signal hit
var screen_size
var direction := Vector2(0, 0)

@export var velocidade: float = 300
@export var dano: int = 0
@export var pontos: int = 0
@export_file("*.png", "*.jpg", "*.jpeg", "*.webm") var imagem: String = "res://Imagens/inimigo1.png":
	set(value):
		imagem = value
		if imagem != "":
			var tex = load(imagem)
			if tex is Texture2D:
				$Sprite2D.texture = tex

@export_file("*.wav", "*.aiff", "*.mp3", "*.ogg") var som: String = "res://Audio/inimigo1.wav":
	set(value):
		som = value
		if som != "":
			var stream = load(som)
			if stream is AudioStream:
				$AudioStreamPlayer2D.stream = stream


func _ready():
	screen_size = get_viewport_rect().size
	spawn(false)

func spawn(random_position=true):
	var angle = randf() * PI * 2
	direction = Vector2(cos(angle), sin(angle))
	if (random_position):
		position.x = randf() * screen_size.x
		position.y = randf() * screen_size.y

func _process(delta):
	if not Engine.is_editor_hint():
		position += direction * velocidade * delta
	
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0

func _on_area_entered(area: Area2D) -> void:
	hide()
	$CollisionShape2D.set_deferred("disabled", true)
	hit.emit()
	$RespawnTimer.start()

func _on_hit() -> void:
	$AudioStreamPlayer2D.play()

func _on_respawn_timer_timeout() -> void:
	show()
	$CollisionShape2D.set_deferred("disabled", false)
	$Sprite2D.self_modulate.a = 1.0
	spawn()
	
