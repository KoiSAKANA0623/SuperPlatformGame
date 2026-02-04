extends Node2D
class_name Mario_Player

@onready var Anim_Node = $MarioAnim
@onready var Visual_Node = $MarioVisual
@onready var Camera_Node = $Camera2D

@onready var HeadCol = $MarioCollision/Head
@onready var LeftSiHiCol = $MarioCollision/LeftSideHi
@onready var LeftSiLoCol = $MarioCollision/LeftSideLo
@onready var RightSiHiCol = $MarioCollision/RightSideHi
@onready var RightSiLoCol = $MarioCollision/RightSideLo
@onready var LeftFootCol = $MarioCollision/LeftFoot
@onready var RightFootCol = $MarioCollision/RightFoot
@onready var TopBlock_Check = $MarioCollision/TopCheck
@onready var BottomBlock_Check = $MarioCollision/BottomCheck

var inp_axis: float = 0.0

var direction: int = 0
var x_velocity: float = 0.0
var floor_last_vel: float = 0.0
var running_timer: int = 0
var max_speed: float = 1.5
var accel: float = 0.037109375
var friction: float = 0.07421875
var crouch_acc: float = 0.037109375
var skidding: bool = false
var y_velocity: float = 0.0
var gravity: float = 0.15625
var jmp_gravity: float = 0.125

var is_bigMario: int = 0 #9
var is_big_Adder: int = 0
var is_duck: bool = false
var is_grounded: bool = false
var underwater: bool = false

var swim_counter: int = 0

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
const SWIM_GRAVITY: float = 0.0390625
const SWIM_JMP_GRAVITY: float = 0.05078125
const SWIM_SURF_GRAVITY: float = 0.09375
const SWIM_STRG: float = 1.5
const WATER_HEIGHT: int = 20


func _ready() -> void:
	set_collision()
	if !is_grounded:
		Visual_Node.anim = 2 + is_bigMario
	else:
		Visual_Node.anim = 1 + is_bigMario
## END of _ready


func _physics_process(_delta: float) -> void:
	inp_axis = Input.get_axis("Left","Right")
	if underwater:
		direction = inp_axis
	elif inp_axis && is_grounded:
		direction = inp_axis

	if is_grounded:
		if Input.is_action_pressed("Down"):
			is_duck = true
			set_collision()
		else:
			is_duck = false
			set_collision()
	else:
		is_duck = false

	if Input.is_action_pressed("Run") && is_grounded:
		running_timer = 10
	elif running_timer > 0:
		running_timer -= 1

	# Set Anims
	if is_grounded:
		if x_velocity:
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
				if is_duck && !inp_axis && is_bigMario != 0:
					Visual_Node.anim = 14
		else:
			Visual_Node.anim = 1 + is_bigMario
			if !inp_axis:
				if is_duck && is_bigMario != 0:
					Visual_Node.anim = 14
			elif !is_duck:
				Visual_Node.anim = 2 + is_bigMario
				Anim_Node.anim_speed = 7
	else:
		if !underwater:
			Anim_Node.anim_speed = 0
			if (Visual_Node.anim == 3 + is_bigMario) || (Visual_Node.anim == 1 + is_bigMario):
				Visual_Node.anim = 2 + is_bigMario
		else:
			if swim_counter:
				swim_counter -= 1
			else:
				if (Visual_Node.anim == 8 + is_bigMario):
					if Anim_Node.fake_frame == 5:
						Visual_Node.anim = 7 + is_bigMario
				else:
					Visual_Node.anim = 7 + is_bigMario

	if !underwater:
		ground_phys()
	else:
		water_phys()

	camera()
## END of _physics_process


