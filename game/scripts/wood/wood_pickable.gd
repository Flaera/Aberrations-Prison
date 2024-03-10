extends Spatial


func _on_area_wood_pickable_body_entered(body):
	#print("body in wood=", body.name)
	if (body.name=="player"):
		#print("DELETE")
		queue_free()
