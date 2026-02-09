extends Area2D

@onready var main = get_node("/root/Main")
var value: int


func _ready() -> void:
    $AnimatedSprite2D.play("default")


func _on_body_entered(_body: Node2D) -> void:
    main.add_money(value)
    $DespawnTimer.stop()
    $AnimationPlayer.play("pickup")


func _on_despawn_animation_timer_timeout() -> void:
    $AnimatedSprite2D.play("despawn")


func _on_despawn_timer_timeout() -> void:
    queue_free()
