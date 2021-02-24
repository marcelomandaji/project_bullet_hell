extends Node2D

var SPEED = 200
var velocity = Vector2.ZERO

func _physics_process(delta):
	position += velocity * SPEED * delta



func _on_Hitbox_area_entered(area):
	queue_free()
