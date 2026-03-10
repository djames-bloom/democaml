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
	val parse_header : parser -> (header, exn) Result.t
