extends PlayerState
# First export any states that have a transition to/from the new state
@export var fall_state: PlayerState

var jump_speed: float = -320

func enter():
	if !isAbleToDoubleJump:
		var animation_final_name
		if(isPointingLeft):
			animation_final_name = animation_name + "Left2"
			parent.animation_player.play(animation_final_name)
		else:
			animation_final_name = animation_name + "Right2"
			parent.animation_player.play(animation_final_name)
	else:
		super()
	parent.velocity.y = jump_speed
	player_move(0)

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("jumpInput") and isAbleToDoubleJump:
		return self
	return null

func process_physics(delta) -> PlayerState:
	if Input.is_action_just_released("jumpInput"):
		return fall_state
	player_move(delta)
	if parent.velocity.y >= 0:
		return fall_state
	return null

func process_frame(delta) -> PlayerState:
	return null

func exit(next_state):
	if(next_state == fall_state):
		parent.velocity.y = 0

