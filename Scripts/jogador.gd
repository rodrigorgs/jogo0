extends Area2D

signal hit

var angle = 0.0
var screen_size: Vector2
@export var rotation_speed = 4
@export var speed = 300

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		angle -= rotation_speed * delta
	if Input.is_action_pressed("ui_right"):
		angle += rotation_speed * delta
	rotation = angle

	var direction = Vector2(cos(angle), sin(angle))
	position += direction * speed * delta
	
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0
		

func _on_area_entered(area: Area2D) -> void:
	if area.dano > 0:
		$RespawnTimer.start()
		$Sprite2D.self_modulate.a = 0.3
		$CollisionShape2D.set_deferred("disabled", true)
	hit.emit()
	

func _on_respawn_timer_timeout() -> void:
	$Sprite2D.self_modulate.a = 1.0
	$CollisionShape2D.set_deferred("disabled", false)
