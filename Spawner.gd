extends Node
class_name Spawner

var asteroid_scene = preload("res://asteroid.tscn")
var asteroid_queue: Array[Vector3] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in 11:
		for j in 11:
			for k in 2:
				# asteroid_queue.push(Vector3(i * 10, k * 10, j * 10))
				asteroid_queue.push_back(Vector3(i * 10, k * 10, j * 10))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if asteroid_queue.size():
		var pos = asteroid_queue.pop_front()
		var asteroid = spawn_asteroid(pos)
		asteroid.linear_velocity = Vector3(randf_range(-5.0, 5.0), randf_range(-5.0, 5.0), randf_range(-5.0, 5.0))
		asteroid.angular_velocity = Vector3(randf_range(-2.0, 2.0), randf_range(-2.0, 2.0), randf_range(-2.0, 2.0))


func spawn_asteroid(position: Vector3) -> Asteroid:
	var asteroid: Asteroid = asteroid_scene.instantiate()
	asteroid.noise_seed = randi()
	asteroid.asteroid_size = randi() % 6 + 4
	asteroid.position = position
	add_child(asteroid)
	return asteroid