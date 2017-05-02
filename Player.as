package 
{

	import flash.display.*;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.TimerEvent;

	public class Player extends Entity
	{

		//Vector_Player_Movement
		/*public var position: Vector2;
		public var speed:int = 20;
		public var speedLimit:int = 10;
		public var playerVelocity: Vector2;*/
		
		//Player_Movement_Booleans
		public var MoveLeft: Boolean = false;
		public var MoveRight: Boolean = false;
		public var MoveUp: Boolean = false;
		public var MoveDown: Boolean = false;
		
		//Shooting
		public var Shooting: Boolean = false;
		public var myBullet:MovieClip;
		public var minigunFireRate:Timer;
		public var firerate:int;
		
		//Weapon Upgrades
		public var weaponChoice:Number = 0;
		

		public var myArena:arena;
		
		public function Player()
		{
			firerate = 100;
			
			minigunFireRate = new Timer(firerate, 0);
			_simpleListeners();
			AddNewObjects();
		}
		public function _PlayerUpdate(E: Event): void 
		{
			playerMovement();				

			moveDiagonally();			
			normalizePlayer();
			positionDefining();
			borderCollision();
			
			if (Shooting){
				minigunFireRate.start();
			}
			if (!Shooting){
				minigunFireRate.stop();
			}

			//trace(playerVelocity);
			//trace(position);
			//trace (Shooting);
			
			///\/\/\/\/\/\/\/\/\/\/\/\/\/UPDATE/\/\/\/\/\/\/\/\/\/\/\/
		}
		
		public function _simpleListeners()
		{
			this.addEventListener(Event.ENTER_FRAME, _PlayerUpdate);
			addEventListener(Event.ADDED_TO_STAGE, _initPlayer);
			minigunFireRate.addEventListener(TimerEvent.TIMER, rapidFire);
		}
	
		public function positionDefining()
		{
			position.add(playerVelocity);
			this.x = this.position.x;
			this.y = this.position.y;
		}

		public function AddNewObjects()
		
		{
			position = new Vector2(500,500);
			playerVelocity = new Vector2(0,0);
			myBullet = new Bullet();
		}
		
		public function normalizePlayer()
		
		{
			this.playerVelocity.limit(speedLimit);			
		}

		public function _initPlayer(E: Event) //Nodig om Stage bekend te maken bij KeyBoardEventListeners
		
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, inputHandlerDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, inputHandlerUp);
		}

		public function playerMovement()
		
		{	
			if (MoveLeft) 
			{
				playerVelocity.x = -speed;
				this.rotation = 180; 
			}
			if (MoveRight) 
			{
				playerVelocity.x = speed;
				this.rotation = 0;
			}
			if (MoveUp) 
			{
				playerVelocity.y = -speed;
				this.rotation = 270;
			}
			if (MoveDown) 
			{
				playerVelocity.y = speed;
				this.rotation = 90;
			}
			
		}

		public function inputHandlerDown(E: KeyboardEvent): void 
		
		{
			if (E.keyCode == Keyboard.W)
			{
				MoveUp = true;
			}
			if (E.keyCode == Keyboard.A)
			{
				MoveLeft = true;
			}
			if (E.keyCode == Keyboard.S) 
			{
				MoveDown = true;
			}
			if (E.keyCode == Keyboard.D) 
			{
				MoveRight = true;
			}
			if (E.keyCode == Keyboard.SPACE)
			{
				Shooting = true;
			}
		}
	
		public function inputHandlerUp(E: KeyboardEvent): void 
		{
			if (E.keyCode == Keyboard.W)
			{
				MoveUp = false;
				playerVelocity.y = 0;
			}
			if (E.keyCode == Keyboard.A)
			{
				MoveLeft = false;
				playerVelocity.x = 0;
			}
			if (E.keyCode == Keyboard.S)
			{
				MoveDown = false;
				playerVelocity.y = 0;
			}
			if (E.keyCode == Keyboard.D)
			{
				MoveRight = false;
				playerVelocity.x = 0;
			}
			if (E.keyCode == Keyboard.SPACE)
			{
				Shooting = false;
			}
			if (E.keyCode == Keyboard.NUMBER_1){
				weaponChoice = 0;
				firerate = 200;
			}
			if (E.keyCode == Keyboard.NUMBER_2){
				weaponChoice = 1;
				firerate = 50;
			}
			if (E.keyCode == Keyboard.NUMBER_3){
				weaponChoice = 2;
				firerate = 500;
			}
		}
		public function rapidFire(E:Event)
		{
			if (weaponChoice == 0){
				pistol();
			}
			if (weaponChoice == 1){
				minigun();
			}
			if (weaponChoice == 2){
				shotgun();
			}
			
		}
		public function minigun(){
			for (var e = 0; e<1; e++){
					var b = new Bullet();
					b.rotation = this.rotation + (Math.random()*10 - 5);
					b.x = x;
					b.y = y;
					stage.addChild(b);
					MovieClip(parent).bulletList.push(b);
				}
		}
		public function shotgun(){
			for (var e = 0; e<10; e++){
					var b = new Bullet();
					b.rotation = this.rotation + (Math.random()*30 - 15);
					b.x = x;
					b.y = y;
					stage.addChild(b);
					MovieClip(parent).bulletList.push(b);
				}
		}
		public function pistol(){
			for (var e = 0; e<1; e++){
					var b = new Bullet();
					b.rotation = this.rotation + (Math.random()*2 - 1);
					b.x = x;
					b.y = y;
					stage.addChild(b);
					MovieClip(parent).bulletList.push(b);
				}
		}
		public function moveDiagonally()
		{
			if (MoveUp && MoveRight && !MoveLeft && !MoveDown)
			{
				this.rotation = -45;
			}
			if (MoveUp && !MoveRight && MoveLeft && !MoveDown)
			{
				this.rotation = -135;
			}
			if (!MoveUp && !MoveRight && MoveLeft && MoveDown)
			{
				this.rotation = -225;
			}
			if (!MoveUp && MoveRight && !MoveLeft && MoveDown)
			{
				this.rotation = -315;
			}
		}
		public function borderCollision()
		{
			if (this.x > 1212)
			{
				playerVelocity.x * -1;
				position.x = 1212;
			}
			if (this.x < 68)
			{
				playerVelocity.x * -1;
				position.x = 68;
			}
			if (this.y > 652)
			{
				playerVelocity.y * -1;
				position.y = 652;
			}
			if (this.y < 68)
			{
				playerVelocity.y * -1;
				position.y = 68;
			}
		}
	}
}