open Base

type t = {
	buf: bytes;
	pos: int ref;
	len: int;
}
