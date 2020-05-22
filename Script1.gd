extends Spatial

onready var master_node = get_node("/root/Spatial/Spatial1")
onready var viewport_node = get_node("/root/Spatial/Spatial1/Viewport")
onready var mesh_node = get_node("/root/Spatial/MeshInstance")

func _ready():

	# translate Spatial1 to new location
	master_node.set_translation(Vector3(100,0,0))

	# parent all nodes to Viewport node
	for N in master_node.get_children():
		# leave first node because it is a Viewport
			if N != master_node.get_child(0):
				var node = N
				master_node.remove_child(node)
				# translate also child nodes
				node.set_translation(master_node.get_translation())
				viewport_node.add_child(node)
				node.set_owner(viewport_node)

	# set viewport texturte to mesh node albedo
	mesh_node.get_surface_material(0).albedo_texture = viewport_node.get_texture()
