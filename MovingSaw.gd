extends Path2D

# Nodes
onready var c = get_node("/root/Constants")
onready var follow = $PathFollow2D

# Exports
export var speed = 0.5 #between 0 and 1
export(int, "RED", "GREEN", "BLUE", "YELLOW", "WHITE") var color
enum {RED,GREEN,BLUE,YELLOW,WHITE}

var is_moving_right = true

func _ready():
	if !color: color = RED
	$PathFollow2D/Saw.set_color(color)
	set_process(true)

func _process(delta):
	if is_moving_right:
		follow.unit_offset = follow.unit_offset-speed*delta
	else:
		follow.unit_offset = follow.unit_offset+speed*delta
		
	if follow.unit_offset >= 1:
		follow.unit_offset = 1
		is_moving_right = !is_moving_right
	elif follow.unit_offset <= 0:
		follow.unit_offset = 0
		is_moving_right = !is_moving_right

func _draw():
	var line_color
	if color != WHITE:
		line_color = c.COLORS[color]
	else:
		line_color = Color(1,1,1)
	
	var points = curve.get_baked_points()
	var nb_points = curve.get_point_count()
	
	for index_point in range(nb_points):
		draw_line(points[index_point-1], points[index_point], line_color, 15)
		print (line_color)