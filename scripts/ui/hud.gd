extends Control

@onready var songLabel: Label = $SongLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	EventManager.play_next_song.connect(change_song_label)

func change_song_label(songName: String):
	songLabel.text = songName
