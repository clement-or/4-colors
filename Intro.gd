extends Node2D

var current_frame = 0
onready var FRAMES = [
	$Image1,
	$Image2,
	$Image3, 
	$Image4, 
	$Image5, 
	$Image6, 
	$Image7, 
	$Image8,
	$Image9
]

func _ready():
	$Audio/Anim.play("fade_in")
	for i in range(FRAMES.size()):
		FRAMES[i].connect("fade_in_finished", self, "next_frame")
	FRAMES[FRAMES.size()-1].connect("fade_out_finished", self, "end")
	FRAMES[current_frame].fade_in()

func _process(delta):
	if Input.is_action_pressed("ui_select"):
		$Camera2D/Popup.popup()
	
func next_frame():
	if current_frame<FRAMES.size()-1:
		FRAMES[current_frame].fade_out()
		current_frame += 1
		FRAMES[current_frame].fade_in()
	else: 
		FRAMES[current_frame].fade_out()
		$Audio/Anim.play_backwards("fade_out")

func end():
	get_tree().change_scene("res://Game.tscn")
	
func _on_No_pressed():
	$Camera2D/Popup.hide()

func _on_Yes_pressed():
	end()
	
