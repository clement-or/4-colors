extends Path2D

# Nodes
onready var c = get_node("/root/Constants")
onready var follow = $PathFollow2D

# Exports
export var speed = 200
export(int, "RED", "GREEN", "BLUE", "YELLOW", "WHITE") var color
enum {RED,GREEN,BLUE,YELLOW,WHITE}

var is_moving_right = false
var length

func _ready():
	if !color: color = RED
	$PathFollow2D/Saw.set_color(color)
	set_process(true)
	length = curve.get_baked_length()
	
var off = 1
func _process(delta):
	if !is_moving_right:
		off += delta*speed
	else: 
		off -= delta*speed
	
	if off >= length-1:
		off = length-1
		is_moving_right = true
	elif off < 1:
		off = 1
		is_moving_right = false
	follow.offset = off