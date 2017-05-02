package {
	import flash.display.*;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	public class Bullet extends MovieClip
	{
		private var enemy:Enemy;
		public var speed: int = 25;

		public function Bullet() 
		{
		}
		public function update() 
		{
			x = x + Math.cos(rotation / 180 * Math.PI) * speed;
			y = y + Math.sin(rotation / 180 * Math.PI) * speed;
			
			if (x > 1228 || x < 54 || y > 665 || y < 44) 
			{
			parent.removeChild(this);
			}
		}
	}
}