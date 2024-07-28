extends EnemyState
# Export any states that have a transition to/from the new state

func enter():
	print("death state enter")
	super()
	# Add the code for ENTER function in the new State

func process_input(event) -> EnemyState:
	# Add the code for handling INPUT function in the new State
	return null

func process_physics(delta) -> EnemyState:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> EnemyState:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit(next_state):
	pass

func animation_finished(anim_name) -> EnemyState:
	parent.queue_free()
	return null
