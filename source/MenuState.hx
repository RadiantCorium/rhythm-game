package;

import Menu.MenuSelection;
import flixel.FlxState;
import flixel.util.FlxColor;
import haxe.Log;
import lime.app.Application;

class MenuState extends FlxState
{
	var substateColor:FlxColor;

	override public function create()
	{
		substateColor = new FlxColor();

		// Create menu
		Menu.title = "Remind me to come up with a name later on";
		#if !web
		Menu.options = ['Song Selector', 'Options', 'Exit'];
		#else
		Menu.options = ['Song Selector', 'Options'];
		#end
		Menu.includeExitBtn = false;
		Menu.callback = (option:MenuSelection) ->
		{
			trace('Epic menu option ${option}');
			// Option check
			switch (option.id)
			{
				case 0:
					trace('Song Selector');
					openSubState(new SongSelectorSubState());
				case 1:
					trace('Options');
				case 2:
					trace('Exit');
					#if (windows || cpp)
					Sys.exit(0);
					#else
					openfl.system.System.exit(0);
					#end
					#if web
					lime.utils.Log.error('I dunno how you did this but you can\'t use exit button on web idot');
					#end
				default:
					trace('something is fucked');
			}
		}
		// Open menu
		openSubState(new Menu(substateColor.setRGB(0, 0, 0, 125)));

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
