class_name TestLevel
extends Level

func _ready():
	super()
	MusicManager._get_all_songs()

func _process(_delta):
	if Input.is_action_just_pressed("play_song"):
			MusicManager.play_song_from_list()
