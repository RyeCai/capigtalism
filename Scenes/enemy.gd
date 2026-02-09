extends CharacterBody2D

# TODO: Remove hardcoded path to player
@onready var main: Node = get_node("/root/Main/World")
@onready var player: CharacterBody2D = get_node("/root/Main/World/Player")

var coin_scene: PackedScene = preload("res://Scenes/coin.tscn")

signal hit_player

var speed: int = 100
var direction: Vector2
var alive: bool = true


func _ready() -> void:
    $AnimatedSprite2D.animation = "walk"
    $AnimatedSprite2D.play()


func _physics_process(_delta: float) -> void:
    if alive:
        direction = player.position - position
        velocity = direction.normalized() * speed

        if velocity.x != 0:
            $AnimatedSprite2D.flip_h = velocity.x < 0

        move_and_slide()


func die() -> void:
    alive = false
    $AnimatedSprite2D.play("death")
    $Area2D/CollisionShape2D.set_deferred("disabled", true)
    drop_item()
    $DespawnTimer.start()
    $DeathSound.play()


func drop_item() -> void:
    var coin = coin_scene.instantiate()
    coin.value = 5
    coin.position = position
    main.call_deferred("add_child", coin)
    coin.add_to_group("items")


func _on_area_2d_body_entered(_body: Node2D) -> void:
    $HitSound.play()
    hit_player.emit()


func _on_despawn_timer_timeout() -> void:
    queue_free()


func _on_animated_sprite_2d_animation_finished() -> void:
    $AnimatedSprite2D.play("despawn")
