class_name State
extends Node

var parent: CharacterBody2D
var animation_name_left: String
var animation_name_right: String
static var move_speed: float = 200
static var isPointingLeft = false
static var isAbleToAttack = true
static var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter() -> void:
	if isPointingLeft:
		parent.animation_player.play(animation_name_left)
	else:
		parent.animation_player.play(animation_name_right)

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta: float) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func exit(next_state: State) -> void:
	pass

func animation_finished(anim_name: String) -> State:
	return null
