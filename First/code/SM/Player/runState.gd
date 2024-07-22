extends PlayerState
# First export any states that have a transition to/from the new state
@export var idle_state: PlayerState
@export var jump_state: PlayerState
@export var fall_state: PlayerState
@export var crouch_state: PlayerState
@export var slide_state: PlayerState
@export var attack_state: PlayerState

func enter():
	super()
	isAbleToDoubleJump = true

func process_input(event: InputEvent) -> PlayerState:
	if Input.is_action_just_pressed("jumpInput"):
		return jump_state
	if Input.is_action_just_pressed("crouchInput"):
		if parent.velocity.x != 0:
			return slide_state
		else:
			return crouch_state
	if isAbleToAttack and Input.is_action_just_pressed("attackInput"):
		if(isPointingLeft):
			parent.animation_player.play("attackLeft1")
		else:
			parent.animation_player.play("attackRight1")
	return null

func process_physics(delta) -> PlayerState:
	player_move(delta)
	if inputSpeed == 0:
		return idle_state
	if !parent.is_on_floor():
		return fall_state
	return null

func process_frame(delta) -> PlayerState:
	# Add the code for handling FRAME UPDATES in the new PlayerState
	return null

func exit(next_state):
	if(next_state == fall_state):
		parent.coyote_timer.start()
		isInCoyoteTime = true

func animation_finished(anim_name: String) -> PlayerState:
	#print("finished")
	return self
