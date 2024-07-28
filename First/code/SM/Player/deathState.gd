extends PlayerState
# Export any states that have a transition to/from the new state

func enter():
	Engine.time_scale = 0.3
	super()
	# Add the code for ENTER function in the new State

func process_input(event) -> PlayerState:
	# Add the code for handling INPUT function in the new State
	return null

func process_physics(delta) -> PlayerState:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> PlayerState:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit(next_state):
	pass

func animation_finished(anim) -> PlayerState:
	Engine.time_scale = 1
	get_tree().reload_current_scene();
	return null
