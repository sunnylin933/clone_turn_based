

switch(global.current_state){
	case states.shuffling:
		
		//dealing
		delay = 0;
		deck_position = 0;

		//choosing
		ai_chose = false;
		player_chose = false;
		swapping_spawned = false;
		swapping_card =  false;
		choosing_type = false;

		//responding
		flip_delay = 0;
		progress = false;

		//clearing
		removal_position = 0;
	
		if(!change_state){
			alarm[0] = room_speed
			change_state = true;
		}
	
	break;
	
	case states.dealing:

		delay++;
		
		if(delay > 20 && deck_position  < 6){ //Dealing Cards
			audio_play_sound(snd_dealing, 0, 0);
			if(deck_position < 3)
			{
				var opponent_card = ds_list_find_value(global.deck, deck_position + increment);
				opponent_card.target_x = 255 + (135*deck_position);
				opponent_card.target_y = 125;
			} 
			else if(2 < deck_position < 6)
			{
				var player_card = ds_list_find_value(global.deck, deck_position + increment);
				player_card.target_x = 255 + (135*(deck_position-3));
				player_card.target_y = 650;
				player_card.in_hand = true;
			} else if(!change_state)
			{
				alarm[0] = room_speed
				change_state = true;
			}
				deck_position++;
				delay = 0;
		} else if(delay == 40)
		{
			if(!change_state){
				alarm[0] = room_speed
				change_state = true;
			}
		}
				
	break;
	
	case states.choosing:
	
		flip_delay++;
		
		if(!ai_chose && flip_delay > room_speed){
			ai_choice = choose(0, 1, 2);
			global.ai_selected_card = ds_list_find_value(global.deck, ai_choice + increment);
			global.ai_selected_card.target_y = 275;
			audio_play_sound(snd_move_card, 0, 0);
			ai_chose = true;
		}
	
		if(keyboard_check_released(vk_space) && swap_power > 0 && ai_chose && !swapping_card)
		{
			swapping_card = true;
			audio_play_sound(snd_move_card, 0, 0);
			swap_power--;
		}
	
		if(!player_chose && ai_chose && flip_delay > room_speed && !swapping_card){
			global.selected_card = instance_position(mouse_x, mouse_y, obj_card);
			if(mouse_check_button(mb_left) && global.selected_card != noone && global.selected_card.in_hand){
				if(obj_card.y < room_height/2)
				{
					obj_card.in_hand = false;
				}
				
				audio_play_sound(snd_move_card, 0, 0);
				global.selected_card.target_y = 500;
				player_chose = true;
			}
		} else if (swapping_card && !choosing_type)
		{
			
			global.swapped_card = instance_position(mouse_x, mouse_y, obj_card);
			if(mouse_check_button(mb_left) && global.swapped_card != noone && global.swapped_card.in_hand)
			{
				global.swapped_type_initial = global.swapped_card.face_index;
				global.swapped_card.target_y = 600;
				audio_play_sound(snd_move_card, 0, 0);
				choosing_type = true;		
			}
		} else if(swapping_card && choosing_type)
		{
			if(!swapping_spawned)
			{
				for(var i = 0; i < 3; i++)
				{
				var swapping_new_card = instance_create_depth(room_width * 0.325 + (i*135), -100, -2000, obj_swapping_cards)
				swapping_new_card.target_x = room_width*0.325 + (i*135);
				swapping_new_card.target_y = 300;
				
				}
				swapping_spawned = true;
			} 
			else
			{
				var type_swap_to = instance_position(mouse_x, mouse_y, obj_swapping_cards);
				if(mouse_check_button(mb_left) && type_swap_to != noone){
					global.swapped_card.face_index = type_swap_to.face_index;
					global.swapped_card.target_y = 650;
					swapping_card = false;
					choosing_type = false;
				}
			}
		}
		
		if(!change_state && player_chose){
				alarm[0] = room_speed
				change_state = true;
		}
		
	break;
	
	case states.responding:
	

		global.ai_selected_card.faceup = true;
		
		if(!progress)
		{
			if(global.ai_selected_card.face_index == spr_rock) //rock results
			{
				if(global.selected_card.face_index == spr_paper)
				{
					player_score++;
					audio_play_sound(snd_win, 0, 0);
					progress = true;
				}
				else if(global.selected_card.face_index == spr_scissor)
				{
					ai_score++;
					audio_play_sound(snd_lose, 0, 0);
					progress = true;
				}
				else
				{
					progress = true;
				}
			}
			else if(global.ai_selected_card.face_index == spr_paper) //paper results
			{
				if(global.selected_card.face_index == spr_scissor)
				{
					player_score++;
					audio_play_sound(snd_win, 0, 0);
					progress = true;
				}
				else if(global.selected_card.face_index == spr_rock)
				{
					ai_score++;
					audio_play_sound(snd_lose, 0, 0);
					progress = true;
				}
				else
				{
					progress = true;
				}
			}
			else //scissor results
			{
				if(global.selected_card.face_index == spr_rock)
				{
					player_score++;
					audio_play_sound(snd_win, 0, 0);
					progress = true;
				}
				else if(global.selected_card.face_index == spr_paper)
				{
					ai_score++;
					audio_play_sound(snd_lose, 0, 0);
					progress = true;
				}
				else
				{
					progress = true;
				}
			}
		}
		else
		{
			if(!change_state && player_chose){
				alarm[0] = room_speed*1.5
				change_state = true;
			}
		}
	
	break;
	
	case states.clearing:
	
	delay++;
	
		
		if(delay > 20 && removal_position < 6){ //Removing Cards
				audio_play_sound(snd_clearing, 0, 0);
				var transition_deck =  ds_list_find_value(global.deck, removal_position + increment);
				transition_deck.faceup = false;
				transition_deck.target_x = room_width*0.9;
				transition_deck.target_y = room_height*0.4 + (10*(removal_position + increment));
				transition_deck.in_hand = false;
				removal_position++;
				number_in_discard++;
				delay = 0;
		} else if (delay > 30)
		{
			if(swapping_spawned)
			{
				global.swapped_card.face_index = global.swapped_type_initial;
			}
			
			if(!change_state){
				increment += 6;
				alarm[0] = room_speed
				change_state = true;
			}
		}
	
	break;
	
	case states.restocking:
		
		if(number_in_discard == 24)
		{
			ds_list_shuffle(global.deck);
			audio_play_sound(snd_shuffle, 0, 0);
			swap_power++;
			
			for(var i = 0; i < number_in_discard; i++){
				var newcard = ds_list_find_value(global.deck, i);
				newcard.target_x = room_height*0.1;
				newcard.target_y = room_height*0.4 + (10*i);
			}	
			
			increment = 0;
			number_in_discard = 0
		}
		else
		{
			global.current_state = states.shuffling;
			for(var i = 0; i < number_in_discard; i++)
			{
				var newcard = ds_list_find_value(global.deck, i);
				ds_list_set(global.deck, i, newcard);
			}
		}
	
	break;
}


	show_debug_message(global.swapped_type_initial);