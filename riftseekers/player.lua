function event_enter_zone(e)
	local qglobals = eq.get_qglobals(e.self);	
	if(qglobals["ranger_epic"] == "8" and qglobals["rng_spawn_rss"] == nil and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(334087)) then
		eq.load_encounter("ranger_2_0");
		eq.unique_spawn(334087,0,0,2.8,1382,60.5,320); --#Craftmaster_Tieranu (334087)	
		eq.set_global("rng_spawn_rss","1",2,"H2");
	end	
end


function event_loot(e)
	if(e.self:Class() == "Ranger" and e.item:GetID() == 11427) then
		local qglobals = eq.get_qglobals(e.self);
		if(qglobals["ranger_epic"] == "8") then
			if(qglobals["rng_rss_chest"] == nil ) then
				eq.spawn2(893,0,0,e.self:GetX(),e.self:GetY(),e.self:GetZ(),e.self:GetHeading()); -- #a chest (Epic 2.0)
				eq.set_global("rng_rss_chest","1",5,"F");
			end
		else
			return 1;
		end		
	end
end

function event_say(e)

	if e.self:GetGM() then 
		if e.message:find("help") then
			e.self:Message(MT.Cyan,"RSS Queen controls available");
			e.self:Message(MT.Guild,string.format("- [%s] -",eq.say_link("queen_repop",false,"Repop Queen")));
			e.self:Message(MT.Guild,string.format("- [%s] -",eq.say_link("king_repop",false,"Repop King")));
		elseif e.message:find("queen_repop") then
			e.self:Message(MT.Cyan,"RSS Queen repopping");
			eq.unique_spawn(334049, 0, 0, 206, -731, 313, 0);
		elseif e.message:find("king_repop") then
			e.self:Message(MT.Cyan,"RSS King repopping");
			eq.unique_spawn(334041, 0, 0, -44, -603.0, -755.75, 0);
		end
	end
end

