extends Camera3D

@export
var marker: Marker3D

@export
var max_follow_distance = 1.0

@export
var camera_follow_speed = 5.0

# In Euler angles
@export
var max_rotation_diff = 35.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_camera_velocity(d: float):
	return 5.0 * d / max_follow_distance

# UNUSED
func get_camera_rotation(d: float):
	return 1.0 * d / deg_to_rad(max_rotation_diff) # I'm pretty sure I'm supposed to clamp this at 1.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = (global_position - marker.global_position).length()

	print(distance)
	var marker_basis = Basis(marker.global_transform.basis)
	# TODO:
	# Calculate the difference between the angles of this and marker, then adjust speed
	# to compensate for the rotation
	global_transform.basis = global_transform.basis.slerp(marker_basis.orthonormalized(), PI * delta)
	position = position.move_toward(marker.global_position, get_camera_velocity(distance) * delta)