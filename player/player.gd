extends Area2D

signal hit

## How fast the player will move (pixels/sec)
@export var speed := 400 

var screen_size: Vector2

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	screen_size = get_viewport_rect().size
	hide()


func _process(delta: float) -> void:
	# Check for input
	var velocity := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	# Move in the given direction
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
		position += velocity * delta
		position = position.clamp(Vector2.ZERO, screen_size)
	
	# Play the appropriate animation
	if velocity.x != 0:
		animated_sprite_2d.animation = "walk"
		animated_sprite_2d.flip_v = false
		animated_sprite_2d.flip_h = velocity.x < 0
		animated_sprite_2d.play()
	elif velocity.y != 0:
		animated_sprite_2d.animation = "up"
		animated_sprite_2d.flip_v = velocity.y > 0
		animated_sprite_2d.play()
	else: 
		animated_sprite_2d.stop()


func _on_body_entered(_body: Node2D) -> void:
	hide() # Player disappears after being hit
	hit.emit()
	collision_shape_2d.set_deferred("disabled", true)


func start(pos: Vector2) -> void:
	position = pos
	show()
	collision_shape_2d.set_deferred("disabled", false)
