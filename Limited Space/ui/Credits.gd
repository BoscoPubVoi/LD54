extends ColorRect

@export var MainMenu : Node


func _on_back_pressed():
	self.visible = false
	MainMenu.Toggle(true)
