extends CharacterBody2D

@onready var sprite = $AnimatedSprite2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var isCrouching = false
var crouchSpeed = 1

@onready var camera_2d = $Camera2D
var lookAtTimer = 0
var lookAtMaxTime = 0.2
var cameraMaxPan = 64
var panSpeed = 0.08
var panCameraUp = false
var panCameraDown = false

func stopCrouching():
	isCrouching = false
	crouchSpeed = 1

#func panCameraUp(): 
	#if camera_2d.offset.y > (cameraMaxPan * -1):
		#camera_2d.offset.y -= 1
#
#func panCameraDown(): 
	#if camera_2d.offset.y > (cameraMaxPan * -1):
		#camera_2d.offset.y += 1
#
#func resetCameraPan():
	#if camera_2d.offset.y > 0 :
		#camera_2d.offset.y = lerp()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

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
	var direction = Input.get_axis("left", "right")
	
	# Handle animations
	if direction < 0:
		if !isCrouching: 
			sprite.play("runLeft")
	elif direction > 0:
		if !isCrouching: 
			sprite.play("runRight")
	elif isCrouching:
		sprite.play("crouching")
	else:
		sprite.play("idle")
	if lookAtTimer > 0 and Input.is_action_pressed("wake"):
		sprite.play("lookUp")
	if lookAtTimer > 0.2 and Input.is_action_pressed("crouch"):
		sprite.play("lookDown")
	if velocity.y < 0:
		sprite.play("jumping")
	elif velocity.y > 0:
		sprite.play("falling")
	
	if direction:
		velocity.x = direction * SPEED * crouchSpeed
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * crouchSpeed)

	move_and_slide()
