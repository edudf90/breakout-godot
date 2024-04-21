extends Control

const MARGIN_X = 15
const MARGIN_Y = 50

enum {UPPERCASE, LOWERCASE}

var keys
@export var max_field_size = 5
@export var allow_uppercase_letters = true
@export var allow_lowercase_letters = true
@export var allow_numbers = true
@export var key_square_size = 26
#@export var richText = false
#@export var confirmation_required = false
var keyboard_layout
var current_case

signal text_submitted


func _ready():
	keyboard_layout = KeyboardLayoutFactory.new().get_keyboard_layout( \
		allow_uppercase_letters, allow_lowercase_letters, allow_numbers)
	create_keys()
	if allow_uppercase_letters:
		current_case = UPPERCASE
	else:
		current_case = LOWERCASE

func _process(delta):
	var rows = keyboard_layout.rows
	var columns = keyboard_layout.columns
	var selector_row = int($Selector.position.y - MARGIN_Y) / key_square_size
	var selector_column = int($Selector.position.x - MARGIN_X) / key_square_size
	if Input.is_action_just_pressed("ui_right"):
		$Selector.position.x = MARGIN_X + key_square_size * posmod(selector_column + 1, columns)
	if Input.is_action_just_pressed("ui_left"):
		$Selector.position.x = MARGIN_X + key_square_size * posmod(selector_column - 1, columns)
	if Input.is_action_just_pressed("ui_up"):
		$Selector.position.y = MARGIN_Y + key_square_size * posmod(selector_row - 1, rows)
	if Input.is_action_just_pressed("ui_down"):
		$Selector.position.y = MARGIN_Y + key_square_size * posmod(selector_row + 1, rows)
	if Input.is_action_just_pressed("ui_accept"):
		if selector_row < keys.size() && selector_column < keys[selector_row].size():
			if keys[selector_row][selector_column] is Label:
				if $Field.text.length() < max_field_size:
					var selected_letter = keys[selector_row][selector_column].text
					$Field.text += selected_letter
			elif keys[selector_row][selector_column] == $OkSymbol:
				text_submitted.emit()
			elif keys[selector_row][selector_column] == $UppercaseSymbol:
				change_case()
	if Input.is_action_just_pressed("ui_text_backspace"):
		if $Field.text.length() > 0:
			$Field.text = $Field.text.left(-1)

func change_case():
	for row in keys:
		for item in row:
			if item is Label:
				if current_case == UPPERCASE:
					item.text = item.text.to_lower()
				else:
					item.text = item.text.to_upper()
	current_case = LOWERCASE if current_case == UPPERCASE else UPPERCASE

func create_keys():
	keys = Array()
	var count = 0
	var rows = keyboard_layout.rows
	var columns = keyboard_layout.columns
	for i in range(rows):
		keys.append(Array())
		for j in range(columns):
			var content = keyboard_layout.content[count]
			match (content):
				KeyboardLayout.EMPTY: 
					var label = create_label('', count, columns)
					keys[i].append(label)
					add_child(keys[i][j])
				KeyboardLayout.CHANGE_CASE: 
					$UppercaseSymbol.position.x = MARGIN_X + (count % columns) * key_square_size
					$UppercaseSymbol.position.y = MARGIN_Y + (count / columns) * key_square_size
					$UppercaseSymbol.visible = true
					keys[i].append($UppercaseSymbol)
				KeyboardLayout.OK: 
					$OkSymbol.position.x = MARGIN_X + (count % columns) * key_square_size
					$OkSymbol.position.y = MARGIN_Y + (count / columns) * key_square_size
					keys[i].append($OkSymbol)
				_:
					var label = create_label(content, count, columns)
					keys[i].append(label)
					add_child(keys[i][j])
			count += 1

func create_label(text, index, columns):
	var label = Label.new()
	label.text = text
	label.size.x = key_square_size
	label.size.y = key_square_size
	label.position.x = MARGIN_X + (index % columns) * key_square_size
	label.position.y = MARGIN_Y + (index / columns) * key_square_size
	label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	return label

