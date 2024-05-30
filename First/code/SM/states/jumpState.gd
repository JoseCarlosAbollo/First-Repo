extends State
# First export any states that have a transition to/from the new state
@export var fall_state: State

var jump_speed: float = -300
var hold_timer : float = 0
var max_holding_time : float = 0.5

func enter():
	super()
	parent.velocity.y = jump_speed
	player_move(0)

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("jumpInput") and isAbleToDoubleJump:
		return self
	return null

func process_physics(delta) -> State:
	if hold_timer < max_holding_time:
		if Input.is_action_just_released("jumpInput"):
			parent.velocity.y *= 0.1
		else:
			parent.velocity.y += -1
	player_move(delta)
	if parent.velocity.y >= 0:
		return fall_state
	return null

func process_frame(delta) -> State:
	hold_timer += delta
	return null

func exit(next_state):
	hold_timer = 0

