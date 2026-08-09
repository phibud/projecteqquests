local awisano_id	= 222022;
local birak_id		= 222021;
local galronar_id	= 222020;

local awisano_guard_id  = 222002;
local birak_guard_id    = 222001;
local galronar_guard_id = 222000;

local awisano_mob_id    = 222016;
local birak_mob_id      = 222017;
local galronar_mob_id   = 222018;

local awisano_guards_dead   = 0;
local birak_guards_dead     = 0;
local galronar_guards_dead  = 0;


function WarlordTimer(e)
    if e.timer == "awisano" then
        eq.stop_timer("awisano");
		eq.depop_all(awisano_guard_id);
        eq.depop_all(awisano_id);
        eq.spawn2(awisano_guard_id, 0, 0, 292, 248, -14.5, 449); -- NPC: A_Myrmidon_of_Stone
        eq.spawn2(awisano_guard_id, 0, 0, 290, 312, -14.5, 320); -- NPC: A_Myrmidon_of_Stone
        eq.spawn2(awisano_guard_id, 0, 0, 225.5, 245.3, -14.5, 67.75); -- NPC: A_Myrmidon_of_Stone
        eq.spawn2(awisano_guard_id, 0, 0, 221, 319, -14.5, 192); -- NPC: A_Myrmidon_of_Stone
        awisano_guards_dead   = 0;
    elseif e.timer == "birak" then
        eq.stop_timer("birak");
        eq.depop_all(birak_guard_id);
        eq.depop_all(birak_id);
        eq.spawn2(birak_guard_id, 0, 0, -12, 352, -14.5, 193); -- NPC: A_Stonefist_Clansman
		eq.spawn2(birak_guard_id, 0, 0, 52, 285, -14.5, 450); -- NPC: A_Stonefist_Clansman
		eq.spawn2(birak_guard_id, 0, 0, 58, 356, -14.5, 320); -- NPC: A_Stonefist_Clansman
		eq.spawn2(birak_guard_id, 0, 0, -13, 286, -14.5, 65); -- NPC: A_Stonefist_Clansman
        birak_guards_dead     = 0;
    elseif e.timer == "galronar" then
        eq.stop_timer("galronar");
        eq.depop_all(galronar_guard_id);
        eq.depop_all(galronar_id);
        eq.spawn2(galronar_guard_id, 0, 0, 22, 78, -14.5, 193); -- NPC: A_Rock_Studded_Champion
		eq.spawn2(galronar_guard_id, 0, 0, 99, 1, -14.5, 450); -- NPC: A_Rock_Studded_Champion
		eq.spawn2(galronar_guard_id, 0, 0, 98, 78, -14.5, 320); -- NPC: A_Rock_Studded_Champion
		eq.spawn2(galronar_guard_id, 0, 0, 20, 1, -14.5, 65); -- NPC: A_Rock_Studded_Champion
        galronar_guards_dead  = 0;
    end
end

function awisano_trigger_spawn(e)
    eq.set_timer("awisano", 6 * 1000);
    eq.debug("awisano timer started");
end

function birak_trigger_spawn(e)
    eq.set_timer("birak", 6 * 1000);
    eq.debug("birak timer started");
end

function galronar_trigger_spawn(e)
    eq.set_timer("galronar", 6 * 1000);
    eq.debug("galronar timer started");
end

function AwisanoGuardDeath(e)
    awisano_guards_dead = awisano_guards_dead + 1;
    eq.debug("Awisano Guard Death " .. awisano_guards_dead);
    if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(awisano_guard_id) then
        eq.debug("All Awisano Guards Dead");
        eq.spawn2(222016, 0, 0, 259, 278, -20, 125); -- NPC: #War_Chieftan_Awisano
        
    end
end

function BirakGuardDeath(e)
    birak_guards_dead = birak_guards_dead + 1;
    eq.debug("Birak Guard Death " .. birak_guards_dead);
    if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(birak_guard_id) then
        eq.debug("All Birak Guards Dead");
        eq.spawn2(222017, 0, 0, 21, 322, -20, 127); -- NPC: #War_Chieftan_Birak
        
    end
end

function GalronarGuardDeath(e)
    galronar_guards_dead = galronar_guards_dead + 1;
    eq.debug("Galronar Guard Death " .. galronar_guards_dead);
    if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(galronar_guard_id) then
        eq.debug("All Galronar Guards Dead");
 	    eq.spawn2(222018, 0, 0, 60, 40, -20, 0); -- NPC: #War_Chieftan_Galronar
 	    
    end
end

function ChiefDeath(e)
    if not eq.get_entity_list():IsMobSpawnedByNpcTypeID(awisano_mob_id) and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(birak_mob_id) and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(galronar_mob_id) then
        eq.signal(222023,0); -- NPC: #Warlord_Spawner
    end
end

function event_encounter_load(e)
    eq.debug("Warlord Encounter loaded");
    eq.register_npc_event("warlord", Event.spawn, awisano_id,   awisano_trigger_spawn)
    eq.register_npc_event("warlord", Event.spawn, birak_id,     birak_trigger_spawn)
    eq.register_npc_event("warlord", Event.spawn, galronar_id,  galronar_trigger_spawn)
    
    eq.register_npc_event("warlord", Event.timer, awisano_id,   WarlordTimer);
    eq.register_npc_event("warlord", Event.timer, birak_id,     WarlordTimer);
    eq.register_npc_event("warlord", Event.timer, galronar_id,  WarlordTimer);
    
    eq.register_npc_event("warlord", Event.death_complete, awisano_guard_id,     AwisanoGuardDeath);
    eq.register_npc_event("warlord", Event.death_complete, birak_guard_id,       BirakGuardDeath);
    eq.register_npc_event("warlord", Event.death_complete, galronar_guard_id,    GalronarGuardDeath);

    eq.register_npc_event("warlord", Event.death_complete, awisano_mob_id,   ChiefDeath);
    eq.register_npc_event("warlord", Event.death_complete, birak_mob_id,     ChiefDeath);
    eq.register_npc_event("warlord", Event.death_complete, galronar_mob_id,  ChiefDeath);
end