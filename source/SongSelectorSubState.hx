package;

import AUtil.AUtil;
import Menu.MenuSelection;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import openfl.media.Sound;

using StringTools;

class SongSelectorSubState extends FlxSubState
{
	var difficulty:Int = 0;

	var difficultyText:FlxText;
	var initialized:Bool;
	var selectedSong:MenuSelection;

	public override function create()
	{
		if (FlxG.save.data.points == null)
		{
			FlxG.save.data.points = 0;
		}

		var substateColor = new FlxColor();

		var difBG:FlxSprite;

		trace("Opened song selection screen");
		super.create();

		Menu.title = "Song Selection";

		var tempArray = [];

		for (song in AUtil.txtSplit(Paths.txt('songList')))
		{
			if (Std.parseInt(song.trim().split(':')[1]) <= FlxG.save.data.points)
			{
				tempArray.push(song.trim().split(':')[0]);
			}
			else
			{
				tempArray.push('${song.trim().split(':')[0]} - UNLOCKS AT ${song.trim().split(':')[1]} POINTS');
			}
		}

		Menu.options = tempArray;
		Menu.includeExitBtn = false;
		Menu.callback = (option:MenuSelection) ->
		{
			if (!option.text.contains('UNLOCKS AT'))
			{
				trace('Selected Song: ${option.text}');

				selectedSong = option;

				difBG = new FlxSprite(0, FlxG.height - 30).makeGraphic(FlxG.width, 30, FlxColor.GRAY, false);
				difBG.alpha = 0.5;
				difBG.screenCenter();
				add(difBG);

				difficultyText = new FlxText(0, FlxG.height - 25, 0, "Difficulty goes here", 16, true);
				difficultyText.screenCenter();
				difficultyText.alignment = FlxTextAlign.CENTER;
				add(difficultyText);

				initialized = true;
			}
			else
			{
				FlxG.sound.play(Paths.sound('locked', 'shared'));
				openSubState(new Menu(substateColor));
			}
		}
		openSubState(new Menu(substateColor));

		var scoreBG = new FlxSprite(0, 0).makeGraphic(120, 40, FlxColor.GRAY, false);
		scoreBG.alpha = 0.5;
		add(scoreBG);
		var score = new FlxText(10, 10, 0, 'POINTS: ${FlxG.save.data.points}', 16, true);
		add(score);
	}

	public override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (initialized)
		{
			difficultyText.screenCenter(X);

			// Difficulty Key Input
			if (FlxG.keys.justPressed.LEFT)
			{
				difficulty--;
				trace("easier");
			}
			else if (FlxG.keys.justPressed.RIGHT)
			{
				difficulty++;
				trace("harder");
			}
			else if (FlxG.keys.justPressed.ENTER)
			{
				trace("ready");
				FlxG.switchState(new PlayState({song: selectedSong.text, difficulty: difficulty}));
				close();
			}

			if (difficulty > 2)
			{
				difficulty = 0;
			}
			else if (difficulty < 0)
			{
				difficulty = 2;
			}

			// Difficulty text update
			switch (difficulty)
			{
				case 0:
					difficultyText.text = "EASY";
				case 1:
					difficultyText.text = "NORMAL";
				case 2:
					difficultyText.text = "HARD";
			}
		}
	}
}
