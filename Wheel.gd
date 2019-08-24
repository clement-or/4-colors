extends Control

var i = 0
var new_rotation = 0
var degrees = [
	0, -90, -180, -270, -360
]
enum {RED, GREEN, BLUE, YELLOW}
var current_color = RED

func _ready():
	pass

func _process(delta):
	if (Input.is_action_just_pressed("ui_select")):
		next_color()
	if rect_rotation >= new_rotation:
		rect_rotation = rect_rotation - 1
		if rect_rotation <= -360: 
			rect_rotation = 0
			new_rotation = 0
			i = 0

func next_color():
	i = (i+1)%5
	new_rotation = degrees[i]
	if current_color == RED:
		$Red/Anim.play("scale_down")
		$Green/Anim.play("scale_up")
	elif current_color == GREEN:
		$Green/Anim.play("scale_down")
		$Blue/Anim.play("scale_up")
	elif current_color == BLUE:
		$Blue/Anim.play("scale_down")
		$Yellow/Anim.play("scale_up")
	elif current_color == YELLOW:
		$Yellow/Anim.play("scale_down")
		$Red/Anim.play("scale_up")
	current_color = (current_color + 1)%4
