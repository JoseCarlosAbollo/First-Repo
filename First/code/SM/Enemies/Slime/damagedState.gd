extends State
# Export any states that have a transition to/from the new state
@export var aggro_state: State

func enter():
	super()
	parent.health -= 1

func process_input(event) -> State:
	# Add the code for handling INPUT function in the new State
	return null

func process_physics(delta) -> State:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit(next_state):
	pass

func animation_finished(anim_name) -> State:
	parent.hit = false
	if parent.health == 0:
		parent.queue_free()
		return null
	else:
		return aggro_state
