open Base
open Common
open Sendtables

type game_state = {
	mutable ingame_tick: int;
	mutable t_state: team_state;
	mutable ct_state: team_state;
	mutable total_rounds_played: int;
	mutable game_phase: game_phase;
	mutable is_warmup_period: bool;
	mutable is_freezetime: bool;
	mutable is_match_started: bool;
	mutable overtime_count: int;
	mutable current_defuser: player option;
	mutable current_planter: player option;
	players_by_user_id: (int, player) Hashtbl.t;
	players_by_entity_id: (int, player) Hashtbl.t;
	players_by_steam_id_32: (int32, player) Hashtbl.t;
	grenade_projectiles: (int, grenade_projectile) Hashtbl.t;
	infernos: (int, inferno) Hashtbl.t;
	weapons: (int, equipment) Hashtbl.t;
	hostages: (int, hostage) Hashtbl.t;
    entities: (int, Send_tables.entity) Hashtbl.t;
}

let create () : game_state = {
	ingame_tick = 0;
	t_state = { score = 0; clan_name = "" };
	ct_state = { score = 0; clan_name = "" };
	players_by_user_id = Hashtbl.create (module Int);
	players_by_entity_id = Hashtbl.create (module Int);
	players_by_steam_id_32 = Hashtbl.create (module Int32);
	grenade_projectiles = Hashtbl.create (module Int);
	infernos = Hashtbl.create (module Int);
	weapons = Hashtbl.create (module Int);
	hostages = Hashtbl.create (module Int);
	entities = Hashtbl.create (module Int);
	total_rounds_played = 0;
	overtime_count = 0;
	game_phase = GamePhaseStart;
	is_warmup_period = false;
	is_freezetime = false;
	is_match_started = false;
	current_defuser = None;
	current_planter = None;
}

let get_player_by_user_id (gs: game_state) (user_id: int) : player option =
	Hashtbl.find gs.players_by_user_id user_id

let get_player_by_entity_id (gs: game_state) (entity_id: int) : player option =
	Hashtbl.find gs.players_by_entity_id entity_id

let get_entity (gs: game_state) (entity_id: int) : Send_tables.entity option =
	Hashtbl.find gs.entities entity_id

let set_entity (gs: game_state) (entity_id: int) (entity: Send_tables.entity) : unit =
	Hashtbl.set gs.entities ~key:entity_id ~data:entity

let remove_entity (gs: game_state) (entity_id: int) : unit =
	Hashtbl.remove gs.entities entity_id

let get_all_players (gs: game_state) : player list =
	Hashtbl.data gs.players_by_user_id

(* util: ignore observers *)
let get_playing_players (gs: game_state) : player list =
	get_all_players gs
	|> List.filter ~f:(fun p ->
		match p.team with
		| TeamTerrorists | TeamCounterTerrorists -> true
		| _ -> false)

let get_ingame_tick (gs: game_state) : int =
	gs.ingame_tick

let set_ingame_tick (gs: game_state) (tick: int) : unit =
	gs.ingame_tick <- tick


