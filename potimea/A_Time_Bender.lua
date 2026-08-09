function event_say(e)
	if(e.message:findi("hail") ) then
        e.self:Say("Greetings! Do you need assistance with a corpse [summon]?");
    elseif(e.message:findi("summon")) then
        
        local x, y, z, h = e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading();
        local char_id = e.other:CharacterID();
        local corpse_count = e.other:GetCorpseCount();

        if corpse_count > 0 then
            e.self:Say("Very well. I shall summon any corpses I can find.");
            eq.summon_all_player_corpses(char_id,x,y,z,h);
        else
            e.self:Say("You have no corpses to summon.");
        end
	end
end
