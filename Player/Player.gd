extends KinematicBody2D

const ACCELERATION = 1600
const MAX_SPEED = 150
const ROLL_SPEED = 90
const FRICTION = 1600

var velocity = Vector2.ZERO
var roll_vector = Vector2.ZERO

var Arrow = preload("res://Player/Arrow.tscn")

enum {
	MOVE,
	ROLL,
	ATTACK
}

var state = MOVE

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")
#onready var swordHitbox = $PivotHitbox/SwordHitbox

var mouse_vector = Vector2.ZERO

func _ready():
	animationTree.active = true
	#swordHitbox.knockback_vector = roll_vector
	
func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		ROLL:
			roll_state(delta)
		ATTACK:
			attack_state(delta)

func move_state(delta):
	var input_vector = Vector2.ZERO
	mouse_vector = Vector2(get_viewport().get_mouse_position() - self.position).normalized()
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		#swordHitbox.knockback_vector = input_vector
		#animationTree.set("parameters/Idle/blend_position", mouse_vector)
		#animationTree.set("parameters/Walk/blend_position", mouse_vector)
		#animationTree.set("parameters/Attack/blend_position", input_vector)
		#animationTree.set("parameters/Roll/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
	animationTree.set("parameters/Idle/blend_position", mouse_vector)
	animationTree.set("parameters/Walk/blend_position", mouse_vector)
	move()
	
	#if Input.is_action_just_pressed("roll"):
		#state = ROLL
		
	if Input.is_action_just_pressed("attack"):
		state = ATTACK

func roll_state(_delta):
	velocity = roll_vector * ROLL_SPEED
	#animationState.travel("Roll")
	move()

func move():
	velocity = move_and_slide(velocity)
	
func attack_state(_delta):
	#velocity = Vector2.ZERO
	#animationState.travel("Attack")
	var arrow = Arrow.instance()
	arrow.global_position = self.global_position
	arrow.velocity = mouse_vector
	
	print()
	arrow.rotation = get_angle_to(get_global_mouse_position())
	get_parent().add_child(arrow)
	onAttackAnimationFinished()
	
func onAttackAnimationFinished():
	state = MOVE

func onRollAnimationFinished():
	velocity = velocity * 0.8
	state = MOVE
