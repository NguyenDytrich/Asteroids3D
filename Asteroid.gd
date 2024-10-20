@tool
extends RigidBody3D
class_name Asteroid

signal changed
signal changed_size

signal destroy

var asteroid_scene = preload("res://asteroid.tscn")

const MIN_SIZE = 4

@export
var noise_seed: int = 0 :
	set(v):
		noise_seed = v
		changed.emit()

@export
var asteroid_size: float = 1.0 :
	set(v):
		asteroid_size = v
		changed_size.emit()

func _ready():
	changed.connect(update_noise_seed)
	changed_size.connect(update_size)

	if not Engine.is_editor_hint():
		update_noise_seed()
		update_size()
		destroy.connect(handle_destroy)

func _process(_delta):
	pass

func update_noise_seed():
	var material: ShaderMaterial = $MeshInstance3D.mesh.material
	var noise_texture: NoiseTexture2D = material.get_shader_parameter("noise_tex")
	var noise: FastNoiseLite = noise_texture.noise
	noise.seed = noise_seed

func update_size():
	$MeshInstance3D.scale = Vector3(1.0, 1.0, 1.0) * asteroid_size
	$CollisionShape3D.scale = Vector3(1.0, 1.0, 1.0) * asteroid_size

func handle_destroy():
	if asteroid_size > 4:
		for i in 2:
			var frag: Asteroid = asteroid_scene.instantiate() 
			frag.global_position = position
			frag.asteroid_size = asteroid_size - 1.0
			frag.linear_velocity = Vector3(randf_range(-5.0, 5.0), randf_range(-5.0, 5.0), randf_range(-5.0, 5.0))
			frag.angular_velocity = Vector3(randf_range(-2.0, 2.0), randf_range(-2.0, 2.0), randf_range(-2.0, 2.0))
			# TODO: we want to move the asteroids away from the projectile hit location
			get_parent().add_child(frag)
	else:
		queue_free()