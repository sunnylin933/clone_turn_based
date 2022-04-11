/// @description Insert description here
// You can write your code in this editor

if(global.current_state == states.choosing && in_hand){
	
	if(!flipped){
		faceup = true;
		if(!audio_is_playing(snd_move_card)){
			audio_play_sound(snd_move_card, 0, 0);
		}
		flipped = true;
	}
	
	if(position_meeting(mouse_x, mouse_y, self)){
		hovered = true;
		if(!audio)
		{
			audio_play_sound(snd_hover_card, 0, 0);
			audio = true;
		}
	}
	else
	{
		hovered = false;
		audio = false;
	}
} else 
{
	hovered = false;
	flipped = false;
}


if(!hovered){
	x = lerp(x, target_x, 0.1);
	y = lerp(y, target_y, 0.1);
} 
else 
{
	y = lerp(y,target_y - 25, 0.1);
}

depth = -(room_height - target_y);
