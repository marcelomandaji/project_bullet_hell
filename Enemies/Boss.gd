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
	
	var bullet2 = Bullet.instance()
	bullet2.global_position = self.global_position
	bullet2.position.x -= 100
	bullet2.velocity = Vector2(player.position - self.position).normalized()
	bullet2.rotation = get_angle_to(player.position)
	get_parent().add_child(bullet2)
	
	var bullet3 = Bullet.instance()
	bullet3.global_position = self.global_position
	bullet3.position.x += 100
	bullet3.velocity = Vector2(player.position - self.position).normalized()
	bullet3.rotation = get_angle_to(player.position)
	get_parent().add_child(bullet3)


func _physics_process(_delta):
	if self.position.y < 150:
		self.position.y += Scroll.speed * 2
	
func _on_Timer_timeout():
	fire()


func _on_Stats_no_health():
	queue_free()
