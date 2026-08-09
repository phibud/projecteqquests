local livers_needed = "50";
local reward = "the Eyes Wide Open Rank 2 AA";

function event_spawn(e)
    -- Start a timer named "shout" that fires every 900 seconds (15 minutes)
    eq.set_timer("shout", 600000)
end

function event_timer(e)
    if (e.timer == "shout") then
        e.self:Shout("Any one have livers? I am in need of fresh livers for my experiments!");
    end
end

function event_say(e)
    local player = e.other;
    livers_str = eq.get_data("Server_Livers")
    if (e.message:findi("hail")) then
        e.self:Say("Greetings, " .. player:GetName() .. ". I am in need of fresh livers for my experiments. Bring me livers from any creature.  Once I have enough, I will reward the server with " .. reward .. ". ");
        e.self:Say("We currently have " .. livers_str .. " livers out of " .. livers_needed .. " needed.")
    end
end

function event_trade(e)
    local item_lib = require("items");

    -- Check if the player handed in a liver (item ID 19775)
    if (item_lib.check_turn_in(e.trade, {item1 = 19775})) then
        livers_str = eq.get_data("Server_Livers")
        if livers_str == "" then
            eq.set_data("Server_Livers", "1");
            e.self:Say("Ah, a fresh liver! Thank you, " .. e.other:GetName() .. ". Unfortunately this is only the first one that has been turned in.  I am not having very good luck with this!");
        else
            -- Convert string to number, increment, then convert back to string
            local numLivers = tonumber(livers_str);
            
            if (numLivers) then
                numLivers = numLivers + 1;
                eq.set_data("Server_Livers", tostring(numLivers));
                e.self:Say("Ah, a fresh liver! Thank you, " .. e.other:GetName() .. ". One more towards the total.  We now have " .. tostring(numLivers) .. " livers!");
                eq.world_emote(MT.Magenta,"An Undead Steward says, 'Ah, a fresh liver! Thank you, " .. e.other:GetName() .. ". One more towards the total.  We now have " .. tostring(numLivers) .. " livers out of " .. livers_needed .. " needed!'");
            
            end

        end
        
        
        
        
        
    end

    item_lib.return_items(e.self, e.other, e.trade);
end