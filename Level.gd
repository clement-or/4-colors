extends Node

# Nodes
onready var bg = $Background
onready var c = get_node("/root/Constants")

func _ready():
	c.color_index=3
	change_bg_color()

# Connected to color_changed signal
func change_bg_color():
	# Color change
	c.color_index = (c.color_index+1)%4
	bg.color = c.COLORS[c.color_index]