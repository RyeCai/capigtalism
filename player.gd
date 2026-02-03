extends CharacterBody2D


@export var movement_speed: float = 300.0
var character_direction: Vector2
var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	position = screen_size / 2

func _physics_process(delta: float) -> void:
	character_direction.x = Input.get_axis("move_left", "move_right")
	character_direction.y = Input.get_axis("move_up", "move_down")
	character_direction = character_direction.normalized()

	# if character_direction.x > 0: $sprite.flip_h = false
	# elif character_direction.x < 0: $sprite.flip_h = true

	if character_direction:
		velocity = character_direction * movement_speed
	else:
		velocity = velocity.move_toward(Vector2.ZERO, movement_speed)
	move_and_slide()

	position = position.clamp(Vector2.ZERO, screen_size)

	var mouse_position: Vector2 = get_local_mouse_position()
	var angle: float = snappedf(mouse_position.angle(), PI / 4) / (PI / 4)
	angle = wrapi(int(angle), 0, 8)
	$AnimatedSprite2D.animation = 'walk' + str(int(angle)) # Convert angle to string for animation name

	if velocity.length() > 0:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
