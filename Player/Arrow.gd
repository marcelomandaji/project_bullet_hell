extends Node2D

var SPEED = 200
var velocity = Vector2.ZERO

func _physics_process(delta):
	position += velocity * SPEED * delta



func _on_Hitbox_area_entered(_area):
	queue_free()


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
