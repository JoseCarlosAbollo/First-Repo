extends State
# First export any states that have a transition to/from the new state
@export var fall_state: State

func enter():
	super() # You usually want to launch the default state ENTER function to play the correct animation
	parent.velocity.y = jump_speed
	player_move()

func process_input(event: InputEvent) -> State:
	return null

func process_physics(delta) -> State:
	parent.velocity.y += gravity * delta
	if parent.velocity.y <= 0:
		return fall_state
	player_move()
	return null

func process_frame(delta) -> State:
	return null

func exit():
	pass

