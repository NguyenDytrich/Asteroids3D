extends CharacterBody3D

var projectile_scene = preload("res://projectile.tscn")

# In m/s
@export var speed = 5.0

# In radians/sec
@export var turn_speed = PI/2

# In radians/sec
@export var pitch_speed = PI/2
# In radians/sec
@export var roll_speed = PI/2

func _physics_process(delta):

	# Movement
	var yaw_dir = Input.get_axis("turn_left", "turn_right")
	var pitch_dir = Input.get_axis("pitch_down", "pitch_up")
	var roll_dir = Input.get_axis("roll_left", "roll_right")

	if yaw_dir:
		global_transform.basis = global_transform.basis.rotated(global_transform.basis.y.normalized(), yaw_dir * -turn_speed * delta)
	if pitch_dir:
		global_transform.basis = global_transform.basis.rotated(global_transform.basis.x.normalized(), pitch_dir * pitch_speed * delta)
	if roll_dir:
		global_transform.basis = global_transform.basis.rotated(global_transform.basis.z.normalized(), roll_dir * roll_speed * delta)
	
	if Input.is_action_pressed("thruster_fwd"):
		velocity = global_transform.basis.z * speed
	else:
		velocity = lerp(velocity, Vector3(0, 0, 0), speed * delta)
	
	# Pew pew
	if Input.is_action_just_pressed("fire"):
		var projectile = projectile_scene.instantiate()
		projectile.velocity = 250.0
		projectile.direction = global_transform.basis.z
		projectile.position = $BulletOrigin.global_position
		get_tree().get_root().add_child(projectile)


	move_and_slide()
