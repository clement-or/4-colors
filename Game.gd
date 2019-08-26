extends Node2D

var LEVELS = [
	preload("res://levels/Level0.tscn"),
	preload("res://levels/Level1.tscn"),
	preload("res://levels/Level2.tscn"),
	preload("res://levels/Level3.tscn"),
	preload("res://levels/Level4.tscn"),
	preload("res://levels/Level5.tscn"),
	preload("res://levels/Level6.tscn"),
	preload("res://levels/Level7.tscn"),
	preload("res://levels/Level8.tscn"),
	preload("res://levels/Level9.tscn"),
	preload("res://levels/Level10.tscn")
]
var current_level_nb = 0
var current_level_inst

func _ready():
	$Music/Anim.play("fade_in")
	load_level(0)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		next_level()

func load_level(nb):
	$Overlay.fade_out()
	current_level_inst = LEVELS[nb].instance()
	add_child_below_node($Music,current_level_inst)
	current_level_inst.connect("level_finished", self, "next_level")
	current_level_inst.connect("level_restarted", self, "restart_current_level")
	current_level_inst.set_level_counter(current_level_nb,LEVELS.size()-1)

func next_level():
	$Overlay.fade_in()

func next_level_finished():
	call_deferred("remove_child",current_level_inst)
	if current_level_nb < 10:
		current_level_nb += 1
		call_deferred("load_level",current_level_nb)
	else:
		get_tree().change_scene("res://Ending.tscn")

func restart_current_level():
	current_level_nb -= 1
	next_level()