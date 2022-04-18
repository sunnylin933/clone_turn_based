/// @description Insert description here
// You can write your code in this editor
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

if(!hovered){
	x = lerp(x, target_x, 0.1);
	y = lerp(y, target_y, 0.1);
} 
else 
{
	y = lerp(y,target_y - 25, 0.1);
}

if(!obj_game_manager.swapping_card)
{
	target_y = -300
}

if(y <= -300)
{
	instance_destroy();
}