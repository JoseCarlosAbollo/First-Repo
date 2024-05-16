extends State
#	First export any states that have a transition to/from the new state
#@export var jump_state: State
@export var run_state: State
@export var jump_state: State

func enter() -> void:
	super()
	move_speed = 0

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	if is_input_left(event):
		isPointingLeft = true
		return run_state
	elif is_input_right(event):
		isPointingLeft = false
		return run_state
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	return null

func process_frame(delta: float) -> State:
	return null

func exit() -> void:
	pass
