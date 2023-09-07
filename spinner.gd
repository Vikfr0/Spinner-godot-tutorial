extends RigidBody2D

var last_angle := 0.0
var spinsLabel: Label

func _ready():
	spinsLabel = %SpinSpeedLabel

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			return
			
		# note: by convention y position is first
		last_angle = atan2(event.position.y, event.position.x) 
	
func _process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		var mouse_position = get_local_mouse_position()

		var angle = atan2(mouse_position.y, mouse_position.x) 
		var delta_angle = angle - last_angle

		if delta_angle > deg_to_rad(180):
			last_angle += deg_to_rad(360)
			delta_angle -= deg_to_rad(360)
		elif -delta_angle > deg_to_rad(180):
			last_angle -= deg_to_rad(360)
			delta_angle += deg_to_rad(360)
		
		apply_torque(delta_angle * 100)

		last_angle = angle
		
	spinsLabel.set_text("Spinning speed: %.2f " % angular_velocity)
