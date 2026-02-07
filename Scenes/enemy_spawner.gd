extends Node2D

@export var enemy_scene: PackedScene
signal hit_p


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_enemy_timer_timeout() -> void:
    # Create a new instance of the Mob scene.
    var enemy = enemy_scene.instantiate()

    # Choose a random location on Path2D.
    var enemy_spawn_location = $EnemyPath/EnemySpawnLocation
    enemy_spawn_location.progress_ratio = randf()

    # Set the mob's position to the random location.
    enemy.position = enemy_spawn_location.position
    enemy.hit_player.connect(hit)
    enemy.add_to_group("enemies")

    # Spawn the mob by adding it to the Main scene.
    add_child(enemy)


func hit() -> void:
    hit_p.emit()
