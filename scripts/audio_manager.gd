extends Node2D

class_name AudioManager

@export var polyphonic_sound_effect_player: AudioStreamPlayer2D
@export var audio_library: AudioLibrary

enum Channel { BASS_ACTIVE, GUITAR_ACTIVE, PAINO_ACTIVE, VIOLINS_ACTIVE, TRUMPETS_ACTIVE, KAZOO_ACTIVE }


func _ready():
	polyphonic_sound_effect_player.stream = AudioStreamPolyphonic.new()
	polyphonic_sound_effect_player.stream.polyphony = 32

# call this function to play sound effects!
func play_sound_effect(_tag: String) -> void:
	if _tag:
		var audio_stream = audio_library.get_audio_stream(_tag)
		if !polyphonic_sound_effect_player.playing:
			polyphonic_sound_effect_player.play()
		var polyphonic_stream_playback := polyphonic_sound_effect_player.get_stream_playback()
		polyphonic_stream_playback.play_stream(audio_stream)
	else:
		printerr("no tag provided --- cannot play sound effect!")
	
var bass_active: bool = false
var guitar_active: bool = false
var piano_active: bool = false
var violins_active: bool = false
var trumpts_active: bool = false
var kazoo_active: bool = false

# for testing - control the separate audio tracks w/ number keys
func _input(event):
	# sound effects:
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		#play_sound_effect("ui_select")
	#if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		#play_sound_effect("ui_undo")
		
	# music tracks:
	if Input.is_key_pressed(KEY_1):
		bass_active = !bass_active
		print("bass track: %s" % [bass_active])
	if Input.is_key_pressed(KEY_2):
		guitar_active = !guitar_active
		print("guitar track: %s" % [guitar_active])
	if Input.is_key_pressed(KEY_3):
		piano_active = !piano_active
		print("piano track: %s" % [piano_active])
	if Input.is_key_pressed(KEY_4):
		violins_active = !violins_active
		print("violins track: %s" % [violins_active])
	if Input.is_key_pressed(KEY_5):
		trumpts_active = !trumpts_active
		print("trumpets track: %s" % [trumpts_active])
	if Input.is_key_pressed(KEY_6):
		kazoo_active = !kazoo_active
		print("kazoo track: %s" % [kazoo_active])
	update_audio_busses()
		
func update_audio_busses():
	# bass bus
	var bass_index = AudioServer.get_bus_index("BassBus")
	AudioServer.set_bus_volume_db(bass_index, 0.0 if bass_active else -80.0)
	# bass bus
	var guitar_index = AudioServer.get_bus_index("GuitarBus")
	AudioServer.set_bus_volume_db(guitar_index, 0.0 if guitar_active else -80.0)
	# piano bus
	var piano_index = AudioServer.get_bus_index("PianoBus")
	AudioServer.set_bus_volume_db(piano_index, 0.0 if piano_active else -80.0)
	# violins bus
	var violins_index = AudioServer.get_bus_index("ViolinsBus")
	AudioServer.set_bus_volume_db(violins_index, 0.0 if violins_active else -80.0)
	# trumpets bus
	var trumpets_index = AudioServer.get_bus_index("TrumpetsBus")
	AudioServer.set_bus_volume_db(trumpets_index, 0.0 if trumpts_active else -80.0)
	# kazoo bus
	var kazoo_index = AudioServer.get_bus_index("KazooBus")
	AudioServer.set_bus_volume_db(kazoo_index, 0.0 if kazoo_active else -80.0)
