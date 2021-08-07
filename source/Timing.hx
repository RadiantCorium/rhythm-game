package;

import flixel.FlxG;

class Timing
{
	public static var songBPM:Int = 120;
	public static var interval:Float;

	public static function updateInterval(bpm:Int)
	{
		interval = 60 / songBPM;
	}
}
