extends Area2D
signal die
signal score
var GRAVITY
var screen_size
var velocity= Vector2.ZERO
var MAX_VELOCITY = 10
var LIFT = -5
var flying = false
var dead = false

func _ready():
	flying = false
	dead = false
	GRAVITY = 0
	var screen_size = get_viewport_rect().size
	print(screen_size)

func new_game():
	$AnimatedSprite2D.rotation = 0
	flying =false
	dead =false
	velocity = Vector2.ZERO
	GRAVITY = 0
	
func _process(delta):
	if Input.is_action_just_pressed("fly") && !dead:
		if abs(velocity.y) > MAX_VELOCITY:
			velocity.y = -MAX_VELOCITY
		else:
			velocity.y = LIFT
		flying = true
	if flying:
		GRAVITY = 9
	else: GRAVITY = 0
	
	velocity.y += GRAVITY * delta
	position.y += velocity.y
	
#clamp to screen size
	if position.y > 600:
		position.y = 600
	elif position.y < 0:
		position.y = 0
	#print(position)

#pataas na ikot
	if velocity.y < 0:
		$AnimatedSprite2D.rotation = deg_to_rad(velocity.y*10)
#pababa na ikot
	elif velocity.y > 0 && position.y < 600:
		$AnimatedSprite2D.rotation = deg_to_rad(velocity.y*9)
	
	if position.y < 600 && !dead:
		$AnimatedSprite2D.animation = "default"
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

func kill():
	$AnimatedSprite2D.rotation = deg_to_rad(90)
	$AnimatedSprite2D.animation = "dead"
	$AnimatedSprite2D.play()
	print("entered")
	dead =true
	$blood.emitting = true
	
func audio(mus):
	if mus == "coin":
		$sound_coin.play()

func add_score():
	score.emit()
	print("Scored")
		
func _on_body_entered(body):
	if body.name.begins_with("scorer"):
		score.emit()
	if body.name.begins_with("pipe"):
		die.emit()
		kill()
		

