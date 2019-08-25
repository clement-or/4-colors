extends Node2D

const LEVELS = [
	preload("res://levels/Level0.tscn"),
	preload("res://levels/Level1.tscn"),
	preload("res://levels/Level2.tscn"),
	preload("res://levels/Level3.tscn")
]
var current_level_nb = 0
var current_level_inst

func _ready():
	load_level(0)

func _process(delta):
	pass

func load_level(nb):
	current_level_inst = LEVELS[nb].instance()
	add_child(current_level_inst)
	current_level_inst.connect("level_finished", self, "next_level")

func next_level():
	call_deferred("remove_child",current_level_inst)
	current_level_nb += 1
	call_deferred("load_level",current_level_nb)
