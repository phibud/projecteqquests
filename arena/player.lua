function event_say(e)
    if e.message:find("repop") then
        eq.debug("Repopping...");
        eq.depop_all(77005);
    end
end