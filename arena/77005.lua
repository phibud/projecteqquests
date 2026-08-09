local debuff = 0;

function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("If you would like to adjust the offensive difficulty level of this npc, let me know if you would like a [low], [medium], or [hard] difficulty. Perhaps you would like to [add flurry], [remove flurry], [add rampage], [remove rampage], [add ae rampage], [remove ae rampage], [hit slower], [hit faster], [mitigate more slow], or [mitigate less slow]. You may also [repop] me to reset my settings.  You can also set the level to [70], [75], or [80].  You can add a debuff using [debuff] #");
	elseif(e.message:findi("low")) then
    e.self:ModifyNPCStat("accuracy", "100");
    e.self:ModifyNPCStat("atk", "200");
	elseif(e.message:findi("medium")) then
    e.self:ModifyNPCStat("accuracy", "500");
    e.self:ModifyNPCStat("atk", "300");
	elseif(e.message:findi("hard")) then
    e.self:ModifyNPCStat("accuracy", "900");
    e.self:ModifyNPCStat("atk", "400");
	elseif(e.message:findi("add flurry")) then
    e.self:SetSpecialAbility(SpecialAbility.flurry, 1)
	elseif(e.message:findi("remove flurry")) then
    e.self:SetSpecialAbility(SpecialAbility.flurry, 0)
	elseif(e.message:findi("add rampage")) then
    e.self:SetSpecialAbility(SpecialAbility.rampage, 1)
	elseif(e.message:findi("remove rampage")) then
    e.self:SetSpecialAbility(SpecialAbility.rampage, 0)
	elseif(e.message:findi("add ae rampage")) then
    e.self:SetSpecialAbility(SpecialAbility.area_rampage, 1)
	elseif(e.message:findi("remove ae rampage")) then
    e.self:SetSpecialAbility(SpecialAbility.area_rampage, 0)
	elseif(e.message:findi("hit slower")) then
    e.self:ModifyNPCStat("attack_delay","20");
	elseif(e.message:findi("hit faster")) then
    e.self:ModifyNPCStat("attack_delay","10");
	elseif(e.message:findi("mitigate more slow")) then
    e.self:ModifyNPCStat("slow_mitigation","85");
	elseif(e.message:findi("mitigate less slow")) then
    e.self:ModifyNPCStat("slow_mitigation","15");
    elseif(e.message:findi("70")) then
    e.self:SetLevel(70);
    elseif(e.message:findi("75")) then
    e.self:SetLevel(75);
    elseif(e.message:findi("80")) then
    e.self:SetLevel(80);
    elseif(e.message:findi("debuff")) then
    local spell_id_str = e.message:match("%f[%d]%d+");  -- finds the first sequence of digits

    if spell_id_str then
        local spell_id = tonumber(spell_id_str);
        
        if spell_id and spell_id > 0 then  -- basic sanity check
            debuff = spell_id;
            e.self:Say("Debuff spell updated to ID " .. spell_id );
        else
            e.self:Say("Invalid spell ID. Please provide a positive number, e.g. 'debuff 212'.");
        end
    end
	end
end

function event_combat(e)
  if e.joined then
    if debuff then
        eq.set_timer("debuff",30*1000);
    else
        eq.pause_timer("debuff");
    end
    
    
  end
end

function event_timer(e)
    if e.timer == "debuff" then
        if debuff then
            e.self:CastSpell(debuff, e.self:GetTarget():GetID());
            eq.debug("Casting debuff");
        end
    end
end
