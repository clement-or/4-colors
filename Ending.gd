extends Node2D

var current_frame = 0
onready var FRAMES = [
	$Image1,
	$Image2,
	$Image3
]

func _ready():
	$Audio/Anim.play("fade_in")
	for i in range(FRAMES.size()):
		FRAMES[i].connect("fade_in_finished", self, "next_frame")
	FRAMES[FRAMES.size()-1].connect("fade_out_finished", self, "end")
	FRAMES[current_frame].fade_in()

func next_frame():
	if current_frame<FRAMES.size()-1:
		FRAMES[current_frame].fade_out()
		current_frame += 1
		FRAMES[current_frame].fade_in()

func end():
	get_tree().change_scene("res://Game.tscn")

func _on_Yes_pressed():
	print("yes")
	FRAMES[current_frame].stop()
	FRAMES[current_frame+1].stop()
	end()
var easter = false 
func _on_EasterEggTimeout_timeout():
	if !easter:
		$Audio/Anim.play_backwards("fade_in")
		$Image3/Label2.text = "What are you waiting for ? An easter egg ?"
		easter = true
		$EasterEggTimeout.start()
	else:
		$Image3/Label2.text = "Alright then here you go"
		$Audio.stop()
		$Audio2.play()
