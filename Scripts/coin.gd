extends Area2D

var bob_height : float = 5.0
var bob_speed : float = 3.0
@onready var start_y : float = global_position.y
var time : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	
	var d = (sin(time * bob_speed) + 1) / 2
	global_position.y = start_y + d * bob_height


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.add_score(1)
		queue_free()
