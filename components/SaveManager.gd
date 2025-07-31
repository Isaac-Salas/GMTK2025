extends Node


var Habilidad1 : bool = false
var Ardilla1_1 : bool = false
var Ardilla1_2: bool = false
var Ardilla1_3 : bool = false
var Chicle1_1: bool = false
var Chicle1_2 : bool = false
var Chicle1_3 : bool = false
var Buff1: bool = false

var Habilidad2 : bool = false
var Ardilla2_1 : bool = false
var Ardilla2_2: bool = false
var Ardilla2_3 : bool = false
var Chicle2_1: bool = false
var Chicle2_2 : bool = false
var Chicle2_3 : bool = false
var Buff2: bool = false

var Habilidad3 : bool = false
var Ardilla3_1 : bool = false
var Ardilla3_2: bool = false
var Ardilla3_3 : bool = false
var Chicle3_1: bool = false
var Chicle3_2 : bool = false
var Chicle3_3 : bool = false
var Buff3: bool = false

var Habilidad4 : bool = false
var Ardilla4_1 : bool = false
var Ardilla4_2: bool = false
var Ardilla4_3 : bool = false
var Chicle4_1: bool = false
var Chicle4_2 : bool = false
var Chicle4_3 : bool = false
var Buff4: bool = false



var save_dict : Dictionary


func setter(variabletoset : String, value ):
	var temp = get(variabletoset)
	temp = value
	set(variabletoset, temp)
	print("Setting ", variabletoset, " to: ", value)

func save():
	save_dict = {
		"Habilidad1" : Habilidad1,
		"Ardilla1_1" : Ardilla1_1,
		"Ardilla1_2" : Ardilla1_2,
		"Ardilla1_3" : Ardilla1_3,
		"Chicle1_1" : Chicle1_1,
		"Chicle1_2" : Chicle1_2,
		"Chicle1_3" : Chicle1_3,
		"Buff1" : Buff1,
		
		"Habilidad2" : Habilidad2,
		"Ardilla2_1" : Ardilla2_1,
		"Ardilla2_2" : Ardilla2_2,
		"Ardilla2_3" : Ardilla2_3,
		"Chicle2_1" : Chicle2_1,
		"Chicle2_2" : Chicle2_2,
		"Chicle2_3" : Chicle2_3,
		"Buff2" : Buff2,
	
		"Habilidad3" : Habilidad3,
		"Ardilla3_1" : Ardilla3_1,
		"Ardilla3_2" : Ardilla3_2,
		"Ardilla3_3" : Ardilla3_3,
		"Chicle3_1" : Chicle3_1,
		"Chicle3_2" : Chicle3_2,
		"Chicle3_3" : Chicle3_3,
		"Buff3" : Buff3,
		
		"Habilidad4" : Habilidad4,
		"Ardilla4_1" : Ardilla4_1,
		"Ardilla4_2" : Ardilla4_2,
		"Ardilla4_3" : Ardilla4_3,
		"Chicle4_1" : Chicle4_1,
		"Chicle4_2" : Chicle4_2,
		"Chicle4_3" : Chicle4_3,
		"Buff4" : Buff4
		
	}
	return save_dict

func reset_progress():
	var savefile = save()
	for i in savefile:
		if i == "Firsttime" or i == "Level1_1t":
			set(i, true)
		else:
			set(i, false)
	save_game()

func save_game():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var data = save()
	var json_string = JSON.stringify(data)
	save_file.store_line(json_string)
	print(save_file)
	

func load_game():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.


	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	print(save_file)
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON.
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure.
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object.
		var node_data = json.data

		# Firstly, we need to create the object and add it to the tree and set its position.
	
		# Now we set the remaining variables.
		for i in node_data.keys():
			set(i, node_data[i])
