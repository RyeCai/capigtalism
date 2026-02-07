extends Node2D

@export var bullet_scene: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _on_player_shoot(pos: Vector2, dir: Vector2) -> void:
    var bullet = bullet_scene.instantiate()
    add_child(bullet)
    bullet.position = pos
    bullet.direction = dir.normalized()
    bullet.add_to_group("bullets")
