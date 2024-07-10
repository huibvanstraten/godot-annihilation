extends Node

signal level(levelId: int)

signal freeze_player(freeze: bool)
signal player_died
signal health_depleted(entity: CharacterBody2D)
signal entity_hit(entity: CharacterBody2D)
signal play_next_song(songName: String)
signal remove_attack_body
signal interact(canInteract: bool)
