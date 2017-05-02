package 
{
	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;


	public class main extends MovieClip 
	{
		
		//Hier achter variabelen!!
		public var myPlayer: Player;
		public var myArena: arena;
		public var bulletList:Array;
		public var enemyList:Array;
		public var EnemySpawning:Timer = new Timer(2000, 0);
		//public var enemyList: Array = [5];
		public var myEnemy: MovieClip;
		
		public function main() 
		{
			bulletList = new Array;
			enemyList = new Array;
			//New objects
			myArena = new arena();
			myPlayer = new Player();
			myPlayer.myArena = myArena;
			
			myEnemy = new Enemy(this);
			myEnemy.x = 200;
			myEnemy.y = 200;

			this.addChild(myArena);
			myArena.x = 1280 / 2;
			myArena.y = 720 / 2;

			this.addChild(myPlayer);
			myPlayer.x = 100;
			myPlayer.y = 100;
			
			EnemySpawning.start();
			
			//this.addChild(myEnemy);

			this.addEventListener(Event.ENTER_FRAME, _Update);
			EnemySpawning.addEventListener(TimerEvent.TIMER, spawning);
		}
		public function _Update(E: Event){
			for(var a=0;a<bulletList.length;a++){
				bulletList[a].update();
				if(bulletList[a].parent==null){
					bulletList.splice(a, 1);
					a--;
				}
			}
			for (var i=0;i<enemyList.length;i++)
			{
				enemyList[i].update();
				for (a=0;a<bulletList.length;a++)
				{
					if (enemyList[i].hitTestObject(bulletList[a]))
					{
					removeChild(enemyList[i]);
					enemyList.splice(i, 1);
					//enemyList[i]=null;
					removeChild(bulletList[a]);
					bulletList.splice(a, 1);
					//bulletList[a]=null;
					break;
					}
				}
			}
		}
		public function getPlayer(): Player
		{
		return this.myPlayer;
		}
		public function spawning(E:Event){
			myEnemy = new Enemy(this);
			myEnemy.x = 200;
			myEnemy.y = 200;
			addChild(myEnemy);
			enemyList.push(myEnemy);
		}
	}
}