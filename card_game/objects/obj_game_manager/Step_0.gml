

switch(global.current_state){
	case states.shuffling:
		
		//dealing
		delay = 0;
		deck_position = 0;

		//choosing
		ai_chose = false;
		player_chose = false;

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
				opponent_card.target_x = 350 + (150*deck_position);
				opponent_card.target_y = 150;
			} 
			else if(2 < deck_position < 6)
			{
				var player_card = ds_list_find_value(global.deck, deck_position + increment);
				player_card.target_x = 350 + (150*(deck_position-3));
				player_card.target_y = 825;
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
			global.ai_selected_card.target_y = 365;
			audio_play_sound(snd_move_card, 0, 0);
			ai_chose = true;
		}
		
		if(!player_chose && ai_chose && flip_delay > room_speed){
			global.selected_card = instance_position(mouse_x, mouse_y, obj_card);
			if(mouse_check_button(mb_left) && global.selected_card != noone && global.selected_card.in_hand){
				if(obj_card.y < room_height/2)
				{
					obj_card.in_hand = false;
				}
				
				audio_play_sound(snd_move_card, 0, 0);
				global.selected_card.target_y = 600;
				player_chose = true;
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
				transition_deck.target_y = room_height*0.35 + (15*(removal_position + increment));
				removal_position++;
				number_in_discard++;
				delay = 0;
		} else if (delay > 30)
		{
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
			
			for(var i = 0; i < number_in_discard; i++){
				var newcard = ds_list_find_value(global.deck, i);
				newcard.in_hand = false;
				newcard.target_x = 100;
				newcard.target_y = room_height*0.35 + (15*i);
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


	show_debug_message(number_in_discard);