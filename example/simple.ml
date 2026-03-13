open Base
open Lwt
open Stdio
open Common
open Democaml

let () =
	print_endline "democaml example";

	let demo_path = "./vitality-vs-mongolz-m1-mirage.dem" in
	printf"parsing demo file: %s\n" demo_path;

	let ic = In_channel.create demo_path in
	let len = In_channel.length ic in
	let bytes = Bytes.create (Int64.to_int_exn len) in

	ignore (In_channel.really_input ic ~buf:bytes ~pos:0 ~len:(Int64.to_int_exn len) : unit option);

	In_channel.close ic;

	let reader = Bitread.create bytes in
	printf "header bytes: ";
	for i = 0 to 7 do
		let byte = Bytes.get bytes i in
		printf "%02x " (Char.to_int byte)
	done;
	printf "\n";

	let filestamp = Bitread.read_cstring reader 8 in
	printf "filestamp: %s\n" filestamp;

	let reader2 = Bitread.create bytes in
	for i = 0 to 7 do
		let byte = Bitread.read_bits reader2 8 in
		printf "%x02 " byte
	done;
	printf "\n";

	let reader = Bitread.create bytes in
	let cfg = { Parser.format = Parser.DemoFormatStandard; Parser.ignore_packet_entities_panic = false } in
	let parser = Parser.create reader cfg in

	match Parser.parse_header parser with
		| Ok header ->
			printf "filestamp: %s\n" header.filestamp;
			printf "parsed header\n";

			printf "parsing frames…\n";
			let frame_count = ref 0 in
			let rec parse_frames () =
				if Parser.parse_frame  parser then
					(Int.incr frame_count;
					 if Int.rem !frame_count 10000 = 0 then
						printf "parsed %d frames…\n" !frame_count;
					 parse_frames())
				else
				()
			in
			parse_frames ();
			printf "parsed %d frames.\n" !frame_count;
			printf "\n\ndem file processed\n"
		| Error exn ->
			printf "error parsing header/frames: %s\n" (Exn.to_string exn)


