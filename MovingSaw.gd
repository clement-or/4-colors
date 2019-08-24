extends Path2D

# Nodes
onready var c = get_node("/root/Constants")
onready var follow = $PathFollow2D
onready var color = Color(1,0,0)

# Exports
export var speed = 0.5 #between 0 and 1

var is_moving_right = false

func _ready():
	set_process(true)

func _process(delta):
	if is_moving_right:
		follow.unit_offset = follow.unit_offset-speed*delta
	else:
		follow.unit_offset = follow.unit_offset+speed*delta
	if follow.unit_offset >= 1 || follow.unit_offset <= 0:
		is_moving_right = !is_moving_right
		follow.unit_offset = clamp(follow.unit_offset, 0, 1)

func _draw():
	draw_polyline(curve.get_baked_points(), color, 2.0)