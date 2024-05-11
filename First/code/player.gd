extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D
const SPEED = 200.0
const JUMP_VELOCITY = -300.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 0.0
var isPointingLeft = true
var isCrouching = false
var crouchSpeed = 1.0
var currentSprite = ""

@onready var camera_2d = $Camera2D
var lookAtTimer = 0.0
var lookAtMaxTime = 0.2
var cameraMaxPan = 64
var panSpeed = 0.08
var panCameraUp = false
var panCameraDown = false

func stopCrouching():
	isCrouching = false
	crouchSpeed = 1

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		stopCrouching()
	# Handle crouch.
	#if Input.is_action_just_pressed("crouch") and is_on_floor():
		#isCrouching = true
		#crouchSpeed = 0.5
	# Handle up.
	if Input.is_action_just_pressed("wake") and isCrouching:
		stopCrouching()
	#Handle lookAt
	if Input.is_action_pressed("wake"):
		if lookAtTimer > lookAtMaxTime:
			panCameraUp = true
		else: 
			lookAtTimer += delta
	if Input.is_action_pressed("crouch"):
		if lookAtTimer > lookAtMaxTime:
			panCameraDown = true
		else: 
			lookAtTimer += delta
	if Input.is_action_just_released("wake"):
		lookAtTimer = 0
		panCameraUp = false
	if Input.is_action_just_released("crouch"):
		if lookAtTimer < 0.2 :
			isCrouching = true
			crouchSpeed = 0.5
		lookAtTimer = 0
		panCameraDown = false
	if panCameraUp :
		camera_2d.offset.y = lerp(camera_2d.offset.y, -1.0 * cameraMaxPan, panSpeed)
	elif panCameraDown :
		camera_2d.offset.y = lerp(camera_2d.offset.y, 1.0 * cameraMaxPan, panSpeed)
	else : 
		if camera_2d.offset.y >= 1 :
			camera_2d.offset.y = lerp(camera_2d.offset.y, 0.0, panSpeed * 2)
		elif camera_2d.offset.y <= -1 :
			camera_2d.offset.y = lerp(camera_2d.offset.y, 0.0, panSpeed * 2)
	# Get the input direction and handle the movement/deceleration.
	direction = Input.get_axis("left", "right")
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
	handleSprites();

func handleSprites():
	if direction < 0.0: # moves left
		if isCrouching: 
			sprite.play("idleCrouchingLeft") # TODO crouching left
		else:
			sprite.play("runLeft")
	elif direction > 0.0: # moves right
		if isCrouching: 
			sprite.play("idleCrouchingRight") # TODO crouching right
		else:
			sprite.play("runRight")
	else: # doesnt move
		if isCrouching: # idle crouch
			currentSprite = "idleCrouchingLeft" if isPointingLeft else "idleCrouchingRight"
			sprite.play(currentSprite)
		else:
			if lookAtTimer > 0.0 and Input.is_action_pressed("wake"): # look up
				sprite.play("lookUp") # TODO look up lef-right
			elif lookAtTimer > 0.2 and Input.is_action_pressed("crouch"): # look down
				sprite.play("lookDown") # TODO look down lef-right
			else: # does nothing
				currentSprite = "idleLeft" if isPointingLeft else "idleRight"
				sprite.play(currentSprite)
	# being on air is on top of all so overwrite sprite if...
	# TODO _process is not getting the actual physics values
	if velocity.y < 0.0: # is jumping or..
		currentSprite = "jumpingLeft" if isPointingLeft else "jumpingRight"
		sprite.play(currentSprite)
		log(isPointingLeft)
	elif velocity.y > 0.0: # is falling
		currentSprite = "fallingLeft" if isPointingLeft else "fallingRight"
		sprite.play(currentSprite)
		log(isPointingLeft)
