extends Node2D

@onready var RCright = $RCright
@onready var RCleft = $RCleft
@onready var sprite = $AnimatedSprite2D
@onready var spawnArea = $spawnArea

const speed = 50
var dormant = true
var aggro = false
var direction = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if aggro :
		if RCright.is_colliding() :
			direction = -1
			sprite.flip_h = true
		if RCleft.is_colliding()  :
			direction = 1
			sprite.flip_h = false
		position.x += direction * speed * delta


func _on_spawn_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	#print("body_rid: ", body_rid,"\n", "body: ", body,"\n", "body_shape_index: ", body_shape_index,"\n", "local_shape_index: ", local_shape_index,)
	if dormant :
		sprite.play("awakening")
		dormant = false


func _on_animated_sprite_2d_animation_finished():
	if (dormant == false and aggro == false) :
		sprite.play("wokeIdle")
		aggro = true
