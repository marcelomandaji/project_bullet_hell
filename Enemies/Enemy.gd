extends Node2D

var velocity = Vector2.ZERO

var Bullet = preload("res://Enemies/EnemyBullet.tscn")

func _ready():
	pass

func _on_Hurtbox_area_entered(_area):
	queue_free()


func fire():
	var bullet = Bullet.instance()
	bullet.global_position = self.global_position
	bullet.velocity = Vector2(get_parent().get_node("Player").position - self.position).normalized()
	bullet.rotation = get_angle_to(get_parent().get_node("Player").position)
	get_parent().add_child(bullet)


func _on_Timer_timeout():
	
	fire()
