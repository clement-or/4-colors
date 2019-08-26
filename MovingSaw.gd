extends Path2D

# Nodes
onready var c = get_node("/root/Constants")
onready var follow = $PathFollow2D

# Exports
export var speed_multiplier = 1 #pixels/s
export(int, "RED", "GREEN", "BLUE", "YELLOW", "WHITE") var color
enum {RED,GREEN,BLUE,YELLOW,WHITE}

var is_moving_right = true
var length
var t = 0

func _ready():
	if !color: color = RED
	$PathFollow2D/Saw.set_color(color)
	set_process(true)
	length = curve.get_baked_length()
	
var off
func _process(delta):
	t += delta*500
	off = (length/2)*cos((((PI/2))*(speed_multiplier/length)*t)+PI)+(length/2)
	if off < 1:
		off = 1
	follow.offset = off
		
func _draw():
	var line_color
	if color != WHITE:
		line_color = c.COLORS[color]
		line_color = c.COLORS[color]
	else:
		line_color = Color(1,1,1)
	
	var points = curve.get_baked_points()
	var nb_points = curve.get_point_count()
	draw_polyline(points,line_color,5.0)