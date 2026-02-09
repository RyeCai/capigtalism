extends Node

const STARTING_MONEY: int = 60
const HIT_COST: int = -4
const SHOOTING_COST: int = -1
const TIME_COST: int = -1
var money: int
var max_money: int
var game_started: bool


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    reset()
    $GameOver/Button.pressed.connect(reset)


func start_game() -> void:
    $World/MoneyTimer.start()
    $World/EnemySpawner/EnemyTimer.start()


func reset() -> void:
    game_started = false
    money = STARTING_MONEY
    max_money = STARTING_MONEY
    $Hud/MoneyAmount.text = str(money)
    $World/MoneyTimer.stop()
    $World/EnemySpawner/EnemyTimer.stop()
    get_tree().call_group("enemies", "queue_free")
    get_tree().call_group("bullets", "queue_free")
    get_tree().call_group("items", "queue_free")
    get_tree().paused = false
    $GameOver.hide()
    $World/TutorialLabel.show()
    $World/Player.reset()


func add_money(value: int):
    money += value
    $Hud/MoneyAmount.text = str(money)
    max_money = max(max_money, money)
    if money <= 0:
        get_tree().paused = true
        $GameOver/MaxMoneyAmount.text = str(max_money)
        $GameOver.show()


func _on_enemy_spawner_hit_p() -> void:
    add_money(HIT_COST)


func _on_player_shoot(_pos: Vector2, _dir: Vector2) -> void:
    if !game_started and !get_tree().paused:
        start_game()
        $World/TutorialLabel.hide()
        game_started = true
    add_money(SHOOTING_COST)


func _on_money_timer_timeout() -> void:
    add_money(TIME_COST)
