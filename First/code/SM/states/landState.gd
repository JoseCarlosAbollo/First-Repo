extends State
# Export any states that have a transition to/from the new state
@export var idle_state: State
@export var run_state: State
@export var jump_state: State
@export var crouchIdle_state: State

func enter():
	super()
	# Add the code for ENTER function in the new State

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput"):
		return crouchIdle_state
	return null

func process_physics(delta) -> State:
	if is_input_left():
		isPointingLeft = true
		return run_state
	elif is_input_right():
		isPointingLeft = false
		return run_state
	player_move(delta)
	return null

func process_frame(delta) -> State:
	return null

func exit(next_state):
	pass

func finish_animation_signal() -> State:
	return idle_state