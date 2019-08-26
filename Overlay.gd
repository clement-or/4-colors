extends ColorRect

signal fade_in_finished
signal fade_out_finished
export var is_visible = true

func _ready():
	visible = is_visible
	color = Color(0,0,0,int(is_visible))

func fade_in():
	visible = true
	$Anim.play("fade_in")

func fade_out():
	$Anim.play("fade_out")

func anim_finished(anim):
	if anim == "fade_in":
		emit_signal("fade_in_finished")
	elif anim == "fade_out":
		visible  = false
		emit_signal("fade_out_finished")