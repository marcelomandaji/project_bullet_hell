extends Node2D

var velocity = Vector2.ZERO

var Bullet = preload("res://Enemies/EnemyBullet.tscn")
onready var stats = $Stats
onready var player = get_parent().get_node("Player")

func _ready():
	pass

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage


func fire():
	var bullet = Bullet.instance()
	bullet.global_position = self.global_position
	bullet.velocity = Vector2(player.position - self.position).normalized()
	bullet.rotation = get_angle_to(player.position)
	get_parent().add_child(bullet)


func _physics_process(_delta):
	self.position.y += Scroll.speed * 2
	
func _on_Timer_timeout():
	
	fire()


func _on_Stats_no_health():
	queue_free()
