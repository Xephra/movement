package {

	import flash.display.*;
	import flash.events.*;

	public class Enemy extends Entity
	{
		public var Target: Vector2;
		private var enemyLoc: Vector2;
		private var enemyVel: Vector2;
		private var enemyAcc: Vector2;
		private var player:Player;
		private var _root:main;
		public function Enemy(_root:main) 
		{
			this._root = _root;
			this.player = _root.getPlayer();
			enemyLoc = new Vector2(1, 1);
			enemyVel = new Vector2(5, 0);
			enemyAcc = new Vector2(0, 0);
		}
		public function update() 
		{
			this.x = enemyLoc.x;
			this.y = enemyLoc.y;
			
			Target = new Vector2(player.position.x,player.position.y);
			
			Target.sub(enemyLoc);
			Target.setMag(0.5);
			enemyAcc = Target;
			enemyVel.limit(10);
			enemyVel.add(enemyAcc);
			enemyLoc.add(enemyVel);
		}
	}
}