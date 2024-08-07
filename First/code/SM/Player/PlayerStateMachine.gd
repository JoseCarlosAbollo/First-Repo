extends Node

@export var starting_state: PlayerState
var current_state: PlayerState

func init(parent: CharacterBody2D) -> void:
	for child in get_children(): # If this fails, make sure no child is without implementation
		child.parent = parent
	change_state(starting_state)

func change_state(new_state: PlayerState) -> void:
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

func _on_hb_area_entered(area):
	if !current_state.isHit and area.is_in_group("killzone") :
		current_state.player_damaged(1.5, area.get_global_position())
