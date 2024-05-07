extends MarginContainer

func _ready():
	for item in $"%Items".get_children():
		item.get_node("%Icon").hide()

func set_item(i, n):
	$"%Items".get_child(i).get_node("%Icon").show()
	$"%Items".get_child(i).get_node("%Qty").text = str(n)

func _on_close_pressed():
	hide()
