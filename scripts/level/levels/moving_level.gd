class_name MovingLevel
extends Level

var camera: Camera2D

func _ready():
	super()
	camera = player.get_node("Camera2D")

func _process(delta: float) -> void:
	super(delta)
	constrain_player_to_camera()

func constrain_player_to_camera() -> void:
	if camera:
		var cameraLeft = camera.global_position.x - (camera.zoom.x * camera.get_viewport_rect().size.x / 2)
		var cameraRight = camera.global_position.x + (camera.zoom.x * camera.get_viewport_rect().size.x / 2)
		var playerPosition = player.global_position

		if player.global_position.x < cameraLeft:
			EventManager.emit_signal("player_died")
			camera.set_restart_position()
		elif player.global_position.x > cameraRight:
			playerPosition.x = cameraRight

		player.global_position = playerPosition
