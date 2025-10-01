extends Node2D
const SPEED = 60
@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var tilemap = %MainTileMap

var direction = 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
	position.x += direction * SPEED * delta
	

	var tile = tilemap.local_to_map(position)
	tile.y += 1
	tile.x -= 1
	var tiledataleft = tilemap.get_cell_tile_data(tile)
	if tiledataleft == null:
		direction = 1
		animated_sprite.flip_h = false
		
	tile.x += 2 # check other edge
	tiledataleft = tilemap.get_cell_tile_data(tile)
	if tiledataleft == null:
		direction = -1
		animated_sprite.flip_h = true
