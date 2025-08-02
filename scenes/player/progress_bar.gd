extends ProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if value <= max_value / 3:
		var Stylebox : StyleBoxFlat = get_theme_stylebox("fill")
		Stylebox.bg_color = Color("f98284")
	else:
		var Stylebox : StyleBoxFlat = get_theme_stylebox("fill")
		Stylebox.bg_color = Color("b3e3da")
