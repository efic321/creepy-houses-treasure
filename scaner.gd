extends Area2D

func init():
	Signale.connect("scane",on_scane)

func on_scane():#position_room_x, position_room_y, alt_room, room_count, alt_door, typ):
	print("ja")
	#Signale.emit_signal("buld", alt_room, room_count, alt_door, typ)
	#position.x = position_room_x
	#position.y = position_room_y
	var bodies = get_overlapping_bodies()
	#for body in bodies:
	#	if body is TileMapLayer:
	#		$Signale.emit_signal("buld",alt_room, room_count, alt_door, typ)#true)
	#$Signale.emit_signal("buld", alt_room, room_count, alt_door, typ)#false)
