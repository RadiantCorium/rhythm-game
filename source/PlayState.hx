package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;

typedef Song =
{
	song:String,
	difficulty:Int
}

class PlayState extends MusicBeatState
{
	var cdown = 3;
	var cdownDone = false;
	var cdownText:FlxText;

	public var asong:String;
	public var difficulty:Int;

	var bg:FlxSprite;
	var fade:Float = 0.05;

	var k1:Arrow;
	var k2:Arrow;
	var k3:Arrow;
	var k4:Arrow;

	public static var music:FlxSound;

	var time:Float;

	public function new(song:Song)
	{
		super();
		asong = song.song;
		difficulty = song.difficulty;
	}

	override public function create()
	{
		music = new FlxSound();
		music.loadEmbedded(Paths.music(asong, 'shared'), false, false, () ->
		{
			trace('Song over lolol');
		});
		music.stop();

		cdownText = new FlxText(0, 0, 0, "COUNTDOWN", 64, true);
		cdownText.visible = false;
		cdownText.alignment = FlxTextAlign.CENTER;
		cdownText.screenCenter();
		add(cdownText);

		bg = new Arrow(0, 0).makeGraphic(Std.int(FlxG.width / 2.5), FlxG.height, FlxColor.GRAY);
		bg.screenCenter(X);
		add(bg);

		k1 = new Arrow(0, 40);
		k1.loadGraphic(Paths.image('arrows', 'shared'), true, 512, 512, false);
		k1.frames = Paths.getSparrowAtlas('arrows', 'shared');
		k1.animation.addByPrefix('idle', 'ArrowLeft0');
		k1.animation.addByPrefix('pressed', 'ArrowLeftLITGLOW');

		k2 = new Arrow(0, 20);
		k2.loadGraphic(Paths.image('arrows', 'shared'), true, 512, 512, false);
		k2.frames = Paths.getSparrowAtlas('arrows', 'shared');
		k2.animation.addByPrefix('idle', 'ArrowDown0');
		k2.animation.addByPrefix('pressed', 'ArrowDownLITGLOW');

		k3 = new Arrow(0, 20);
		k3.loadGraphic(Paths.image('arrows', 'shared'), true, 512, 512, false);
		k3.frames = Paths.getSparrowAtlas('arrows', 'shared');
		k3.animation.addByPrefix('idle', 'ArrowUp0');
		k3.animation.addByPrefix('pressed', 'ArrowUpLITGLOW');

		k4 = new Arrow(0, 40);
		k4.loadGraphic(Paths.image('arrows', 'shared'), true, 512, 512, false);
		k4.frames = Paths.getSparrowAtlas('arrows', 'shared');
		k4.animation.addByPrefix('idle', 'ArrowRight0');
		k4.animation.addByPrefix('pressed', 'ArrowRightLITGLOW');

		k1.addOffset('pressed', 15, 15);
		k2.addOffset('pressed', 15, 15);
		k3.addOffset('pressed', 15, 15);
		k4.addOffset('pressed', 15, 15);

		k1.playAnim('idle');
		k2.playAnim('idle');
		k3.playAnim('idle');
		k4.playAnim('idle');
		add(k1);
		add(k2);
		add(k3);
		add(k4);

		// Arrow offsets
		k1.screenCenter(X);
		k2.screenCenter(X);
		k3.screenCenter(X);
		k4.screenCenter(X);

		k1.x -= k1.width * 3;
		k2.x -= k2.width - 0.5;
		k3.x += k2.width - 0.5;
		k4.x += k2.width * 2;
		super.create();

		startCountdown();
	}

	override public function update(elapsed:Float)
	{
		cdownText.screenCenter();

		super.update(elapsed);
		bg.alpha -= fade;

		// Controlls
		if (FlxG.keys.pressed.LEFT || FlxG.keys.pressed.A)
		{
			k1.playAnim('pressed');
		}
		else
		{
			k1.playAnim('idle');
		}

		if (FlxG.keys.pressed.DOWN || FlxG.keys.pressed.S)
		{
			k2.playAnim('pressed');
		}
		else
		{
			k2.playAnim('idle');
		}

		if (FlxG.keys.pressed.UP || FlxG.keys.pressed.W)
		{
			k3.playAnim('pressed');
		}
		else
		{
			k3.playAnim('idle');
		}

		if (FlxG.keys.pressed.RIGHT || FlxG.keys.pressed.D)
		{
			k4.playAnim('pressed');
		}
		else
		{
			k4.playAnim('idle');
		}

		// COUNTDOWN
		switch (cdown)
		{
			case 3:
				trace("3");
				cdownText.text = '3';
			case 2:
				trace("2");
				cdownText.text = '2';
			case 1:
				trace("1");
				cdownText.text = '1';
			case 0:
				if (!cdownDone)
				{
					trace("Go!");
					cdownText.text = 'GO!';
					Timing.songBPM = 220;
					music.play();
					music.resume();
					cdownDone = true;
				}
		}

		// THIS IS A TEMPORARY SOLUTION!!!!!!
		if (music.playing || time < music.endTime)
		{
			time += elapsed;
		}

		MusicBeatState.ugh = time;
		trace('time lol: ${music.time}');
	}

	override public function stepHit(beat:Int)
	{
		bg.alpha = 1;
		super.stepHit(beat);
		if (beat % 4 == 0)
		{
			bg.alpha = 1;
			trace("%4");
		}
		trace("beat");
		cdownText.visible = false;
	}

	function startCountdown()
	{
		cdownText.visible = true;
		new FlxTimer().start(1, (timer:FlxTimer) ->
		{
			cdown--;
			bg.alpha = 1;
			trace(':${cdown}');
		}, 3);
	}
}
