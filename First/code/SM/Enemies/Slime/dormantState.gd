extends EnemyState
# Export any states that have a transition to/from the new state
@export var awake_state: EnemyState


var triggered:bool = false

func enter():
	super()
	# Add the code for ENTER function in the new State

func process_input(event) -> EnemyState:
	# Add the code for handling INPUT function in the new State
	return null

func process_physics(delta) -> EnemyState:
	# Add the code for handling PHYSICS in the new State
	return null

func process_frame(delta) -> EnemyState:
	if triggered:
		return awake_state
	else:
		return null

func player_entered_area():
	triggered = true
