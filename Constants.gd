extends Node

const RED = Color(0.89412, 0.09020, 0.30980) #228, 23, 79
const GREEN = Color(0.41176, 0.87059, 0.08627)
const BLUE = Color (0.17255, 0.15686, 0.69020)
const YELLOW = Color (0.98824, 0.76863, 0.09804)
const COLORS = [RED, GREEN, BLUE, YELLOW]
var color_index = 3

onready var viewport = get_viewport()
var minimum_size = Vector2(1920, 1080)

func _ready():
	viewport.connect("size_changed", self, "window_resize")
	window_resize()

func _process(delta):
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()

func window_resize():
	var current_size = OS.get_window_size()

	var scale_factor = minimum_size.y/current_size.y
	var new_size = Vector2(current_size.x*scale_factor, minimum_size.y)

	if new_size.y < minimum_size.y:
		scale_factor = minimum_size.y/new_size.y
		new_size = Vector2(new_size.x*scale_factor, minimum_size.y)
	if new_size.x < minimum_size.x:
		scale_factor = minimum_size.x/new_size.x
		new_size = Vector2(minimum_size.x, new_size.y*scale_factor)

	viewport.set_size_override(true, new_size)
