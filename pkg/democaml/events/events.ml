open Base
open Common

(* sig frame processing completed *)
type frame_done = unit

type match_start = unit

type round_freezetime_end = unit

type round_end_official = unit

type announcement_match_started = unit

type announcemnet_last_round_half = unit

type announcement_final_round = unit

type announcement_win_panel_match = unit

type round_end_reason =
	| StillInProgress
	| TargetBombed
	| VIPKilled
	| TerroristsEscaped
	| CTStoppedEscape
	| BombDefused
	| CTWin
	| TerroristsWin
	| Draw
	| HostagesRescued
	| TargetSaved
	| HostagesNotRescued
	| TerroristsNotEscaped
	| VIPNotEscaped
	| GameStart
	| CTSurrender
	| TerroristsSurrender
	| CTsReachedHostage
	| TerroristsPlanted

type round_mvp_reason =
	| MostEliminations
	| BombDefused
	| BombPlanted

(* indicates dem was sourced from player *)
type pov_recording_player_detected = {
	player_slot: int;
	player_info: player_info;
}

type round_freezetime_changed = {
	old_is_freezetime: bool;
	new_is_freezetime: bool;
}

type round_start = {
	time_limit: int;
	frag_limit: int;
	objective: string;
}

type round_end = {
	message: string;
	reason: round_end_reason;
	winner: team;
	winner_state: team_state option;
	loser_state: team_state option;
}

type round_mvp_announcement = {
	player: player option;
	reason: round_mvp_reason;
}
