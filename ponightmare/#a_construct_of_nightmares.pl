sub EVENT_DEATH_COMPLETE {

quest::signalwith(204016,8,1); # NPC: Thelin_Poxbourne
}

sub EVENT_SPAWN

{
quest::settimer(1,600);
}

sub EVENT_TIMER {

if($timer == 1)
	{
	quest::depop();
	}
}
