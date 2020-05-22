extends Spatial

onready var viewport_node = get_node("/root/Spatial/Spatial1/Viewport")
onready var mesh_node = get_node("/root/Spatial/MeshInstance")

func _ready():
	# set viewport texturte to mesh node albedo
	mesh_node.get_surface_material(0).albedo_texture = viewport_node.get_texture()