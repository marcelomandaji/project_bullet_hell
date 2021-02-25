extends Node2D

var Enemy = preload("res://Enemies/Enemy.tscn")
var Boss = preload("res://Enemies/Boss.tscn")
onready var stage = $Stage
var boss = false

func _process(delta):
	
	if stage.position.y < 0:
		stage.position.y += Scroll.speed
	else:
		Scroll.scrolling = false
		
func _on_Timer_timeout():
	if Scroll.scrolling:
		set_enemy()
	else:
		if !boss:
			set_boss()
			boss = true

func set_enemy():
	var enemy = Enemy.instance()
	enemy.global_position = Vector2(rand_range(0, 480), -15)
	add_child(enemy)
	
func set_boss():
	var boss = Boss.instance()
	boss.global_position = Vector2(240, -50)
	add_child(boss)
