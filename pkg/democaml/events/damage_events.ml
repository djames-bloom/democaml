open Base
open Common

type hit_group =
	| Generic
	| Head
	| Chest
	| Stomach
	| LeftArm
	| RightArm
	| LeftLeg
	| RightLeg
	| Neck
	| Gear

type bullet_damage = {
	attacker: player option;
	victim: player option;
	distance: float;
	damage_dir_x: float;
	damage_dir_y: float;
	damage_dir_z: float;
	num_penetrations: int;
	is_no_scope: bool;
	is_attacker_in_air: bool;
}

type player_hurt = {
	player: player option;
	attacker: player option;
	health: int;
	armor: int;
	weapon: equipment option;
	weapon_string: string;
	health_damage: int;
	armor_damage: int;
	health_damage_taken: int;
	armor_damage_taken: int;
	hit_group: hit_group;
}
