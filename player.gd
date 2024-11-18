extends Area2D

signal hit

##How fast the player will move (pixels/sec)
@export var speed := 400
var screen_size: Vector2
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity := Input.get_vector("move_left","move_right","move_up","move_down")
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
		
	if velocity.x !=0:
		animated_sprite_2d.animation = "walk"
		animated_sprite_2d.flip_v = false
		animated_sprite_2d.flip_h = velocity.x < 0
		animated_sprite_2d.play()
	elif velocity.y != 0:
		animated_sprite_2d.animation = "up"
		animated_sprite_2d.flip_v = velocity.y > 0
		animated_sprite_2d.play()
	else:
		animated_sprite_2d.stop
		



func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	collision_shape_2d.set_deferred("disabled", true)
