extends State
# First export any states that have a transition to/from the new state
@export var land_state: State
@export var run_state: State

func enter():
	super()
	# Add the code for ENTER function in the new State

func process_input(event: InputEvent) -> State:
	#if is_input_left():
		#isPointingLeft = true
		#return self
	#elif is_input_right():
		#isPointingLeft = false
		#return self
	return null

func process_physics(delta) -> State:
	player_move(delta)
	if parent.is_on_floor():
		if direction:
			return run_state
		else:
			return land_state
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit():
	pass

