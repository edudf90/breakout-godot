class_name KeyboardLayoutFactory

func get_keyboard_layout(allow_uppercase_letters, allow_lowercase_letters, allow_numbers):
	var numbers_only = !allow_uppercase_letters && !allow_lowercase_letters && allow_numbers
	var case_sensetive = allow_uppercase_letters && allow_lowercase_letters
	var content = []
	if numbers_only:
		content = ['1', '2', '3', \
					'4', '5', '6', \
					'7', '8', '9', \
					KeyboardLayout.EMPTY, '0', KeyboardLayout.OK]
		return create_keyboard_layout(4, 4, content)
	var rows = 3
	if allow_numbers:
		content = content + ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0']
		rows = 4
	if allow_uppercase_letters:
		content = content + \
			['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', \
			'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', \
			'U', 'V', 'W', 'X', 'Y', 'Z', KeyboardLayout.EMPTY, KeyboardLayout.EMPTY]
	else:
		content = content + \
			['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', \
			'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', \
			'u', 'v', 'w', 'x', 'y', 'z', KeyboardLayout.EMPTY, KeyboardLayout.EMPTY]
	if case_sensetive:
		content = content + [KeyboardLayout.CHANGE_CASE]
	else:
		content = content + [KeyboardLayout.EMPTY]
	content = content + [KeyboardLayout.OK]
	return create_keyboard_layout(rows, 10, content)

func create_keyboard_layout(rows, columns, content):
	var layout = KeyboardLayout.new()
	layout.rows = rows
	layout.columns = columns
	layout.content = content
	return layout

