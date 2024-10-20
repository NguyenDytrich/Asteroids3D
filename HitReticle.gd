extends Sprite2D

const RAY_LENGTH = 1000.0

@export var camera: Camera3D

@export var max_aim_diff = 16.0

# Called when the node enters the scene tree for the first time.
func _ready():
	center_reticle()
	get_tree().root.size_changed.connect(center_reticle)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		get_aim_point()

func _physics_process(delta):
	var input = Input.get_vector("turn_left", "turn_right", "pitch_down", "pitch_up")

	var default_pos = (get_viewport_rect().size / 2) + Vector2.UP * 72.0
	position = lerp(position, default_pos + (input * 128.0), 5.0 * delta)
	# position = default_pos + input * 16

# TODO:
# When the user fires their ship's weapon, a ray should be cast to determine
# A point to aim the projectile

func get_aim_point():
	var reticle_pos = get_viewport_transform()


func center_reticle():
	position = (get_viewport_rect().size / 2) + Vector2.UP * 72.0
