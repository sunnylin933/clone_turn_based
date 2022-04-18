/// @description Insert description here
// You can write your code in this editor

increment = 0;

enum states
{
	shuffling,
	dealing,
	choosing,
	responding,
	clearing,
	restocking,
	
}

global.current_state = states.shuffling
global.swapped_type_initial = spr_scissor;


//dealing
delay = 0;
deck_position = 0;

//choosing
ai_choice = 0;
ai_chose = false;
swap_power = 3;
swapping_spawned = false;
swapping_card =  false;
choosing_type = false;
player_chose = false;

//responding
flip_delay = 0;
progress = false;
player_score = 0;
ai_score = 0;

//clearing
removal_position = 0;
number_in_discard = 0;

change_state = false;