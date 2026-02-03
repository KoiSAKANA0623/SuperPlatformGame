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
var floor_last_vel: float = 0.0
var running_timer: int = 0
var max_speed: float = 1.5
var accel: float = 0.037109375
var friction: float = 0.07421875
var skidding: bool = false
var y_velocity: float = 0.0
var gravity: float = 0.15625
var jmp_gravity: float = 0.125

var is_bigMario: int = 9
var is_duck: bool = false
var is_grounded: bool = false

const WALK_MAX: float = 1.5
const WALK_UW_MAX: float = 1.0
const WALK_IN_MAX: float = 0.75
const RUN_MAX: float = 2.5
const WALK_ACC: float = 9.5
const RUN_ACC: float = 14.25
const AIR_ACC: float = 13
const WALK_FRICTION: float = 19
const RUN_FRICTION: float = 26
const SLO_GRAVITY: float = 0.4375
const WLK_GRAVITY: float = 0.375
const RUN_GRAVITY: float = 0.5625
const INTR_GRAVITY: float = 0.15625
const SLO_JMP_GRAVITY: float = 0.125
const WLK_JMP_GRAVITY: float = 0.1171875
const RUN_JMP_GRAVITY: float = 0.15625
const JMP_STRG: float = 4.0
const B_JMP_STRG: float = 5.0


func _ready() -> void:
	if !is_grounded:
		Visual_Node.anim = 2 + is_bigMario
	else:
		Visual_Node.anim = 1 + is_bigMario
	set_collision()
## END of _ready


func _physics_process(_delta: float) -> void:
	inp_axis = Input.get_axis("Left","Right")
	if inp_axis && is_grounded:
		direction = inp_axis

	if Input.is_action_pressed("Run") && is_grounded:
		running_timer = 10
	elif running_timer > 0:
		running_timer -= 1

	skidding = false
	if is_grounded:
		if running_timer:
			max_speed = RUN_MAX
			accel = RUN_ACC / 256.0
			friction = RUN_FRICTION / 256.0
		else:
			max_speed = WALK_MAX
			accel = WALK_ACC / 256.0
			friction = WALK_FRICTION / 256.0
		if x_velocity != 0.0:
			if sign(direction) != sign(x_velocity):
				skidding = true
		if skidding && abs(x_velocity) < 0.625:
			x_velocity = 0.0
		if !inp_axis && abs(x_velocity) < 0.07421875:
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

		if inp_axis == -1:
			Visual_Node.horz_mirror = true
		elif inp_axis == 1:
			Visual_Node.horz_mirror = false
	else:
		if abs(floor_last_vel) <= WALK_MAX:
			max_speed = WALK_MAX

		if inp_axis:
			if floor_last_vel > WALK_MAX: # is running
				if inp_axis != direction: # is moving opposite of vel
					accel = AIR_ACC / 256.0
					if abs(x_velocity) > WALK_MAX: # is moving at running speed
						accel = RUN_ACC / 256.0
					elif inp_axis == sign(x_velocity): # is fully going backwards
						accel = RUN_FRICTION / 256.0
			else: # is walking
				if inp_axis != direction: # is moving opposite of vel
					accel = WALK_ACC / 256.0
					if inp_axis == sign(x_velocity): # is fully going backwards
						accel = WALK_FRICTION / 256.0

		if inp_axis:
			x_velocity = move_toward(x_velocity, max_speed * inp_axis, accel)

	do_collisions()

	position.x += x_velocity
	if is_grounded:
		floor_last_vel = x_velocity

	if !is_grounded:
		if Input.is_action_pressed("Jump") && y_velocity < 0:
			y_velocity += jmp_gravity
		else:
			jmp_gravity = gravity
			y_velocity += gravity
		if y_velocity >= 4.5:
			y_velocity = 4
	else:
		y_velocity = 0
		if Input.is_action_just_pressed("Jump"):
			if abs(x_velocity) >= 2.3125:
				y_velocity = -B_JMP_STRG
			else:
				y_velocity = -JMP_STRG
			Visual_Node.anim = 4 + is_bigMario
			is_grounded = false
			if abs(x_velocity) < 1.0:
				gravity = SLO_GRAVITY
				jmp_gravity = SLO_JMP_GRAVITY
			elif abs(x_velocity) >= 2.3125:
				gravity = RUN_GRAVITY
				jmp_gravity = RUN_JMP_GRAVITY
			else:
				gravity = WLK_GRAVITY
				jmp_gravity = WLK_JMP_GRAVITY
	position.y += y_velocity

	# Set Anims
	if is_grounded:
		if x_velocity or inp_axis:
			if skidding && abs(x_velocity) > 0.625:
				Visual_Node.anim = 3 + is_bigMario
			else:
				Visual_Node.anim = 2 + is_bigMario
				if abs(x_velocity) >= 1.75:
					Anim_Node.anim_speed = 2
				elif abs(x_velocity) >= 0.875:
					Anim_Node.anim_speed = 4
				else:
					Anim_Node.anim_speed = 7
		else:
			Visual_Node.anim = 1 + is_bigMario
	else:
		Anim_Node.anim_speed = 0
