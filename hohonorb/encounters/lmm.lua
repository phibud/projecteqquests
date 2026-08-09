-- eq.unique_spawn(220015,0,0,2727,0,471,387); --Lord_Mithaniel_Marr untargetable
-- #Lord Mith Marr (220015) untargetable

local guardscount = 0;

function LMMSpawn(e)
	eq.debug("LMM Spawn function called...");
    
    guardscount = 0;
    eq.set_timer("failCheck", 10 * 1000);
end

function LMMTimer(e)
    eq.debug("LMM Timer function called...");
	if e.timer == "failCheck" then
		spawnGuards();
		eq.stop_timer(e.timer);
	end
end

function guardDeath(e)
    guardscount = guardscount + 1;
    eq.debug("Guard death detected. Current count: " .. guardscount);

    if eq.get_entity_list():IsMobSpawnedByNpcTypeID(220015) then
        eq.debug("Is fake LMM spawned?  yes...")
        if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(220012) and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(220013) and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(220014) then
            eq.debug("Real LMM spawning");
            eq.spawn2(220006,0,0,2727,0,471,387); --Lord_Mithaniel_Marr live version
            eq.depop_all(220015); --depop fake
        end
    end
end

function LMMDeath(e)
    eq.debug("LMM Death function called...");
    eq.stop_timer("failcheck");

    eq.spawn2(202368,0,0,2380,-2,444,387); -- NPC: A_Planar_Projection
    
end

function spawnGuards()

    if eq.get_entity_list():IsMobSpawnedByNpcTypeID(220006) then
        
        eq.depop_all(220006);
    end

    if eq.get_entity_list():IsMobSpawnedByNpcTypeID(220015) then
        eq.debug("Spawning guards for LMM...");
        eq.depop_all(220014);
        eq.depop_all(220013);
        eq.depop_all(220012);

        eq.spawn2(220014,0,0,2366,-151,444,387); --Edium,_Guardian_of_Marr
        eq.spawn2(220013,0,0,2366,154,444,387); --Halon_of_Marr
        eq.spawn2(220012,0,0,2495,0,444,387); --Ralthazor,_Champion_of_Marr

        guardscount = 0;
    end
end

function event_combat(e)
    if e.joined then
        eq.debug("Combat started...");
		eq.stop_timer("failCheck")
	else
        eq.debug("Combat stopped...");
		eq.set_timer("failCheck", 60 * 60 * 1000) --60 min reset
		
	end
end


function event_encounter_load(e)
	eq.debug("LMM event loaded...");

    eq.register_npc_event("lmm", Event.spawn, 220015, LMMSpawn);
    eq.register_npc_event("lmm", Event.timer, 220015, LMMTimer);
    
    eq.register_npc_event("lmm", Event.death_complete, 220006, LMMDeath);

    eq.register_npc_event("lmm", Event.death_complete, 220012, guardDeath);
    eq.register_npc_event("lmm", Event.death_complete, 220013, guardDeath);
    eq.register_npc_event("lmm", Event.death_complete, 220014, guardDeath);
    
end