func ground_phys() -> void:
## X MOVEMENT
	if is_grounded:
		if running_timer:
			max_speed = RUN_MAX
			accel = RUN_ACC / 256.0
			friction = RUN_FRICTION / 256.0
		else:
			max_speed = WALK_MAX
			accel = WALK_ACC / 256.0
			friction = WALK_FRICTION / 256.0
		if !is_duck:
			if abs(x_velocity) > WALK_MAX:
				crouch_acc = AIR_ACC / 256.0
			else:
				crouch_acc = WALK_ACC / 256.0
		if x_velocity != 0.0:
			if inp_axis:
				if sign(direction) != sign(x_velocity):
					skidding = true
				else:
					skidding = false
		if skidding or (is_duck && !inp_axis):
			if abs(x_velocity) < 0.625:
				x_velocity = 0.0
				skidding = false
		if !inp_axis && abs(x_velocity) < 0.07421875:
			x_velocity = 0.0
		if inp_axis && !is_duck:
			if skidding:
				x_velocity = move_toward(x_velocity, max_speed * direction, friction)
			else:
				x_velocity = move_toward(x_velocity, max_speed * direction, accel)
		else:
			if skidding:
				x_velocity = move_toward(x_velocity, 0.0, friction)
			else:
				if is_duck:
					x_velocity = move_toward(x_velocity, 0.0, crouch_acc)
				else:
					x_velocity = move_toward(x_velocity, 0.0, accel)
		if !is_duck:
			if inp_axis == -1:
				Visual_Node.horz_mirror = true
			elif inp_axis == 1:
				Visual_Node.horz_mirror = false
	else:
		skidding = false
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

## Y MOVEMENT
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
			if Visual_Node.anim != 14 or (!is_duck && !Input.is_action_pressed("Down")):
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
## END of ground_phys


func water_phys() -> void:
	max_speed = WALK_UW_MAX
	accel = WALK_ACC / 256.0
	friction = WALK_FRICTION / 256.0
	if !is_duck:
		crouch_acc = WALK_ACC / 256.0
	if x_velocity != 0.0:
		if inp_axis:
			if sign(direction) != sign(x_velocity):
				skidding = true
			else:
				skidding = false
## X MOVEMENT
	if is_grounded:
		if skidding or (is_duck && !inp_axis):
			if abs(x_velocity) < 0.625:
				x_velocity = 0.0
				skidding = false
		if !inp_axis && abs(x_velocity) < 0.07421875:
			x_velocity = 0.0
		if inp_axis && !is_duck:
			if skidding:
				x_velocity = move_toward(x_velocity, max_speed * direction, friction)
			else:
				x_velocity = move_toward(x_velocity, max_speed * direction, accel)
		else:
			if skidding:
				x_velocity = move_toward(x_velocity, 0.0, friction)
			else:
				if is_duck:
					x_velocity = move_toward(x_velocity, 0.0, crouch_acc)
				else:
					x_velocity = move_toward(x_velocity, 0.0, accel)
		if !is_duck:
			if inp_axis == -1:
				Visual_Node.horz_mirror = true
			elif inp_axis == 1:
				Visual_Node.horz_mirror = false
	else:
		skidding = false
		is_duck = false
		max_speed = WALK_MAX
		if inp_axis:
			if skidding:
				x_velocity = move_toward(x_velocity, max_speed * direction, friction)
			else:
				x_velocity = move_toward(x_velocity, max_speed * direction, accel)
		if inp_axis == -1:
			Visual_Node.horz_mirror = true
		elif inp_axis == 1:
			Visual_Node.horz_mirror = false

	do_collisions()
	position.x += x_velocity
	if is_grounded:
		floor_last_vel = x_velocity

## Y MOVEMENT
	var can_swim = true
	if !is_grounded:
		if global_position.y < WATER_HEIGHT:
			y_velocity += SWIM_SURF_GRAVITY
			can_swim = false
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
		if can_swim:
			y_velocity = -SWIM_STRG
			gravity = SWIM_GRAVITY
			jmp_gravity = SWIM_JMP_GRAVITY
		elif y_velocity <= 0.0:
			y_velocity = 0.0
		swim_counter = 8
		Visual_Node.anim = 8 + is_bigMario
		is_grounded = false
	position.y += y_velocity
## END of water_phys


func do_collisions() -> void:
# Ceiling Collision
	TopBlock_Check.global_position.x = round(global_position.x/16)*16 + 8
	TopBlock_Check.global_position.y = round(global_position.y/16)*16 - 8 + is_big_Adder
	var vel_clamp = clamp(y_velocity,-5.0,0.0)
	HeadCol.target_position.y = vel_clamp
	if y_velocity < 0.0:
		if HeadCol.is_colliding() && TopBlock_Check.get_overlapping_bodies():
			y_velocity = 1.0
