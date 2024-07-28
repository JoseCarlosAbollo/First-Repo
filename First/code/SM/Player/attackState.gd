extends PlayerState
# Export any states that have a transition to/from the new state
@export var idle_state: PlayerState
@export var damaged_state: PlayerState

func enter():
	isAbleToAttack = false
	var animation_final_name
	if(isPointingLeft):
		animation_final_name = animation_name + "Left1"
		parent.animation_player.play(animation_final_name)
	else:
		animation_final_name = animation_name + "Right1"
		parent.animation_player.play(animation_final_name)

func process_input(event) -> PlayerState:
	if isAbleToAttack and Input.is_action_just_pressed("attackInput"):
		return self
	return null

func process_physics(delta) -> PlayerState:
	# Add the code for handling PHYSICS in the new PlayerState
	return null

func process_frame(delta) -> PlayerState:
	if isHit:
		return damaged_state
	else:
		return null

func ableToAttack():
	#print("IS ABLE")
	isAbleToAttack = true

func exit(next_state: PlayerState) -> void:
	isAbleToAttack = true

func animation_finished(anim_name: String) -> PlayerState:
	#print("finished")
	return idle_state
