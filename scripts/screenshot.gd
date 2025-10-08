extends Node

func _input(event):
	if event.is_action_pressed("ui_screenshot"):
		take_screenshot()

func take_screenshot():
	await get_tree().process_frame

	var viewport := get_viewport()
	var texture := viewport.get_texture()

	if texture == null:
		push_error("Viewport texture is null! Cannot take screenshot.")
		return

	var image := texture.get_image()

	if image == null:
		push_error("Image capture failed — viewport may not be ready.")
		return

	# Sanitize filename — remove ":" from time string (Windows doesn't allow it)
	var timestamp := Time.get_datetime_string_from_system().replace(":", "-")
	var filename := "user://screenshot_%s.png" % timestamp

	var result := image.save_png(filename)

	if result == OK:
		print("✅ Screenshot saved to:", filename)
	else:
		push_error("❌ Failed to save screenshot. Error code: %s" % str(result))
