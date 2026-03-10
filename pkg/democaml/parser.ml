open Base
open Lwt
open Common
open Send_tables
open Bitread

type demo_command =
	| DEM_Error
	| DEM_Stop
	| DEM_FileHeader
	| DEM_FileInfo
	| DEM_SyncTick
	| DEM_SendTables
	| DEM_ClassInfo
	| DEM_StringTables
	| DEM_Packet
	| DEM_SignonPacket
	| DEM_ConsoleCmd
	| DEM_CustomCmd
	| DEM_CustomData
	| DEM_CustomDataCallbacks
	| DEM_UserCmd
	| DEM_FullPacket
	| DEM_SaveGame
	| DEM_SpawnGroups
	| DEM_AnimationData
	| DEM_AnimationHeader
	| DEM_Recovery
	| DEM_Max
	| DEM_IsCompressed

let demo_command_of_int = function
	| -1 -> DEM_Error
	| 0  -> DEM_Stop
	| 1  -> DEM_FileHeader
	| 2  -> DEM_FileInfo
	| 3  -> DEM_SyncTick
	| 4  -> DEM_SendTables
	| 5  -> DEM_ClassInfo
	| 6  -> DEM_StringTables
	| 7  -> DEM_Packet
	| 8  -> DEM_SignonPacket
	| 9  -> DEM_ConsoleCmd
	| 10 -> DEM_CustomData
	| 11 -> DEM_CustomDataCallbacks
	| 12 -> DEM_UserCmd
	| 13 -> DEM_FullPacket
	| 14 -> DEM_SaveGame
	| 15 -> DEM_SpawnGroups
	| 16 -> DEM_AnimationData
	| 17 -> DEM_AnimationHeader
	| 18 -> DEM_Recovery
	| 19 -> DEM_Max
	| 64 -> DEM_IsCompressed
	| _  -> DEM_Error

type parser_config = {
	format: demo_format;
	ignore_packet_entities_panic: bool;
}

and demo_format =
	| DemoFormatStandard
	| DemoFormatCSTVBroadcast

type parser = {
	config: parser_config;
	current_frame: int;
	tick_interval: float;
	bit_reader: Bitread.t;
	mutable header: header option;
	mutable entities: (int, entity) Hashtbl.t;
	mutable err: exn option;
}

let create (reader: Bitread.t) (config: parser_config) : parser =
	{
		config;
		bit_reader = reader;
		current_frame = 0;
		tick_interval = 0.0;
		header = None;
		entities = Hashtbl.create (module Int);
		err = None;
	}
