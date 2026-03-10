open Base

type vec3 = { x: float; y: float; z: float; }

type team =
	| TeamUnassigned
	| TeamSpectators
	(* cs2 specific teams *)
	| TeamTerrorists
	| TeamCounterTerrorists

(* cs2 specific items *)
type equipment_type =
	| EqUnknown
	| EqWeapon
	| EqGrenade
	| EqBomb
	| EqDefuseKit
	| EqKnife
	(* TODO: complete list *)

type game_phase =
	| GamePhaseStart
	| GamePhaseLive
	| GamePhaseGameOver
	| GamePhaseTeamSwitch
	| GamePhaseHalftime
	| GamePhaseWaitingForPlayers
	| GamePhaseWarmup
	| GamePhasePostGame

type hostage_state =
	| HostageStateUninitialized
	| HostageStateIdle
	| HostageStateBeingGrabbed
	| HostageStateFollowing
	| HostageStateGettingDropped
	| HostageStateMovingToDestination
	| HostageStateReachedDestination
	| HostageStateRescused
	| HostageStateDead

type player = {
	steam_id: int64;
	user_id: int;
	name: string;
	inventory: equipment list;
	entity_id: int;
	flash_duration: float;
	flash_tick: int;
	team: team;
	is_bot: bool;
	is_connected: bool;
	is_defusing: bool;
	is_planting: bool;
	is_reloading: bool;
	is_unknown: bool;
	buttons_pressed_state: int64;
}

type team_state = {
	score: int;
	clan_name: string;
}

type player_info = {
	name: string;
	steam_id: int64;
	user_id: int;
}

type equipment = {
	equipment_type: equipment_type;
	owner: player option;
}

type hostage = {
	entity_id: int;
	position: vec3;
	state: hostage_state;
}

(* mollo *)
type inferno = {
	entity_id: int;
	vertices: vec3 list;
}

type grenade_projectile = {
	entity_id: int;
	thrower: player option;
	position: vec3;
	velocity: vec3;
	grenade_type: equipment_type;
}

type bombsite = {
	index: int;
	center: vec3;
}

(* demofile leader *)
type header = {
	filestamp: string;
	network_protocol: int;
	server_name: string;
	client_name: string;
	map_name: string;
	game_directory: string;
	playback_time: float;
	playback_ticks: int;
	playback_frames: int;
}

let header_frame_rate h =
	if Base.Float.equal h.playback_time 0.0 then 0.0
	else Base.Float.of_int h.playback_frames /. h.playback_time

let header_frame_time h =
	if h.playback_frames = 0 then 0.0
	else h.playback_time /. Base.Float.of_int h.playback_frames
