open Base
open Common

type parser_config = {
	format: demo_format;
	ignore_packet_entities_panic: bool;
}

and demo_format =
	| DemoFormatStandard
	| DemoFormatCSTVBroadcast

type parser

	val create : Bitread.t -> parser_config -> parser

	(* validate type and construct header struct *)
	val parse_header : parser -> (header, exn) Result.t

	(* parse all frames until end *)
	val parse_to_end : parser -> (unit, exn) Result.t

