extends StaticBody2D
var scroll_speed = 30
var dead = false

func _ready():
	constant_linear_velocity.x = 500
	pass
	
func _physics_process(delta):
	if dead && scroll_speed > 0:
		scroll_speed -= 10*delta
		position.x -= (scroll_speed)/(delta*800)
		return
	position.x -= (scroll_speed)/(delta*800)
	
func stop():
	dead = true
			
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free() # Replace with function body.
