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