## END of _physics_process


func do_collisions() -> void:
# Ceiling Collision
	var vel_clamp = clamp(y_velocity,-5.0,0.0)
	HeadCol.target_position.y = vel_clamp
# Floor Collision
	vel_clamp = clamp(y_velocity,0.0,5.0)
	var a = round(global_position.y)
	var b = (round(LeftFootCol.get_collision_point().y) - 32)
	var c = (round(RightFootCol.get_collision_point().y) - 32)
	print(a-b)
	LeftFootCol.target_position.y = vel_clamp
	RightFootCol.target_position.y = vel_clamp
	if y_velocity >= 0.0:
		if LeftFootCol.is_colliding():
			if abs(a-b) < 8.0:
				global_position.y = (round(LeftFootCol.get_collision_point().y/16)*16 - 32)
				is_grounded = true
		elif RightFootCol.is_colliding():
			if abs(a-c) < 8.0:
				global_position.y = (round(RightFootCol.get_collision_point().y/16)*16 - 32)
				is_grounded = true
		else:
			is_grounded = false
	return
# Wall Collision
	if LeftSiHiCol.is_colliding():
		if x_velocity <= 0.0:
			global_position.x += clamp(int(LeftSiHiCol.get_collision_point().x - 1) - global_position.x,-10,2)
			global_position.x -= 1
			x_velocity = 0.0
			return
	elif LeftSiLoCol.is_colliding():
		if x_velocity <= 0.0:
			global_position.x += clamp(int(LeftSiLoCol.get_collision_point().x - 1) - global_position.x,-10,2)
			global_position.x -= 1
			x_velocity = 0.0
			return
	elif x_velocity > 0.0:
		if RightSiHiCol.is_colliding():
			global_position.x -= clamp(global_position.x - int(RightSiHiCol.get_collision_point().x - 15),-10,2)
			global_position.x += 1
			x_velocity = 0.0
			return
		elif RightSiLoCol.is_colliding():
			global_position.x -= clamp(global_position.x - int(RightSiLoCol.get_collision_point().x - 15),-10,2)
			global_position.x += 1
			x_velocity = 0.0
			return

## END of do_collisions


func set_collision() -> void:
	if is_bigMario != 0:
		HeadCol.position = Vector2(8,4)
		LeftSiHiCol.position = Vector2(4,8)
		RightSiHiCol.position = Vector2(12,8)
## currently Unused water col
#		HeadCol.position = Vector2(8,2)
	else:
		HeadCol.position = Vector2(8,22)
		LeftSiHiCol.position = Vector2(4,24)
		RightSiHiCol.position = Vector2(12,24)

	LeftFootCol.position = Vector2(3,32)
	RightFootCol.position = Vector2(13,32)
	LeftSiLoCol.position = Vector2(4,25)
	RightSiLoCol.position = Vector2(12,25)

## END of set_collision
