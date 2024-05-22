extends State
# Export any states that have a transition to/from the new state
@export var idle_state: State
@export var jump_state: State
@export var crouch_state: State
@export var fall_state: State

func enter():
	super()
	# Add the code for ENTER function in the new State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput"):
		return idle_state
	return null

func process_physics(delta) -> State:
	if parent.is_on_floor():
		if is_input_left():
			isPointingLeft = true
			return crouch_state
		elif is_input_right():
			isPointingLeft = false
			return crouch_state
	else:
		return fall_state
	player_move(delta)
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit():
	pass

