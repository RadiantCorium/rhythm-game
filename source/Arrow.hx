package;

import flixel.FlxSprite;

class Arrow extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;

	public function new(x, y)
	{
		animOffsets = new Map<String, Array<Dynamic>>();

		super(x, y);
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);
	}
}
