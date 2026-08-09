local bucket_key = "bot-network";

function event_say(e)
    if e.message:findi("hail") then
        e.self:Say("Greetings!  I am the Database Administrator!  I can create a bot network that works with the Dragons of Asia website to manage spells, items, etc.  Let me know if you are [ready] to begin the setup process.  If you already have an existing code you would like to [join], let me know.");
    elseif e.message:findi("ready") then
        local account_id = e.other:AccountID()  -- or e.other:GetAccountID() depending on your server build
        
        -- Check if bucket already exists
        local existing_code = e.other:GetAccountBucket(bucket_key);

        if existing_code and existing_code ~= "" then
            e.self:Say("You already have a bot network code registered.");
            e.self:Say("Your existing code is: " .. existing_code);
            e.self:Say("Use this on the Dragons of Asia website. If you need a new code, contact an admin.");
            
            return  -- stop here — no new code generated
        end

        -- If we reach here → no existing bucket → generate new code
        local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        local code = ""

        -- Seed random reasonably well (mix of time, clock, and entity ID helps)
        math.randomseed(os.time() + os.clock() * 1000 + e.other:GetID())

        for i = 1, 10 do
            local rand_idx = math.random(1, #chars)
            code = code .. chars:sub(rand_idx, rand_idx)
        end

        -- Store the new code permanently (no expiration)
        e.other:SetAccountBucket("bot-network",code);

        e.self:Say("Excellent! Bot network registration code generated and stored.");
        e.self:Say("Your unique code is: " .. code);
        e.self:Say("Enter this code on the Dragons of Asia website to link your account.");
    elseif e.message:findi("join") then
        e.self:Say("To join an existing bot network, say 'join' followed by your code.");

        -- Extract the code part (everything after "join")
        local input = e.message:gsub("^%s*[Jj][Oo][Ii][Nn]%s*", "");
        local code = input:upper():gsub("%s+", "");  -- normalize: uppercase, remove spaces

        -- Validate: exactly 10 chars, only A-Z0-9
        if #code ~= 10 or not code:match("^[A-Z0-9]+$") then
            e.self:Say("Invalid code format.");
            e.self:Say("The code must be **exactly 10 characters** using only letters A-Z and numbers 0-9 (no spaces or symbols).");
            e.self:Say("Example: say 'join ABC123XYZ9'");
            return
        end
        
        e.other:SetAccountBucket("bot-network",code);

        e.self:Say("Success! You have joined the bot network using code: **" .. code .. "**");
        e.self:Say("This code is now linked to your account.");
    end
end