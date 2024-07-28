extends Node

@export var starting_state: EnemyState
var current_state: EnemyState

func init(parent: CharacterBody2D) -> void:
	for child in get_children(): # If this fails, make sure no child is without implementation
		child.parent = parent
	change_state(starting_state)

func change_state(new_state: EnemyState) -> void:
	if current_state:
		current_state.exit(new_state)
	current_state = new_state
	current_state.enter()

func process_input(event: InputEvent):
	var new_state = current_state.process_input(event)
	if new_state:
		change_state(new_state)

func process_physics(delta: float):
	var new_state = current_state.process_physics(delta)
	if new_state:
		change_state(new_state)

func process_frame(delta: float):
	var new_state = current_state.process_frame(delta)
	if new_state:
		change_state(new_state)

func animation_finished(anim_name: String):
	var new_state = current_state.animation_finished(anim_name)
	if new_state:
		change_state(new_state)

func player_entered_dormant_area():
	if current_state.name == "Dormant":
		current_state.player_entered_area()
