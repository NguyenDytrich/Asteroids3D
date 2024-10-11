extends CharacterBody3D

# In m/s
@export var speed = 5.0

# In radians/sec
@export var turn_speed = PI/2

func _physics_process(delta):

	var input_dir = Input.get_vector("turn_left", "turn_right", "down", "up")

	if input_dir.x :
			transform.basis = transform.basis.rotated(Vector3.UP, input_dir.x * turn_speed * delta)

	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
