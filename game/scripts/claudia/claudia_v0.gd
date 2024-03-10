extends KinematicBody


var accel: float = 20
var velocity: Vector3 = Vector3.ZERO
var gravity: Vector3 = Vector3(0.0,10.0,0.0)
var angle_y: float = 0.0
var delta_angle: float = 90.0
var wood_obj: Object


# Called when the node enters the scene tree for the first time.
func _ready():
	wood_obj = preload("res://scenes/claudia/wood_claudia.tscn")
	get_node("Camera").current=true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	if (not(is_on_floor())):
		velocity.y = -gravity.y
	if ((Input.is_action_pressed("ui_up")or(Input.is_action_just_pressed("ui_up"))) and (Input.is_action_pressed("ui_right")or(Input.is_action_just_pressed("ui_right")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = -accel
		velocity.z = accel
		angle_y = -45
	elif ((Input.is_action_pressed("ui_up")or(Input.is_action_just_pressed("ui_up"))) and (Input.is_action_pressed("ui_left")or(Input.is_action_just_pressed("ui_left")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = accel
		velocity.z = accel
		angle_y = 45
	elif ((Input.is_action_pressed("ui_down")or(Input.is_action_just_pressed("ui_down"))) and (Input.is_action_pressed("ui_right")or(Input.is_action_just_pressed("ui_right")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = -accel
		velocity.z = -accel
		angle_y = -135
	elif ((Input.is_action_pressed("ui_down")or(Input.is_action_just_pressed("ui_down"))) and (Input.is_action_pressed("ui_left")or(Input.is_action_just_pressed("ui_left")))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = accel
		velocity.z = -accel
		angle_y = 135
	elif (Input.is_action_pressed("ui_up")or(Input.is_action_just_pressed("ui_up"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.z = accel
		angle_y = 0.0
	elif (Input.is_action_pressed("ui_down")or(Input.is_action_just_pressed("ui_down"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.z = -accel
		angle_y = 180
	elif (Input.is_action_pressed("ui_right")or(Input.is_action_just_pressed("ui_right"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = -accel
		angle_y = -90
	elif (Input.is_action_pressed("ui_left")or(Input.is_action_just_pressed("ui_left"))):
		get_node("Armature_claudia/AnimationPlayer").play("run")
		velocity.x = accel
		angle_y = 90
	else:
		get_node("Armature_claudia/AnimationPlayer").play("idle")
	move_and_slide(velocity, Vector3.UP, true)
	get_node("Armature_claudia").rotation_degrees.y = angle_y
	
	#angle_y = 0.0
	velocity = Vector3(0.0,0.0,0.0)


func pick_and_delete(var body: Object):
	print("FOI!")
	#if (Input.is_action_just_pressed("ui_accept")):
	get_node("Armature_claudia/grab_point2").add_child(wood_obj.instance())
	body.get_parent().get_parent().queue_free()


func _on_Area_pickable_area_entered(body):
	print("AQUI=", body)
	if (body.name=="area_wood_pickable"):
		pick_and_delete(body)

