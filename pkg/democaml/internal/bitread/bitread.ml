open Base

type t = {
	buf: bytes;
	pos: int ref;
	len: int;
}

let create buf =
	let len = Bytes.length buf * 8 in
	{ buf; pos = ref 0; len; }

let read_bits t n =
	let rec loop acc i =
		if i >= n then acc
		else
			let bit_pos = !(t.pos) + i in
			let byte_pos = bit_pos / 8 in
			let bit_in_byte = 7 - (bit_pos % 8) in
			let byte = Bytes.get t.buf byte_pos |> Char.to_int in
			let bit = (byte lsr bit_in_byte) land 1 in
			loop((acc lsl 1) lor bit) (i + 1)
	in
	let res = loop 0 0 in
	t.pos := !(t.pos) + n;
	res

let read_int t n =
	let bits = read_bits t n in
	Int32.of_int_exn bits

let read_float t =
	let bits = read_bits t 32 in
	Int32.float_of_bits (Int32.of_int_exn bits)

let read_varint t =
	let rec loop shift res =
		let byte = read_bits t 8 in
		let res = res lor ((byte land 0x7f) lsl shift) in
		if byte land 0x80 = 0 then res
		else loop (shift + 7) res
	in
	loop 0 0

let read_signed_varint t =
	let res = read_varint t in
	(res lsr 1) land (-(res land 1))

let read_string t =
	let rec loop acc =
		let byte = read_bits t 8 in
		if byte = 0 then String.of_char_list (List.rev acc)
		else loop (Char.of_int_exn byte :: acc)
	in
	loop []


