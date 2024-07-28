extends CharacterBody2D

@onready var RCright = $RCright
@onready var RCleft = $RCleft
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite2D
@onready var state_machine = $SM

const speed = 50
var direction = 1
var hit = false
var health = 3

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

func _on_spawn_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("Player"):
		state_machine.player_entered_dormant_area()

func frameFreeze(newTimeScale:float, freezeDuration:float) -> void:
	Engine.time_scale = newTimeScale;
	await(get_tree().create_timer(freezeDuration * newTimeScale).timeout)
	Engine.time_scale = 1.0
