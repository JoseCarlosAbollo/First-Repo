extends PlayerState
# Export any states that have a transition to/from the new state
@export var idle_state: PlayerState
@export var fall_state: PlayerState
@export var death_state: PlayerState

func enter():
	super()
	isAbleToMove = false
	parent.health -= 1
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
	isAbleToMove = true
	isHit = false
	pass

func animation_finished(anim) -> PlayerState:
	if parent.health > 0:
		if parent.is_on_floor():
			return idle_state
		else:
			return fall_state
	else:
		return death_state
