class_name EnemyState
extends Node

var parent: CharacterBody2D
@export var animation_name: String
static var move_speed: float = 200
static var isPointingLeft = false
static var isAbleToAttack = true
static var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter() -> void:
	#print(self.name)
	parent.animation_player.play(animation_name)

func process_input(event: InputEvent) -> EnemyState:
	return null

func process_physics(delta: float) -> EnemyState:
	return null

func process_frame(delta: float) -> EnemyState:
	return null

func exit(next_state: EnemyState) -> void:
	pass

func animation_finished(anim_name: String) -> EnemyState:
	return null
