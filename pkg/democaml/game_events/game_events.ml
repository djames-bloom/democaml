open Base
open Common
open Events

type game_event_value =
	| Int of int
	| Float of float
	| String of string
	| Bool of bool

type game_event_data = (string, game_event_value) Hashtbl.t

type game_event_handler_func = game_event_data -> unit

type parser

type game_event_handler = {
	parser: parser;
	game_event_name_to_handler: (string, game_event_handler_func option) Hashtbl.t;
	mutable delayed_event_handlers: (unit -> unit) list;
}

let create_game_event_handler (parser: parser) : game_event_handler =
	let handler = {
		parser;
		delayed_event_handlers = [];
		game_event_name_to_handler = Hashtbl.create (module String);
	} in
	Hashtbl.set handler.game_event_name_to_handler ~key:"player_death"	~data:(Some (fun _ -> ()));
	Hashtbl.set handler.game_event_name_to_handler ~key:"player_hurt"	~data:(Some (fun _ -> ()));
	Hashtbl.set handler.game_event_name_to_handler ~key:"weapon_fire"	~data:(Some (fun _ -> ()));
	Hashtbl.set handler.game_event_name_to_handler ~key:"round_start"	~data:(Some (fun _ -> ()));
	Hashtbl.set handler.game_event_name_to_handler ~key:"round_end" 	~data:(Some (fun _ -> ()));
	handler

let handle_game_event_list (parser: parser) (gel: game_event_data) : unit =
	() (* todo *)

let handle_game_event (parser: parser) (ge: game_event_data) : unit =
	() (* todo *)
