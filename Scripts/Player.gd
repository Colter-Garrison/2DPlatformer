extends CharacterBody2D

var move_speed : float = 100.0
var jump_force : float = 200.0
var gravity : float = 500.0
var score : int = 0
@onready var score_text : Label = get_node("CanvasLayer/ScoreText")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	var direction = 0
	
	if Input.is_action_pressed("left"):
		direction -= 1
	if Input.is_action_pressed("right"):
		direction += 1
	
	if direction != 0 and is_on_floor():
		$Sprite.animation = "walk"
		$Sprite.flip_h = direction < 0
	else:
		if is_on_floor():
			$Sprite.animation = "idle"
	
	velocity.x = move_speed * direction
	
	if Input.is_action_pressed("jump") and is_on_floor():
		$Jump.play()
		$Sprite.animation = "jump"
		velocity.y = -jump_force
	
	move_and_slide()
	
	if global_position.y > 100:
		game_over()

func game_over():
	get_tree().reload_current_scene()

func add_score(amount):
	score += amount
	score_text.text = str("score: ", score)
