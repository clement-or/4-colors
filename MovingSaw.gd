extends Path2D

# Nodes
onready var c = get_node("/root/Constants")
onready var follow = $PathFollow2D
onready var color = c.COLORS[$PathFollow2D/Saw.color]

# Exports
export var speed = 100
export(bool) var is_moving = true

var is_moving_right = true

func _ready():
	set_process(true)

func _process(delta):
	if is_moving :
		follow.offset = follow.offset + speed*delta

func _draw():
	draw_polyline(curve.get_baked_points(), color, 2.0)