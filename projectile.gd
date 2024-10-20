extends Node3D

var particles_scene = preload("res://asteroid_impact_particles.tscn")

# in m/s
var velocity: float = 250.0
var direction: Vector3 = Vector3()


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area3D.body_entered.connect(handle_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction.normalized() * velocity * delta

func handle_body_entered(body):
	if body is Asteroid:
		var particles = particles_scene.instantiate()
		particles.position = global_position
		get_tree().root.add_child(particles)
		particles.emitting = true
		body.destroy.emit()
		queue_free()