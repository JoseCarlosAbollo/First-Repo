extends EnemyState
# Export any states that have a transition to/from the new state
@export var idle_state: EnemyState
@export var death_state: EnemyState

func enter():
	super()
	parent.frameFreeze(0.2, 0.3)
	parent.health -= 1

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
	parent.hit = false
	if parent.health == 0:
		return death_state
	else:
		return idle_state
