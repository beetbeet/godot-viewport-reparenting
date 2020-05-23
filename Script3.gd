extends Spatial

onready var master_node = get_node("/root/Spatial/Spatial1")
# onready var viewport_node = get_node("/root/Spatial/Spatial1/Viewport")
onready var mesh_node = get_node("/root/Spatial/MeshInstance")

func _ready():

	# translate Spatial1 to new location
	master_node.set_translation(Vector3(100,0,0))

	# create Viewport
	var vnode = Viewport.new()
	vnode.set_name("Viewport")
	get_node("/root/Spatial/Spatial1").add_child(vnode)
	vnode.set_owner(get_node("/root/Spatial/Spatial1"))

	# change order of childs
	master_node.move_child(vnode, 0)

	# set size of viewport
	vnode.size = Vector2(100,100)


	# parent all nodes to Viewport node
	for N in master_node.get_children():
		# leave first node because it is a Viewport
			if N != master_node.get_child(0):
				var node = N
				master_node.remove_child(node)
				# translate also child nodes
				node.set_translation(master_node.get_translation())
				vnode.add_child(node)
				node.set_owner(vnode)


	# set viewport texturte to mesh node albedo
	mesh_node.get_surface_material(0).albedo_texture = vnode.get_texture()
	# update viewport path
	mesh_node.get_surface_material(0).albedo_texture.set_viewport_path_in_scene("/root/Spatial/Spatial1/Viewport")

	print_tree()

	print(save_scene())

func save_scene():
	var packed_scene = PackedScene.new()
	packed_scene.pack(get_tree().get_current_scene())
	ResourceSaver.save("res://my_generated_scene.tscn", packed_scene)
