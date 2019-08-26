extends Control

func _ready():
	$Audio/Music.play()

func _on_Play_pressed():
	$Buttons/Play/ColorRect/Anim.play("click")
	button_accept()
	$Audio/Music/Anim.play("fade_out")
	$Overlay.fade_in()

func _on_Credits_pressed():
	$Buttons/Credits/ColorRect/Anim.play("click")
	$CreditsPopup.popup()
	button_accept()

func _on_Popup_Close_pressed():
	$CreditsPopup.hide()
	button_cancel()
	
func button_accept():
	$Audio/Accept.play()

func button_cancel():
	$Audio/Cancel.play()

func button_hover():
	$Audio/Hover.play()

func _on_Overlay_fade_in_finished():
	get_tree().change_scene("res://Game.tscn")
