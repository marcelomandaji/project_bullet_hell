extends Sprite

var velocity = .15
var g_texture_height = 0

func _ready():
	g_texture_height = texture.get_size().y * scale.y

func _process(delta):
	#position.y += velocity
	_attempt_reposition()
	
func _attempt_reposition():
	if position.y > g_texture_height:
		position.y = -g_texture_height + 2
