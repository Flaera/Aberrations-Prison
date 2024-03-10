extends Spatial


# Called when the node enters the scene tree for the first time.
func _ready():
	var preload_player: Object = preload("res://scenes/claudia/claudia_v0.tscn")
	var player: Object = preload_player.instance()
	get_node("summoner_player").add_child(player)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
