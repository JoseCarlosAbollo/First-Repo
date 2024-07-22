class_name PlayerState
extends Node

var parent: CharacterBody2D
@export var animation_name_left: String
@export var animation_name_right: String
static var baseSpeed: float = 200
static var inputSpeed: float = 0
static var direction: float = 0.0
static var isPointingLeft: bool = false
static var isCrouching: bool = false
static var isAbleToMove: bool = true
static var isAbleToStand: bool = true
static var isInCoyoteTime: bool = false
static var isAbleToDoubleJump: bool = true
static var isAbleToAttack: bool = true
static var attackComboNumber: int = 1
static var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func enter() -> void:
	if isPointingLeft:
		parent.animation_player.play(animation_name_left)
		parent.orientation_left.scale.x = 1
	else:
		parent.animation_player.play(animation_name_right)
		parent.orientation_left.scale.x = -1

func process_input(event: InputEvent) -> PlayerState:
	return null

func process_physics(delta: float) -> PlayerState:
	return null

func process_frame(delta: float) -> PlayerState:
	return null

func exit(next_state: PlayerState) -> void:
	pass

func animation_finished(anim_name: String) -> PlayerState:
	return null

func player_move(delta: float) -> void:
	if isAbleToMove:
		inputSpeed = Input.get_axis("leftInput","rightInput") * baseSpeed
	
	if inputSpeed > 0:
		isPointingLeft = false
	elif inputSpeed < 0:
		isPointingLeft = true
	
	var normal:Vector2 = parent.get_floor_normal()
	var isClimbingARamp: bool = false
	if normal.y != -1: # is on a ramp
		if normal.x < 0 : # ramp up
			if normal.x > -0.5 and normal.x < -0.4 : # hard ramp up
				parent.floorNormalGizmo = Vector2(cos(PI + 1.107),sin(PI + 1.107))
			if normal.x > -0.4 and normal.x < -0.3 : # soft ramp up
				parent.floorNormalGizmo = Vector2(cos(PI + 1.249),sin(PI + 1.249))
			if !isPointingLeft: 
				isClimbingARamp = true
		elif normal.x > 0 : # ramp down
			if normal.x > 0.4 and normal.x < 0.5 : # hard ramp down
				parent.floorNormalGizmo = Vector2(cos(0.46365 -PI/2),sin(0.46365 -PI/2))
			if normal.x > 0.3 and normal.x < 0.4 : # soft ramp down
				parent.floorNormalGizmo = Vector2(cos(0.321 -PI/2),sin(0.321 -PI/2))
			if isPointingLeft: 
				isClimbingARamp = true
	else: # is on a plane
		parent.floorNormalGizmo = Vector2(cos(3*PI/2),sin(3*PI/2))
	
	if isPointingLeft:
		parent.moveDirectionGizmo = parent.floorNormalGizmo.orthogonal()
	else:
		parent.moveDirectionGizmo.y = parent.floorNormalGizmo.x
		parent.moveDirectionGizmo.x = -parent.floorNormalGizmo.y
	
	if self.to_string().contains("Run") and !isClimbingARamp:
		parent.velocity = parent.moveDirectionGizmo * baseSpeed
	else :
		parent.velocity.x = inputSpeed
		parent.velocity.y += gravity * delta
	
	parent.move_and_slide()

func set_low_profile() -> void:
	if !isCrouching:
		parent.collision_capsule_standing.disabled = true
		parent.collision_capsule_crouching.disabled = false
		parent.area_to_stand.get_child(0).disabled = false
		isCrouching = true

func set_high_profile() -> void:
	if isCrouching:
		parent.collision_capsule_standing.disabled = false
		parent.collision_capsule_crouching.disabled = true
		parent.area_to_stand.get_child(0).disabled = true
		isCrouching = false

func is_input_left() -> bool:
	return Input.is_action_just_pressed("leftInput") or (Input.is_action_pressed("leftInput") and !Input.is_action_pressed("rightInput"))
func is_input_right() -> bool:
	return Input.is_action_just_pressed("rightInput") or (Input.is_action_pressed("rightInput") and !Input.is_action_pressed("leftInput"))

