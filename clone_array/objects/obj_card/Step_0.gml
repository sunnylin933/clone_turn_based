/// @description Insert description here
// You can write your code in this editor

if(global.current_state == states.choosing && in_hand){
	if(position_meeting(mouse_x, mouse_y, self)){
		hovered = true;
	}
	else
	{
		hovered = false;	
	}
} else 
{
	hovered = false;
}


if(!hovered){
	x = lerp(x, target_x, 0.1);
	y = lerp(y, target_y, 0.1);
} 
else 
{
	y = lerp(y,target_y - 25, 0.1);
}
