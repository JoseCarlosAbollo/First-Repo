extends State
#	First export any states that have a transition to/from the new state
#@export var jump_state: State
@export var run_state: State
@export var jump_state: State
@export var fall_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	if is_input_left():
		isPointingLeft = true
		return run_state
	elif is_input_right():
		isPointingLeft = false
		return run_state
	if !parent.is_on_floor():
		return fall_state
	return null

func process_frame(delta: float) -> State:
	return null

func exit() -> void:
	pass
