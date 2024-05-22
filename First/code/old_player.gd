extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
# consts for animated sprite's animations
const IDLE_RIGHT = "idleRight"
const IDLE_LEFT = "idleLeft"
const LOOK_DOWN_RIGHT = "lookDownRight"
const LOOK_DOWN_LEFT = "lookDownLeft"
const LOOK_UP_RIGHT = "lookUpRight"
const LOOK_UP_LEFT = "lookUpLeft"
const IDLE_CROUCHING_RIGHT = "idleCrouchingRight"
const IDLE_CROUCHING_LEFT = "idleCrouchingLeft"
const RUN_RIGHT = "runRight"
const RUN_LEFT = "runLeft"
const CROUCHING_RIGHT = "crouchingRight"
const CROUCHING_LEFT = "crouchingLeft"
const JUMPING_RIGHT = "jumpRight"
const JUMPING_LEFT = "jumLeft"
const FALLING_RIGHT = "fallRight"
const FALLING_LEFT = "fallLeft"

# Get the gravity from the project settings to be synced with RigidBody nodes.
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 0.0
var isPointingLeft = false
var isCrouching = false
var crouchSpeed = 1.0
var currentSprite = ""

@onready var camera_2d = $Camera2D
var lookAtTimer = 0.0
var lookAtMaxTime = 0.2
var cameraMaxPan = 64
var panSpeed = 0.08
var isLookingUp = false
var isLookingDown = false

func stopCrouching():
	isCrouching = false
	crouchSpeed = 1

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("jumpInput") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		stopCrouching()
	# Handle crouch.
	#if Input.is_action_just_pressed("crouchInput") and is_on_floor():
		#isCrouching = true
		#crouchSpeed = 0.5
	# Handle up.
	if Input.is_action_just_pressed("upInput") and isCrouching:
		stopCrouching()
	#Handle lookAt
	if Input.is_action_pressed("upInput"):
		
		if lookAtTimer > lookAtMaxTime:
			isLookingUp = true
		else: 
			lookAtTimer += delta
	if Input.is_action_pressed("crouchInput"):
		if lookAtTimer > lookAtMaxTime:
			isLookingDown = true
		else: 
			lookAtTimer += delta
	if Input.is_action_just_released("upInput"):
		lookAtTimer = 0
		isLookingUp = false
	if Input.is_action_just_released("crouchInput"):
		if lookAtTimer < 0.2 :
			isCrouching = true
			crouchSpeed = 0.5
		lookAtTimer = 0
		isLookingDown = false
	if isLookingUp :
		camera_2d.offset.y = lerp(camera_2d.offset.y, -1.0 * cameraMaxPan, panSpeed)
	elif isLookingDown :
		camera_2d.offset.y = lerp(camera_2d.offset.y, 1.0 * cameraMaxPan, panSpeed)
	else : 
		if camera_2d.offset.y >= 1 :
			camera_2d.offset.y = lerp(camera_2d.offset.y, 0.0, panSpeed * 2)
		elif camera_2d.offset.y <= -1 :
			camera_2d.offset.y = lerp(camera_2d.offset.y, 0.0, panSpeed * 2)
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("leftInput", "rightInput")
	if direction < 0.0: # moves left
		isPointingLeft = true
	elif direction > 0.0: # moves right
		isPointingLeft = false
	
	if direction:
		velocity.x = direction * SPEED * crouchSpeed
		
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED * crouchSpeed)

	move_and_slide()

func _process(delta):
	handleSprites()

func handleSprites():
	if direction < 0.0: # moves left
		if isCrouching: 
			animated_sprite.play(CROUCHING_LEFT)
		else:
			animated_sprite.play(RUN_LEFT)
	elif direction > 0.0: # moves right
		if isCrouching: 
			animated_sprite.play(CROUCHING_RIGHT)
		else:
			animated_sprite.play(RUN_RIGHT)
	else: # doesnt move
		if isCrouching: # idle crouch
			currentSprite = IDLE_CROUCHING_LEFT if isPointingLeft else IDLE_CROUCHING_RIGHT
			animated_sprite.play(currentSprite)
		else:
			if isLookingUp: # look up
				if animated_sprite.get_animation() != LOOK_DOWN_RIGHT and animated_sprite.get_animation() != LOOK_DOWN_LEFT:
					currentSprite = LOOK_UP_LEFT if isPointingLeft else LOOK_UP_RIGHT
					animated_sprite.play(currentSprite)
			elif isLookingDown: # look down
				if animated_sprite.get_animation() != LOOK_DOWN_RIGHT and animated_sprite.get_animation() != LOOK_DOWN_LEFT:
					currentSprite = LOOK_DOWN_LEFT if isPointingLeft else LOOK_DOWN_RIGHT
					animated_sprite.play(currentSprite)
			else: # does nothing
				currentSprite = IDLE_LEFT if isPointingLeft else IDLE_RIGHT
				animated_sprite.play(currentSprite)
	# being on air is on top of all so overwrite sprite if...
	if velocity.y < 0.0: # is jumping or..
		currentSprite = JUMPING_LEFT if isPointingLeft else JUMPING_RIGHT
		animated_sprite.play(currentSprite)
	elif velocity.y > 0.0: # is falling
		currentSprite = FALLING_LEFT if isPointingLeft else FALLING_RIGHT
		animated_sprite.play(currentSprite)
