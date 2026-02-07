extends Node

const STARTING_MONEY: int = 500
var money: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    money = STARTING_MONEY
    $Hud/MoneyAmount.text = str(money)


func add_money(value: int):
    money += value
    $Hud/MoneyAmount.text = str(money)


func _on_enemy_spawner_hit_p() -> void:
    add_money(-5)
