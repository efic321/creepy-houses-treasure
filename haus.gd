extends Node2D

func init():
	Signale.connect("baue",create_rooms)

func _ready():
	generate_house(6)  # Startposition und Anzahl der Räume

func generate_house(room_count: int):
	erzeuge_startraum()
	find_rooms($"Räume_Gebaut/Sackgasse1", "north", room_count)

func erzeuge_startraum():
	var start_raum = ($"Räume_Baublan/Sackgassen/Sackgasse1").duplicate()
	create_layer(start_raum)

func find_rooms(alt_room, direction, room_count):
	var alt_door = get_typ_door(alt_room, direction)
	var typ = oposide_door_type(alt_door.name)
	var position_room = alt_room.position + alt_door.position * 6
	Signale.emit_signal("scane")#, position_room.x, position_room.y, alt_room, room_count, alt_door, typ)
	#create_rooms(alt_room, room_count, alt_door, typ)


func create_rooms(alt_room, room_count, alt_door, typ):
	var room = randem_typ_room(typ, room_count).duplicate()
	create_layer(room)
	var door = get_typ_door(room, typ)
	room.position = alt_room.position + (alt_door.position - door.position) * 3
	for new_door in room.get_children():
		if not new_door == door and not new_door.name.begins_with("Wand"):
			room_count -= 1
			if not room_count <= 1:
				find_rooms(room, new_door.name, room_count)
			else:
				create_wall(room, new_door)

func create_layer(layer):
	$Räume_Gebaut.add_child(layer)
	layer.enabled = true

func create_wall(room, new_door):
	var wall = $"Räume_Baublan/Mauern".get_child(direction_nuber(new_door.name)).duplicate()
	room.add_child(wall)
	wall.enabled = true
	wall.position = new_door.position

func get_typ_door(room, typ):
	for door in room.get_children():
		if door is Marker2D and door.name == typ: return door
	
func fitting_door(room,typ):
	if get_typ_door(room,typ) == null:
		return false
	else:
		return true

func randem_typ_room(typ, room_count):
	var all_typ_rooms = $"Räume_Baublan/Räume".get_children().filter(func(room): return fitting_door(room, typ))
	if room_count <= 4:
		all_typ_rooms += $"Räume_Baublan/Sackgassen".get_children().filter(func(room): return fitting_door(room, typ))
	var zufalls_raum_zahl = randi_range(0, all_typ_rooms.size() - 1)		
	var anzubauender_raum:TileMapLayer = all_typ_rooms[zufalls_raum_zahl]
	return anzubauender_raum

func direction_nuber(direction):
	if direction == "south": return 0
	if direction == "east": return 1
	if direction == "north": return 2
	if direction == "west": return 3

func oposide_door_type(door):
	if door == "north": return "south"
	if door == "south": return "north"
	if door == "east": return "west"
	if door == "west": return "east"
