extends PlayerState
# Export any states that have a transition to/from the new state
@export var idle_state: PlayerState

func enter():
	isAbleToAttack = false
	var animation_name
	if(isPointingLeft):
		animation_name = animation_name_left + '1'
		#animation_name = animation_name_left + str(attackComboNumber)
		parent.animation_player.play(animation_name)
	else:
		animation_name = animation_name_right + '1'
		#animation_name = animation_name_right + str(attackComboNumber)
		parent.animation_player.play(animation_name)

func process_input(event) -> PlayerState:
	if isAbleToAttack and Input.is_action_just_pressed("attackInput"):
		return self
	return null

func process_physics(delta) -> PlayerState:
	# Add the code for handling PHYSICS in the new PlayerState
	return null

func process_frame(delta) -> PlayerState:
	# Add the code for handling FRAME UPDATES in the new PlayerState
	return null

func ableToAttack():
	#print("IS ABLE")
	isAbleToAttack = true

func exit(next_state: PlayerState) -> void:
	isAbleToAttack = true

func animation_finished(anim_name: String) -> PlayerState:
	#print("finished")
	return idle_state
