extends KinematicBody


const ACCEL = 20
var velocity: Vector3 = Vector3.ZERO
var gravity: Vector3 = Vector3(0.0,10.0,0.0)
var angle_y: float = 0.0
var delta_angle: float = 90.0
var player_mode: int = 0 #0 normal and 1 aberration mode
var with_hand_object: bool = false
var max_wood: int = 5
var current_wood: int = max_wood
var in_atk: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Camera").current=true
	get_node("Armature_claudia/grab_point2/Cube").visible=false


func attack():
	if (with_hand_object==false):
		get_node("Armature_claudia/AnimationPlayer").play("attack")
	else:
		get_node("Armature_claudia/AnimationPlayer").play("attack2")
		in_atk=true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (not(is_on_floor())):
		velocity.y = -gravity.y
	
	if (Input.is_action_just_pressed("attack")):
		attack()
	elif ((Input.is_action_pressed("ui_up")or(Input.is_action_just_pressed("ui_up"))) and (Input.is_action_pressed("ui_right")or(Input.is_action_just_pressed("ui_right")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = -ACCEL
		velocity.z = ACCEL
		angle_y = -45
	elif ((Input.is_action_pressed("ui_up")or(Input.is_action_just_pressed("ui_up"))) and (Input.is_action_pressed("ui_left")or(Input.is_action_just_pressed("ui_left")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = ACCEL
		velocity.z = ACCEL
		angle_y = 45
	elif ((Input.is_action_pressed("ui_down")or(Input.is_action_just_pressed("ui_down"))) and (Input.is_action_pressed("ui_right")or(Input.is_action_just_pressed("ui_right")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = -ACCEL
		velocity.z = -ACCEL
		angle_y = -135
	elif ((Input.is_action_pressed("ui_down")or(Input.is_action_just_pressed("ui_down"))) and (Input.is_action_pressed("ui_left")or(Input.is_action_just_pressed("ui_left")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = ACCEL
		velocity.z = -ACCEL
		angle_y = 135
	elif (Input.is_action_pressed("ui_up")or(Input.is_action_just_pressed("ui_up"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.z = ACCEL
		angle_y = 0.0
	elif (Input.is_action_pressed("ui_down")or(Input.is_action_just_pressed("ui_down"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.z = -ACCEL
		angle_y = 180
	elif (Input.is_action_pressed("ui_right")or(Input.is_action_just_pressed("ui_right"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = -ACCEL
		angle_y = -90
	elif (Input.is_action_pressed("ui_left")or(Input.is_action_just_pressed("ui_left"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = ACCEL
		angle_y = 90
	elif (get_node("Armature_claudia/AnimationPlayer").is_playing()==false):
		get_node("Armature_claudia/AnimationPlayer").play("idle")
	move_and_slide(velocity, Vector3.UP, true)
	get_node("Armature_claudia").rotation_degrees.y = angle_y
	
	#angle_y = 0.0
	velocity = Vector3(0.0,0.0,0.0)
	
	if (current_wood==0):
		get_node("Armature_claudia/grab_point2/Cube").visible=false
		current_wood = max_wood


func pick_and_delete(var body: Object):
	with_hand_object = true
	#if (Input.is_action_just_pressed("ui_accept")):
	body.get_parent().get_parent().queue_free()
	get_node("Armature_claudia/grab_point2/Cube").visible=true


func _on_Area_pickable_area_entered(body):
	#print("AQUI=", body)
	if (body.name=="area_wood_pickable"):
		pick_and_delete(body)


func _on_Area_wood_hitbox_area_entered(area):
	print("Area=",area)
	if (get_node("Armature_claudia/grab_point2/Cube").visible==true and area.name=="Area_enemy0_hitbox_hurtbox" and in_atk==true):
		current_wood-=1
		in_atk=false
		area.get_parent().queue_free()


func _on_Area_wood_hitbox_body_entered(body):
	print("Body=",body)
