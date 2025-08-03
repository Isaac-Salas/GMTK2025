extends AudioStreamPlayer
class_name MusicComponent
@export var songvolume : float = -5.0
var fade_audio : Tween
const BURN_THE_WORLD_WALTZ_ = preload("res://assets/Music/Burn The World Waltz .mp3")
const EVENING = preload("res://assets/Music/Evening.mp3")
const MORNING = preload("res://assets/Music/Morning.mp3")

func _ready() -> void:
	if stream != null:
		startplay(stream,0.0,1.0,-80.0)
		fade(songvolume, 1.0)


func set_speed(speed : float):
	pitch_scale = speed

func startplay(song = stream, position : float = 0.0, play_speed : int = 1, vol_override : float = songvolume):
	seek(position)
	pitch_scale = play_speed
	stream = song
	volume_db = vol_override
	bus = "Music"
	play(0.0)
	
func fade(volume_override : float = songvolume, duration : float = 1.5):
	reset_tween()
	fade_audio.tween_property(self, "volume_db", volume_override, duration)

func reset_tween():
	if fade_audio:
		fade_audio.kill()
	fade_audio = create_tween()


func _on_finished() -> void:
	startplay()
