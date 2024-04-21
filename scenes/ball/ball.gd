extends CharacterBody2D

class_name Ball

const INITIAL_SPEED = 285.0
const SPEED_BOOST_BLOCK = 0.5

const LOWEST_INCLINATION = 0
const INITIAL_DIRECTION = 1
const HIGHEST_INCLINATION = 3
const DIRECTIONS = {
	0: Vector2(0.866025, -0.5), 
	1: Vector2(0.707107, -0.707107),
	2: Vector2(0.5, -0.866025),
	3: Vector2(0.2588, -0.9659)
	}
	
var speed = INITIAL_SPEED
var direction = INITIAL_DIRECTION

signal collided_with_block

func _ready():
	reset_direction()
	reset_speed()

func _physics_process(delta):
	var collision_info = move_and_collide(velocity * delta)
	if collision_info != null:
		var collider_velocity = collision_info.get_collider_velocity()
		var bounced_velocity = velocity.bounce(collision_info.get_normal())
		var vel_x = bounced_velocity.x
		var vel_y = bounced_velocity.y
		var collider = collision_info.get_collider()
		if collider is Block:
			collider.position.x = -1000
			collider.position.y = -1000
			speed += SPEED_BOOST_BLOCK
			collider.play_sfx()
			collided_with_block.emit(collider.points)
		velocity = Vector2(vel_x, vel_y).normalized() * speed
		if collider is Player && collider_velocity.x != 0:
			var direction_multiplier = Vector2(1.0, 1.0)
			if (sign(collider_velocity.x) == sign(velocity.x)):
				direction = max(direction - 1, LOWEST_INCLINATION);
			else:
				if (direction == HIGHEST_INCLINATION):
					direction_multiplier = direction_multiplier * Vector2(-1.0, 1.0)
				direction = min(direction + 1, HIGHEST_INCLINATION);
			if velocity.x < 0:
				direction_multiplier = direction_multiplier * Vector2(-1.0, 1.0)
			velocity = DIRECTIONS[direction] * direction_multiplier * speed

func start_movement():
	velocity = DIRECTIONS[direction] * speed

func reset_speed():
	speed = INITIAL_SPEED

func reset_direction():
	direction = INITIAL_DIRECTION
