
local instance = {
	expedition = { name="Splitpaw", min_players=1, max_players=54 },
	instance   = { zone="paw", version=1, duration=eq.seconds("6h") },
	safereturn = { zone="potranquility", x=-1335, y=779, z=-873, h=0 },
	zonein     = { x=114, y=1433, z=-.5, h=216 }
}



function event_say(e)
    local qglobals = eq.get_qglobals(e.self, e.other);
    local dz = e.other:GetExpedition();
    local dzid = dz:GetID();

    if e.message:findi("hail") then
        if dzid==0 then 
            e.self:Say("Greetings traveler! I can help you create an [instance] of Splitpaw.");
        else
            e.self:Say("Are you [ready] to enter?  ");
        end
    elseif e.message:findi("instance") then
        

        if dzid==0 then

            dz = e.other:CreateExpedition(instance);
            e.self:Say("Are you [ready] to enter?  ");
        else
            e.self:Say("You are already part of an expedition.");
        end
        

        
    elseif e.message:findi("ready") then
        
        local lvl = e.other:GetLevel();
        if dzid>0 then
            if lvl>=55 then
                e.self:Say("Very well.  Take care!");
                e.other:MovePCDynamicZone("paw");
            else
                e.self:Say("You have not yet proven yourself worthy to enter Splitpaw. Return when you have done so.");
            end
        end
        
    elseif e.message:findi("test") then
        
        -- local query = "select * from doa_instanceAgent"
        -- local db = Database()

        -- local ok, stmt = pcall(function() return db:prepare(query) end)
        -- if not ok then
        --     db:close()
        --     if stmt then error("error: " .. stmt) end
        -- end

        -- local ok, err = pcall(function() return stmt:execute() end)
        -- if not ok then
        --     stmt:close()
        --     db:close()
        --     if err then error("error: " .. err) end
        -- end

        -- e.self:Say("Which instance do you want to create?");
        -- local row_count = 0;
        -- row = stmt:fetch_hash()
        -- while row do
        --     row_count = row_count + 1
        --     e.self:Say(string.format("[instance %d] - %s", row["id"], row["name"]))
        --     row = stmt:fetch_hash()
        -- end

        
        -- if row_count == 0 then
        --     e.self:Say("No rows found for id = 1")
        -- end

        -- stmt:close()
        -- db:close()
    end
end