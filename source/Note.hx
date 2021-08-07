package;

import flixel.FlxSprite;

class Note extends FlxSprite
{
	var scrollSpeed:Float;

	public function new(x, noteType:Int, scrollSpeed:Float)
	{
		scrollSpeed = this.scrollSpeed;
		super(x, 0);
		loadGraphic(Paths.image('arrows', 'shared'), true, 512, 512);
		switch (noteType)
		{
			case 0:
				animation.addByPrefix('note', 'YELLOW');
			case 1:
				animation.addByPrefix('note', 'RED');
			case 2:
				animation.addByPrefix('note', 'GREEN');
			case 3:
				animation.addByPrefix('note', 'BLUE');
		}

		animation.play('note');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		y -= scrollSpeed;
	}
}
