package  {
	import flash.events.*;
	import flash.ui.*;
	import flash.display.Stage;
	import flash.utils.getTimer;
	
	public class Camera {
		
		private var Model: Object = {
			up: false,
			down: false,
			left: false,
			right: false,
			G: false,
			H: false,
			N: false,
			B: false
		};
		private var speed:Number = 0;
		private var position:Point3d;
		private var rotation:Point3d ;
		private var currTime:Number;
		private var prevTime:Number;
		
		public function Camera(_theStage:Stage, _position:Point3d, _rotation:Point3d) {
			// constructor code
			position = _position;
			rotation = _rotation;
			_theStage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			_theStage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			currTime = getTimer();
			prevTime = getTimer();
		}
		
		public function getPosition():Point3d
		{
			return position;
		}
		
		public function getRotation():Point3d
		{
			return rotation;
		}
		
		function myKeyDown(e: KeyboardEvent): void {

			if (e.keyCode == Keyboard.UP) {
				Model.up = true;
				Model.down = false;
			}
			if (e.keyCode == Keyboard.DOWN) {

				Model.down = true;
				Model.up = false;
			}
			if (e.keyCode == Keyboard.LEFT) {

				Model.left = true;
				Model.right = false;
			}
			if (e.keyCode == Keyboard.RIGHT) {

				Model.right = true;
				Model.left = false;
			}


			if (e.keyCode == Keyboard.W) {
				Model.W = true;
			}
			if (e.keyCode == Keyboard.A) {
				Model.A = true;
			}

			if (e.keyCode == Keyboard.S) {
				Model.S = true;
			}

			if (e.keyCode == Keyboard.D) {
				Model.D = true;
			}

		}




		function myKeyUp(e: KeyboardEvent): void {

			if (e.keyCode == Keyboard.UP) {
				Model.up = false;
			}
			if (e.keyCode == Keyboard.DOWN) {

				Model.down = false;
			}
			if (e.keyCode == Keyboard.LEFT) {

				Model.left = false;
			}
			if (e.keyCode == Keyboard.RIGHT) {

				Model.right = false;
			}


			if (e.keyCode == Keyboard.W) {
				Model.W = false;
			}
			if (e.keyCode == Keyboard.A) {
				Model.A = false;
			}

			if (e.keyCode == Keyboard.S) {
				Model.S = false;
			}

			if (e.keyCode == Keyboard.D) {
				Model.D = false;
			}

		}
		
		public function update(): void {
			
			currTime = getTimer();
			var elapsedTime:Number = currTime - prevTime;
			
			
			
			if (Model.W) {
				speed = Engine.moveSpeed * elapsedTime;
				//my current angle in radians
				var COS: Number = Math.cos(rotation.y) * speed;
				var SIN: Number = Math.sin(rotation.y) * speed;
				//move the player
				position.x += SIN ;
				position.z += COS;
			}

			if (Model.S) {
				speed = -Engine.moveSpeed* elapsedTime;
				//my current angle in radians
				var COS: Number = Math.cos(rotation.y) * speed;
				var SIN: Number = Math.sin(rotation.y) * speed;
				//move the player
				position.x += SIN;
				position.z += COS;
			}

			if (Model.A) {
				//strafe left
				speed = -Engine.moveSpeed * elapsedTime;
				var leftRot:Number = rotation.y + (Math.PI / 2);
				var COS: Number = Math.cos(leftRot) * speed;
				var SIN: Number = Math.sin(leftRot) * speed;
				position.x += SIN;
				position.z += COS;
			}

			if (Model.D) {
				speed = Engine.moveSpeed * elapsedTime;
				//strafe right
				var rightRot:Number = rotation.y + (Math.PI / 2);
				var COS: Number = Math.cos(rightRot) * speed;
				var SIN: Number = Math.sin(rightRot) * speed;
				position.x += SIN;
				position.z += COS;
			}
			 
			if (Model.up) {
				//rotation.x -= Engine.rotateSpeed;
			}
			
			if (Model.down) {
				//rotation.x += Engine.rotateSpeed;
			}
			
			if (Model.right) {
				
				rotation.y += Engine.rotateSpeed * elapsedTime;
				
			}

			if (Model.left) {
				
				rotation.y -= Engine.rotateSpeed * elapsedTime;
				
				
			}
			
/**/		
			prevTime = currTime;

			//stage.removeEventListener(Event.ENTER_FRAME, update);

		}

	}
	
}
