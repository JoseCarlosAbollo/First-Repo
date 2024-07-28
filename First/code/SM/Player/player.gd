extends CharacterBody2D

@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var camera_2d = $Camera2D
@onready var collision_capsule_standing = $CollisionShapeStanding
@onready var collision_capsule_crouching = $CollisionShapeCrouching
@onready var collision_shape_standing = $HB/HitBoxStanding
@onready var collision_shape_crouching = $HB/HitBoxCrouching
@onready var area_to_stand = $AreaToStand
@onready var coyote_timer = $CoyoteTimer
@onready var orientation_node = $OrientateNode
@onready var floorNormalRC = $RCfloor

var health: int = 3

#------------------------------------------------------
# GIZMOS
#------------------------------------------------------
var moveDirectionGizmo : Vector2 = Vector2.RIGHT
var floorNormalGizmo : Vector2 = Vector2.UP

func _ready():
	state_machine.init(self)

func _unhandled_input(event):
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _on_animation_player_animation_finished(anim_name):
	state_machine.animation_finished(anim_name)
