extends Node2D

@export var bullet_scene: PackedScene


func _on_player_shoot(pos: Vector2, dir: Vector2) -> void:
    var bullet = bullet_scene.instantiate()
    add_child(bullet)
    bullet.position = pos
    bullet.direction = dir.normalized()
    bullet.add_to_group("bullets")
