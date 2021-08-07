package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.math.FlxRect;
import flixel.util.FlxTimer;

class MusicBeatState extends FlxState
{
	var bHit:Bool = false;
	var songBpm:Int = Timing.songBPM;
	private var curBeat:Int;

	public static var flashOn:Bool = true;
	public static var ugh:Float;

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
		var beats:Float = 60 / songBpm;
		songBpm = Timing.songBPM;

		// Song beat logic
		if (PlayState.music.playing)
		{
			trace('uh ${(ugh) % beats <= 0.1} (${(ugh / 1000)} aka ${ugh}) if this shit stays at 0 somethin\'s fucked');
			if ((ugh) % beats <= 0.1)
			{
				if (bHit == false)
				{
					curBeat++;
					stepHit(curBeat);
					bHit = true;
				}
			}
			else
			{
				bHit = false;
			}
		}
	}

	function stepHit(step:Int):Void
	{
		if (step % 4 == 0)
		{
			beatHit(Std.int(curBeat / 4));
		}
	}

	function beatHit(beat:Int):Void {}
}