# Floor Collision
	BottomBlock_Check.global_position.x = ceil(global_position.x) + 8
	BottomBlock_Check.global_position.y = round((global_position.y+4)/16)*16 + 40
	vel_clamp = clamp(y_velocity,0.0,5.0)
	var a = round(global_position.y/16)*16
	var b = (round(LeftFootCol.get_collision_point().y) - 32)
	var c = (round(RightFootCol.get_collision_point().y) - 32)
	LeftFootCol.target_position.y = vel_clamp
	RightFootCol.target_position.y = vel_clamp
	if y_velocity >= 0.0 && BottomBlock_Check.get_overlapping_bodies():
		if LeftFootCol.is_colliding():
			if (a-b) <= 2.0:
				global_position.y = (round(LeftFootCol.get_collision_point().y/16)*16 - 32)
				is_grounded = true
				if !Input.is_action_pressed("Down"):
					set_collision()
		elif RightFootCol.is_colliding():
			if abs(a-c) < 8.0:
				global_position.y = (round(RightFootCol.get_collision_point().y/16)*16 - 32)
				is_grounded = true
				if !Input.is_action_pressed("Down"):
					set_collision()
		else:
			is_grounded = false
	else:
		is_grounded = false
# Wall Collision
	LeftSiHiCol.target_position.x = clamp(x_velocity * 2,-3.0,-2.0)
	LeftSiLoCol.target_position.x = clamp(x_velocity * 2,-3.0,-2.0)
	if LeftSiHiCol.is_colliding():
		if x_velocity <= 0.0:
			global_position.x += clamp(round(LeftSiHiCol.get_collision_point().x - 1) - global_position.x,-10,2)
			global_position.x -= 1
			x_velocity = 0.0
		return
	elif LeftSiLoCol.is_colliding():
		if x_velocity <= 0.0:
			global_position.x += clamp(round(LeftSiLoCol.get_collision_point().x - 1) - global_position.x,-10,2)
			global_position.x -= 1
			x_velocity = 0.0
		return
	RightSiHiCol.target_position.x = clamp(x_velocity * 2,2.0,3.0)
	RightSiLoCol.target_position.x = clamp(x_velocity * 2,2.0,3.0)
	if RightSiHiCol.is_colliding():
		if x_velocity >= 0.0:
			global_position.x -= clamp(global_position.x - round(RightSiHiCol.get_collision_point().x - 15),-10,2)
			global_position.x += 1
			x_velocity = 0.0
		return
	elif RightSiLoCol.is_colliding():
		if x_velocity >= 0.0:
			global_position.x -= clamp(global_position.x - round(RightSiLoCol.get_collision_point().x - 15),-10,2)
			global_position.x += 1
			x_velocity = 0.0
		return
## END of do_collisions


func set_collision() -> void:
	if is_bigMario == 0 or (is_duck && !inp_axis):
		is_big_Adder = 16
		HeadCol.position = Vector2(8,22)
		LeftSiHiCol.position = Vector2(4,24)
		RightSiHiCol.position = Vector2(12,24)
	else:
		if underwater:
			HeadCol.position = Vector2(8,2)
		else:
			HeadCol.position = Vector2(8,4)
		is_big_Adder = 0
		LeftSiHiCol.position = Vector2(4,8)
		RightSiHiCol.position = Vector2(12,8)

	LeftFootCol.position = Vector2(3,32)
	RightFootCol.position = Vector2(13,32)
	LeftSiLoCol.position = Vector2(4,25)
	RightSiLoCol.position = Vector2(12,25)
## END of set_collision


func camera() -> void:
	var cam_move = (global_position.x+16.0) - Camera_Node.global_position.x
	Camera_Node.global_position.y = 128

	if global_position.x+16.0 > Camera_Node.global_position.x:
		Camera_Node.global_position.x += cam_move

	if global_position.x >= 512:
		global_position.x -= 512
		Camera_Node.global_position.x -= 512
## END of camera
