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
			rotation.x = lerp(rotation.x, deg_to_rad(-1.0 * default_angle_deg), 5.0 * delta)
	  	# rotation.x = deg_to_rad(-1.0 * default_angle_deg)
		else:
			rotation.x = lerp(rotation.x, deg_to_rad(default_angle_deg), 5.0 * delta)
	  	# rotation.x = deg_to_rad(default_angle_deg)