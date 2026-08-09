
function event_spawn(e)
    e.self:Shout("A test NPC has spawned in Potranquility.");
    eq.set_timer("test_timer", 60000); -- 60 seconds
    e.self:SetEntityVariable("allow_request", "1");
end

function event_say(e)
    local flag = e.self:GetEntityVariable("allow_request");
    if flag=="1" then
        e.self:Say("True - Hello there, adventurer. I am a test NPC in Potranquility.");
    else
        e.self:Say("False - Greetings, traveler. How may I assist you today?");

    end
    
    
end

function event_timer(e)
    local flag = e.self:GetEntityVariable("allow_request");
    if e.timer == "test_timer" then
        if flag=="1" then
            e.self:Shout("This is a periodic test message from the test NPC. True");
            e.self:SetEntityVariable("allow_request", "0");
        else
            e.self:Shout("This is a periodic test message from the test NPC. False");
            e.self:SetEntityVariable("allow_request", "1");
        end
        
        
    end
end