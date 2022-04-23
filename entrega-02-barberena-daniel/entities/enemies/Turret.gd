extends Sprite

export (PackedScene) var projectile_scene:PackedScene

var rng = RandomNumberGenerator.new()
var projectile_container:Node
var fire_position:Position2D
var player

func _ready():
	fire_position = $FirePosition
	rng.randomize()
	self.global_position.x = rng.randf_range(20, ProjectSettings.get_setting("display/window/size/width") - 20)
	self.global_position.y = rng.randf_range(30, 300)


func set_values(player, container):
	self.player = player
	self.projectile_container = container
	$Timer.start()

func _on_Timer_timeout():
	fire()

func fire():
	var projectile:Projectile = projectile_scene.instance()
	projectile_container.add_child(projectile)
	projectile.set_starting_values(fire_position.global_position, (player.global_position - fire_position.global_position).normalized())
	projectile.connect("delete_requested", self, "_on_projectile_delete_requested")

func _on_projectile_delete_requested(projectile):
	projectile_container.remove_child(projectile)
	projectile.queue_free()
