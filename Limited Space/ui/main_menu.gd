extends Control

@export var Title : Label
@export var ButtonContainer : VBoxContainer
@export var Credits : Control
@export var GameScene : PackedScene

func _ready():
	Global.CURRENT_LEVEL = 0

func _on_start_pressed():
	Global.PrepScore()
	get_tree().change_scene_to_file(GameScene.resource_path)

func _on_exit_pressed():
	get_tree().quit();

func _on_options_pressed():
	Toggle(false)

func Toggle(on : bool):
	Title.visible = on
	ButtonContainer.visible = on


func _on_credits_pressed():
	Toggle(false)
	Credits.visible = true
