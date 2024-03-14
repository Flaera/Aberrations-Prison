extends KinematicBody


var velocity: Vector3 = Vector3(0.0,0.0,0.0)
var mode: int = 0
var target_obj: Object = null


func _ready():
	get_node("Armature_enemy/AnimationPlayer").play("idle_enemy")


func _process(_delta):
	if (not(is_on_floor())):
		velocity.y = -10
		move_and_slide(velocity,Vector3.UP,true)
	if (mode==1):
		get_node("Armature_enemy/AnimationPlayer").play("run_enemy")
		look_at(target_obj.global_transform.origin,Vector3.UP)
		velocity = -transform.basis.xform(Vector3(0,0,1))*10
		move_and_slide(velocity,Vector3.UP,true)
		#print("|",target_obj.translation,"|",target_obj.global_transform.origin,"|")
	velocity = Vector3(0.0, 0.0, 0.0)


func _on_Area_vision_body_entered(body):
	#print("body=", body)
	if (body.name=="player"):
		mode = 1
		target_obj = body


