open Base
open Common

(* sig frame processing completed *)
type frame_done = unit

type match_start = unit

type round_freezetime_end = unit

type round_end_official = unit

type announcement_match_started = unit

type announcement_last_round_half = unit

type announcement_final_round = unit

type announcement_win_panel_match = unit

type hostage_resculed_all = unit

type round_end_reason =
	| StillInProgress
	| TargetBombed
	| VIPKilled
	| TerroristsEscaped
	| CTStoppedEscape
	| BombDefused
	| CTWin
	| TerroristsWin
	| Draw
	| HostagesRescued
	| TargetSaved
	| HostagesNotRescued
	| TerroristsNotEscaped
	| VIPNotEscaped
	| GameStart
	| CTSurrender
	| TerroristsSurrender
	| CTsReachedHostage
	| TerroristsPlanted

type round_mvp_reason =
	| MostEliminations
	| BombDefused
	| BombPlanted

(* indicates dem was sourced from player *)
type pov_recording_player_detected = {
	player_slot: int;
	player_info: player_info;
}

type round_freezetime_changed = {
	old_is_freezetime: bool;
	new_is_freezetime: bool;
}

type round_start = {
	time_limit: int;
	frag_limit: int;
	objective: string;
}

type round_end = {
	message: string;
	reason: round_end_reason;
	winner: team;
	winner_state: team_state option;
	loser_state: team_state option;
}

type round_mvp_announcement = {
	player: player option;
	reason: round_mvp_reason;
}

type player_team_change = {
	player: player option;
	old_team_state: team_stat option;
	new_team_state: team_state option;
	old_team: team;
	new_team: team;
	silent: bool;
	is_bot: bool;
}

type footstep = {
	player: player option;
}

type player_jump = {
	player: player option;
}

type player_sound = {
	player: player option;
	radius: int;
	duration: float;
}

type kill = {
	weapon: equipment option;
	victim: player option;
	killer: player option;
	assister: player option;
	penetrated_objects: int;
	is_headshot: bool;
	assisted_flash: bool;
	attacker_blind: bool;
	no_scope: bool;
	through_smoke: bool;
	distance: float;
}

let is_wallbang (k: kill) =
	k.penetrated_objects > 0

type bot_taken_over = {
	taker: player option;
}

type weapon_fire = {
	shooter: player option;
	weapon: equipment option;
}

type weapon_reload = {
	player: player option;
}

type grendae_event = {
	grenade_type: equipment_type;
	grenade: equipment option;
	position: vec3;
	thrower: player option;
	grenade_entity_id: int;
}

type he_explode = {
	grenade_event: grenade_event;
}

type flash_explode = {
	grenade_event: grenade_event;
}

type decoy_start = {
	grenade_event: grenade_event;
}

type decoy_expired = {
	grenade_event: grenade_event;
}

type smoke_start = {
	grenade_event: grenade_event;
}

type smoke_expired = {
	grenade_event: grenade_event;
}

type fire_grenade_start = {
	grenade_event: grenade_event;
}

type fire_grenade_expired = {
	grenade_event: grenade_event;
}

type grenade_projectile_bounce = {
	projectile: grenade_projectile;
	bounce_nr: int;
}

type grenade_projectile_throw = {
	projectile: grenade_projectile;
}

type grenade_projectile_destroy = {
	projectile: grenade_projectile;
}

type player_flashed = {
	player: player option;
	attacker: player option;
	projectile: grenade_projectile option;
}

type bomb_event = {
	player: player option;
	site: char;
}

type bomb_plant_begin = {
	bomb_event: bomb_event;
}

type bomb_plant_aborted = {
	bomb_event: bomb_event;
}

type bomb_planted = {
	bomb_event: bomb_event;
}

type bomb_defused = {
	bomb_event: bomb_event;
}

type bomb_explode = {
	bomb_event: bomb_event;
}

type bomb_defuse_start = {
	player: player option;
	has_kit: bool;
}

type bomb_defuse_aborted = {
	player: player option;
}

type bomb_dropped = {
	player: player option;
	entity_id: int;
}

type bomb_pickup = {
	player: player option;
}

type hostage_rescued = {
	player: player option;
	hostage: hostage option;
}

type hostage_hurt = {
	player: player option;
	hostage: hostage option;
}

type hostage_killed = {
	player: player option;
	hostage: hostage option;
}

type hostage_state_changed = {
	old_state: hostage_state;
	new_state: hostage_state;
	hostage: hostage option;
}
