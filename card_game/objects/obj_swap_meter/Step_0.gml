/// @description Insert description here
// You can write your code in this editor
if(obj_game_manager.swap_power == 3)
{
	image_index = 0;
}
else if(obj_game_manager.swap_power == 2)
{
	image_index = 1;
}
else if(obj_game_manager.swap_power == 1)
{
	image_index = 2;
}
else if(obj_game_manager.swap_power == 0)
{
	image_index = 3;
}

if(obj_game_manager.swap_power > 3)
{
	obj_game_manager.swap_power = 3;
}