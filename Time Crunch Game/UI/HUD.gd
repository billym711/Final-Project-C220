extends Control

func _ready():
	Global.update_score(0)
	Global.update_lives(0)
	Global.update_time(0)
	Global.update_health(0)
	Global.update_damage(0)
	Global.update_weapon_upgrades(0)
	Global.update_armor(0)

func update_score():
	$Score.text = "Score: " + str(Global.score)

func update_time():
	$Time.text = "Time: " + str(Global.time)

func update_lives():
	$Lives.text = "Lives: " + str(Global.lives)
	
func update_health():
	$Health.text = "Health: " + str(Global.health)
	
func update_armor():
	$Armor.text = "Armor: " + str(Global.armor)

func update_weapon_upgrade():
	$Weapon_Upgrade.text = "Weapon Upgrades: " + str(Global.damage_upgrades)
	
func update_damage():
	$Damage.text = "Damage: " + str(Global.damage)
func _on_Timer_timeout():
	Global.update_time(-1)
