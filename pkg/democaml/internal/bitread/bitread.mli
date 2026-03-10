	type t

	val create : bytes -> t
	val read_bits : t -> int -> int
	val read_int : t -> int -> Int32.t
	val read_float : t -> float
	val read_varint : t -> int
	val read_varint32 : t -> int
	val read_signed_varint : t -> int
	val read_string : t -> string
	val read_bits_as_int64 : t -> int -> Int64.t
	val read_cstring : t -> int -> string
	val read_bytes : t -> int -> bytes
	val skip_bits : t -> int -> unit

