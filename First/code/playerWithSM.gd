class_name PlayerClass
extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var state_machine = $StateMachine
@onready var camera_2d = $Camera2D
@onready var collision_capsule_standing = $CollisionShapeStanding
@onready var collision_capsule_crouching = $CollisionShapeCrouching
@onready var area_to_stand = $AreaToStand
@onready var attack_hit_area = $AttackHitArea
@onready var coyote_timer = $CoyoteTimer

func _ready():
	state_machine.init(self)

func _unhandled_input(event):
	state_machine.process_input(event)

func _physics_process(delta):
	state_machine.process_physics(delta)

func _process(delta):
	state_machine.process_frame(delta)

func _on_animated_sprite_2d_animation_finished():
	state_machine.animated_sprite_finished()

func _on_animation_player_animation_finished(anim_name):
	state_machine.animation_finished(anim_name)
