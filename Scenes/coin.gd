extends Area2D

@onready var main = get_node("/root/Main")
var value: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    pass # Replace with function body.


func _on_body_entered(_body: Node2D) -> void:
    main.add_money(value)
    $AnimationPlayer.play("pickup")
