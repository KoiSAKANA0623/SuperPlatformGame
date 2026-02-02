extends Node2D
class_name Mario_Player

@onready var Anim_Node = $MarioAnim
@onready var Visual_Node = $MarioVisual

@onready var HeadCol = $MarioCollision/Head
@onready var LeftSiHiCol = $MarioCollision/LeftSideHi
@onready var LeftSiLoCol = $MarioCollision/LeftSideLo
@onready var RightSiHiCol = $MarioCollision/RightSideHi
@onready var RightSiLoCol = $MarioCollision/RightSideLo
@onready var LeftFootCol = $MarioCollision/LeftFoot
@onready var RightFootCol = $MarioCollision/RightFoot

var inp_axis: float = 0.0

var direction: int = 0
var x_velocity: float = 0.0
var running_timer: int = 0
var max_speed: float = 1.5
var accel: float = 0.037109375
var friction: float = 0.07421875
var skidding: bool = false
var y_velocity: float = 0.0
var gravity: float = 0.0

var is_bigMario: bool = true
var is_grounded: bool = false

const WALK_MAX: float = 1.5
const WALK_UW_MAX: float = 1.0
const WALK_IN_MAX: float = 0.75
const RUN_MAX: float = 2.5
const WALK_ACC: float = 9.5
const RUN_ACC: float = 14.25
const WALK_FRICTION: float = 19
const RUN_FRICTION: float = 26
const SLO_GRAVITY: float = 0.4375


func _ready() -> void:
	set_collision()
## END of _ready


func _physics_process(_delta: float) -> void:
	inp_axis = Input.get_axis("Left","Right")
	if inp_axis:
		direction = inp_axis

	do_collisions()

	if Input.is_action_pressed("Run"):
		running_timer = 10
	elif running_timer > 0:
		running_timer -= 1
	if running_timer:
		max_speed = RUN_MAX
		accel = RUN_ACC / 256.0
		friction = RUN_FRICTION / 256.0
	else:
		max_speed = WALK_MAX
		accel = WALK_ACC / 256.0
		friction = WALK_FRICTION / 256.0

	skidding = false
	if x_velocity != 0.0:
		if sign(direction) != sign(x_velocity):
			skidding = true
	if skidding && abs(x_velocity) < 0.625:
		x_velocity = 0.0

	if inp_axis:
		if skidding:
			x_velocity = move_toward(x_velocity, max_speed * direction, friction)
		else:
			x_velocity = move_toward(x_velocity, max_speed * direction, accel)
	else:
		if skidding:
			x_velocity = move_toward(x_velocity, 0.0, friction)
		else:
			x_velocity = move_toward(x_velocity, 0.0, accel)

	position.x += x_velocity

	if !is_grounded:
		gravity = SLO_GRAVITY
		y_velocity += gravity
		if y_velocity >= 4.5:
			y_velocity = 4
	else:
		y_velocity = 0
	position.y += y_velocity

	if inp_axis == -1:
		Visual_Node.horz_mirror = true
	elif inp_axis == 1:
		Visual_Node.horz_mirror = false

	# Set Anims
	if x_velocity or inp_axis:
		if skidding:
			Visual_Node.anim = 3
		else:
			Visual_Node.anim = 2
			if abs(x_velocity) >= 1.75:
				Anim_Node.anim_speed = 2
			elif abs(x_velocity) >= 0.875:
				Anim_Node.anim_speed = 4
			else:
				Anim_Node.anim_speed = 7
	else:
		Visual_Node.anim = 1
## END of _physics_process


func do_collisions() -> void:
# Ceiling Collision
	var y_vel_clamp = clamp(y_velocity,-5.0,0.0)
	HeadCol.target_position.y = y_vel_clamp
# Floor Collision
	y_vel_clamp = clamp(y_velocity,0.0,5.0)
	LeftFootCol.target_position.y = y_vel_clamp
	RightFootCol.target_position.y = y_vel_clamp
	if y_velocity >= 0.0:
		if LeftFootCol.is_colliding():
			global_position.y = round(LeftFootCol.get_collision_point().y - 32.0)
			is_grounded = true
		elif RightFootCol.is_colliding():
			global_position.y = round(RightFootCol.get_collision_point().y - 32.0)
			is_grounded = true
		else:
			is_grounded = false
# Wall Collision
	LeftSiHiCol.target_position.x = 0.0
	LeftSiLoCol.target_position.x = 0.0
	if LeftSiHiCol.is_colliding() && x_velocity <= 0.0:
		global_position.x = LeftSiLoCol.global_position.x
		x_velocity = 0.0
#	elif LeftSiLoCol.is_colliding():
#		global_position.x = round(LeftSiLoCol.get_collision_point().x - 2.0)
#		x_velocity = 0.0

## END of do_collisions


func set_collision() -> void:
	if is_bigMario:
		HeadCol.position = Vector2(8,4)
		LeftSiHiCol.position = Vector2(2,8)
		RightSiHiCol.position = Vector2(14,8)
## currently Unused water col
#		HeadCol.position = Vector2(8,2)
	else:
		HeadCol.position = Vector2(8,22)
		LeftSiHiCol.position = Vector2(2,24)
		RightSiHiCol.position = Vector2(14,24)

	LeftFootCol.position = Vector2(3,32)
	RightFootCol.position = Vector2(13,32)
	LeftSiLoCol.position = Vector2(2,24)
	RightSiLoCol.position = Vector2(14,24)

## END of set_collision
