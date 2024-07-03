extends State
# Export any states that have a transition to/from the new state
@export var awake_state: State

var triggered = false

func enter():
	super()
	# Add the code for ENTER function in the new State

func process_input(event) -> State:
	# Add the code for handling INPUT function in the new State
	return null

func process_physics(delta) -> State:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> State:
	if triggered:
		return awake_state
	else:
		return null

func _on_spawn_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	triggered = true
