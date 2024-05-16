extends State
# First export any states that have a transition to/from the new state
@export var fall_state: State

var jump_speed: float = -400
var hold_timer : float = 0
var max_holding_time : float = 0.5

func enter():
	super()
	parent.velocity.y = jump_speed
	player_move()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta) -> State:
	if hold_timer < max_holding_time:
		if Input.is_action_just_released("jump"):
			parent.velocity.y *= 0.1
		else:
			parent.velocity.y += -1
	parent.velocity.y += gravity * delta
	if parent.velocity.y >= 0:
		return fall_state
	player_move()
	return null

func process_frame(delta) -> State:
	hold_timer += delta
	print(hold_timer)
	return null

func exit():
	hold_timer = 0

