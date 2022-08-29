// PSprite speed scaler - Implementation and demonstration of smoothly scaling psprite animations
// Written in 2017 by argv_minus_one <argv.minus.one@gmail.com>
// https://github.com/argv-minus-one/gzdoom-psprite-speed-scaling

class PSpriteSpeedScaler play {
	PSprite ps;
	PSpriteSpeedScaler next;
	
	void SkipTic() {
		if (ps.Tics < 1)
			// Don't act on indefinite states.
			;
		else if (ps.Tics > 1)
			ps.Tics--;
		else
			ps.SetState(ps.CurState.NextState);
	}
	
	void DelayTic() {
		if (ps.Tics > 0)
			ps.Tics++;
	}
}

struct PSpriteSpeedScalerSet play {
	PSpriteSpeedScaler first;
	private float debt;
	
	void Clear() {
		for (let sci = first; sci; sci = sci.next)
		if (sci.ps)
			sci.ps.bPowDouble = true;
		
		first = null;
		debt = 0;
	}
	
	void MoveAll(bool skipOrDelay, Inventory item = null) {
		for (let ps = item.Owner.player.psprites; ps; ps = ps.Next)
		if (ps && (!item || ps.Caller == item)) {
			PSpriteSpeedScaler scl = null;
			
			for (PSpriteSpeedScaler sci = first, psci = null; sci; psci = sci, sci = sci.next) {
				if (!sci.ps || sci.ps.bDestroyed) {
					if (psci)
						psci.next = sci.next;
					else
						first = sci.next;
				}
				else if (sci.ps == ps) {
					scl = sci;
					break;
				}
			}
			
			if (!scl) {
				scl = new("PSpriteSpeedScaler");
				scl.ps = ps;
				scl.next = first;
				ps.bPowDouble = false;
				first = scl;
			}
			
			if (skipOrDelay)
				scl.SkipTic();
			else
				scl.DelayTic();
		}
	}
	
	void Tick(Inventory item, float scale) {
		if (debt >= 1.) {
			// Waiting for a debt. Delay all scalers, but do nothing else.
			if (debt >= 2.)
				MoveAll(false, item);
			
			debt -= 1.;
		}
		else {
			// Time to apply the scaling thing again.
			debt += scale;
			
			// Apply PowerDoubleFiringSpeed, if appropriate.
			if (
				item && item.Owner && (item is "Weapon") &&
				item.Owner.FindInventory("PowerDoubleFiringSpeed", true)
			)
				debt -= 1.;
			
			if (debt >= 1.) {
				MoveAll(false, item);
				// Don't modify debt here. Wait for the next tic before doing that. Otherwise, any delay would cause us to endlessly wait on the same state!
			}
			else while (debt <= -1.) {
				// Skip tics as needed.
				MoveAll(true, item);
				debt += 1.;
			}
		}
		
		// Occasionally look for and remove unused scalers.
		// This can happen when the scale is so low that a flash animation is skipped entirely.
		// This has approximately O(n^2) complexity, so don't do it all the time.
		if (!(gametic & 127)) {
			for (PSpriteSpeedScaler sci = first, psci = null; sci; psci = sci, sci = sci.next) {
				bool used = false;
				
				for (let ps = item.Owner.player.psprites; ps; ps = ps.Next)
				if (ps.Caller == item && sci.ps == ps) {
					used = true;
					break;
				}
				
				if (!used || sci.ps.bDestroyed) {
					if (psci)
						psci.next = sci.next;
					else
						first = sci.next;
				}
			}
		}
	}
}
