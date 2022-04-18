/// @description Insert description here
// You can write your code in this editor
depth = -10
draw_set_font(fnt_general);
draw_text(room_width*0.05, room_height*0.875, player_score);
draw_text(room_width*0.05, room_height*0.05, ai_score);

if(swapping_card && !choosing_type)
{
	draw_set_font(fnt_mini);
	depth = -1100
	draw_text(room_width*0.3, room_height*0.675, "Pick a Card to Reroll")	
}
else if(swapping_card && choosing_type)
{
	draw_set_font(fnt_mini);
	depth = -1100
	draw_text(room_width*0.245, room_height*0.2, "Pick a Card Type to Swap to")	
}