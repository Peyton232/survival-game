extends CharacterBody2D


var speed = 100

var player_state
var last_direction = "s"

func _physics_process(_delta):
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	play_animation(direction)

func play_animation(dir):
	
	if player_state == "idle":
		var facing = last_direction + "_idle"
		$AnimatedSprite2D.play(facing)
		return
		
	# Find the direction the player is facing
	var facing = ""
	
	# Check the Y-axis direction
	if dir.y < -0.5:
		facing += "n"
	elif dir.y > 0.5:
		facing += "s"
		
	# Check the X-axis direction
	if dir.x < -0.5:
		facing += "w"
	elif dir.x > 0.5:
		facing += "e"
		
	# If new direction then record that
	if facing != "":
		last_direction = facing
	
	if player_state == "walking":
		facing += "_walk"
		$AnimatedSprite2D.play(facing)
