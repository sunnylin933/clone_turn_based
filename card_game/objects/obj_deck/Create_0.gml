
randomize();

deck_size = 24;
global.deck = ds_list_create();
card_type = ds_list_create();

for(i = 0; i < deck_size; i++){
	if(i < deck_size/3)
	{
		add_type = spr_paper;
	}
	else if (i < deck_size/3 * 2)
	{
		add_type = spr_rock;
	}
	else 
	{
		add_type = spr_scissor;
	}	
	ds_list_add(card_type, add_type);
}

for(i = 0; i < deck_size; i++)
{
	var newcard = instance_create_layer(0, 0, "Instances", obj_card);
	
	var random_selection = irandom(ds_list_size(card_type) - 1);
	var random_type = card_type[|random_selection];
	newcard.face_index = random_type;
	ds_list_delete(card_type, random_selection);
	
	newcard.faceup = false;
	newcard.target_x = 100;
	newcard.target_y = room_height*0.35 + (15*i);
	ds_list_add(global.deck, newcard);
}