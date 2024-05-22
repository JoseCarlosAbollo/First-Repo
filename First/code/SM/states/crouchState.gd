extends State
# Export any states that have a transition to/from the new state
@export var crouchIdle_state: State
@export var jump_state: State
@export var run_state: State
@export var fall_state: State

@export var speed_multiplier: float = 0.5
var original_speed: float

func enter():
	super()
	original_speed = move_speed
	move_speed *= speed_multiplier

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput"):
		return run_state
	return null

func process_physics(delta) -> State:
	player_move(delta)
	if direction == 0:
		return crouchIdle_state
	if !parent.is_on_floor():
		return fall_state	
	return null

func process_frame(delta) -> State:
	# Add the code for handling FRAME UPDATES in the new State
	return null

func exit():
	move_speed = original_speed

