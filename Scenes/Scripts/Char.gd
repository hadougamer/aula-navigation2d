extends KinematicBody2D

var speed = 300
var path = PoolVector2Array() setget set_path
var direction = "right"

func _ready():
	set_process(false)

func _process(delta):
	var move_distance = speed * delta
	move_along_path( move_distance )

# Right or Left (Sprite control)
func set_direction(path):
	# Exists almost index 0 and 1 on path
	if range(path.size()).has(1):
		if path[0].x > path[1].x:
			direction = "left"
		else:
			direction = "right"
	else:
		direction = "right"


func move_along_path(distance):
	$Sprite.play("walk-"  + direction );

	# Start point is current position
	var start_point = global_position
	
	for i in range( path.size() ):
		set_direction(path)

		var distance_to_next = start_point.distance_to(path[0])
		if distance < distance_to_next and distance >= 0.0:
			global_position = start_point.linear_interpolate(path[0], (distance/distance_to_next))
			break
		elif distance < 0.0:
			global_position = path[0]
			set_process(false)
			break

		distance -= distance_to_next
		start_point = path[0]
		path.remove(0)
		
	if( path.size() == 0 ):
		$Sprite.stop();

func set_path(value):
	path = value
	
	if value.size() == 0:
		return

	set_process(true)
