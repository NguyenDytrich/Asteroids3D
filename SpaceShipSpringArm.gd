@tool
extends SpringArm3D

var default_angle_deg: float = -20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var child = get_child(0)
	child.position.z = spring_length

func _physics_process(delta):
	if not Engine.is_editor_hint():
		var pitch_dir = Input.get_axis("pitch_down", "pitch_up")
		if pitch_dir > 0:
			rotation.x = lerp(rotation.x, deg_to_rad(-2.0 * default_angle_deg), 2.0 * delta)
			get_child(0).rotation.x = lerp(get_child(0).rotation.x, deg_to_rad(-20.0), 2.0 * delta)
		elif pitch_dir < 0:
			rotation.x = lerp(rotation.x, deg_to_rad(1.5 * default_angle_deg), 5.0 * delta)
			get_child(0).rotation.x = lerp(get_child(0).rotation.x, deg_to_rad(6.0), 2.0 * delta)
		else:
			rotation.x = lerp(rotation.x, deg_to_rad(default_angle_deg), 5.0 * delta)
			get_child(0).rotation.x = lerp(get_child(0).rotation.x, deg_to_rad(15), 2.0 * delta)
		
		
		var yaw_dir = Input.get_axis("turn_left", "turn_right")
		if yaw_dir > 0:
			rotation.y = lerp(rotation.y, deg_to_rad(180.0 + 20.0 * abs(yaw_dir)), 5.0 * delta)
		elif yaw_dir < 0:
			rotation.y = lerp(rotation.y, deg_to_rad(180.0 - 20.0 * abs(yaw_dir)), 5.0 * delta)
		else:
			rotation.y = lerp(rotation.y, deg_to_rad(180), 5.0 * delta)

		var roll_dir = Input.get_axis("roll_left", "roll_right")
		if roll_dir > 0:
			rotation.z = lerp(rotation.z, deg_to_rad(25.0 * abs(roll_dir)), 5.0 * delta)
		elif roll_dir < 0:
			rotation.z = lerp(rotation.z, deg_to_rad(-25.0 * abs(roll_dir)), 5.0 * delta)
		else:
			rotation.z = lerp(rotation.z, deg_to_rad(0), 5.0 * delta)

		if Input.is_action_pressed("thruster_fwd"):
			spring_length = lerp(spring_length, 8.0, 5.0 * delta)
		else:
			spring_length = lerp(spring_length, 6.0, 5.0 * delta)