extends Control

var i = 0
var new_rotation = 0
var degrees = [
	0, -90, -180, -270
]
enum {RED, GREEN, BLUE, YELLOW}
var current_color = RED

func _ready():
	pass

func _process(delta):
	if int(rect_rotation)%360 != int(new_rotation)%360:
		rect_rotation = (int(rect_rotation-15))%360

func next_color():
	i = (i+1)%4
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
	
	current_color = (current_color+1)%4
