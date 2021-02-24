extends Node2D

var Enemy = preload("res://Enemies/Enemy.tscn")


func _on_Timer_timeout():
	set_enemy()


func set_enemy():
	var enemy = Enemy.instance()
	enemy.global_position = Vector2(rand_range(0, 480), -15)
	add_child(enemy)
	
