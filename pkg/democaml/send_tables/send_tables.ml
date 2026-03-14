open Base
open Common

type property_value_type =
	| ValTypeInt
	| ValTypeFloat32
	| ValTypeFloat64
	| ValTypeString
	| ValTypeVector
	| ValTypeArray
	| ValTypeBoolInt

type property_value =
	| Int of int
	| Float of float
	| String of string
	| Vector of vec3
	| Array of property_value list
	| Bool of bool

type property = {
	name: string;
	mutable value: property_value;
	on_update: (property_value -> unit) list;
}

type server_class = {
	name: string;
	id: int;
}

type entity = {
	id: int;
	serial: int;
	server_class: server_class;
	active: bool;
	properties: (string, property) Hashtbl.t;
}

let get_property (entity: entity) (name: string) : property_value option =
	match Hashtbl.find entity.properties name with
	| Some prop -> Some prop.value
	| None -> None

let create_entity (id: int) (serial: int) (server_class: server_class) : entity = {
	id;
	serial;
	server_class;
	active = true;
	properties = Hashtbl.create (module String);
}
