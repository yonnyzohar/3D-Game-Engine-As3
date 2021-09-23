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
			W: false,
			S: false,
			A: false,
			D: false,
			E: false, 
			Q: false
		};
		private var speed:Number = 0;
		private var position:Point3d;
		private var rotation:Quaternion ;
		private var currTime:Number;
		private var prevTime:Number;
		
		public function Camera(_theStage:Stage, _position:Point3d, _rotation:Quaternion) {
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
		
		public function getRotation():Quaternion
		{
			return rotation;
		}
		
		
		
		public function update(): void {
			
			currTime = getTimer();
			var elapsedTime:Number = currTime - prevTime;
			var COS: Number;
			var SIN: Number;
			var MATH_DEG_TO_RAD:Number = 0.0174532925;
			
			//If you''re wondering how I got this, I derived it from quaternion to matrix conversion code. I took the matrix form and multiplied by the vectors (0,0,1) (0,1,0) and (1,0,0) to get these simplified forms.

			//up vector
			//position.x += 2 * (rotation.x*rotation.y - rotation.w*rotation.z)
			//position.y += 1 - 2 * (rotation.x*rotation.x + rotation.z*rotation.z)
			//position.z += 2 * (rotation.y*rotation.z + rotation.w*rotation.x)
			
			elapsedTime = 1;
			
			if (Model.W) {
	
				position.x += 2 * (rotation.x*rotation.z + rotation.w*rotation.y);
				position.y += 2 * (rotation.y*rotation.z - rotation.w*rotation.x);
				position.z += 1 - 2 * (rotation.x*rotation.x + rotation.y*rotation.y);
				
			}

			if (Model.S) {

				position.x -= 2 * (rotation.x*rotation.z + rotation.w*rotation.y);
				position.y -= 2 * (rotation.y*rotation.z - rotation.w*rotation.x);
				position.z -= 1 - 2 * (rotation.x*rotation.x + rotation.y*rotation.y);
			}

			if (Model.A) {
				//strafe left
				//left vector
				position.x -= 1 - 2 * (rotation.y*rotation.y + rotation.z*rotation.z);
				position.y -= 2 * (rotation.x*rotation.y + rotation.w*rotation.z);
				position.z -= 2 * (rotation.x*rotation.z - rotation.w*rotation.y);
			}

			if (Model.D) {
				position.x += 1 - 2 * (rotation.y*rotation.y + rotation.z*rotation.z);
				position.y += 2 * (rotation.x*rotation.y + rotation.w*rotation.z);
				position.z += 2 * (rotation.x*rotation.z - rotation.w*rotation.y);
			}
			 
			if (Model.up) {
				//rotation.x -= Engine.rotateSpeed;
				
				//var quat:Quaternion = Engine.eulerToQuat(rotation);
				var moveVector:Point3d = new Point3d(-Engine.rotateSpeed * MATH_DEG_TO_RAD, 0, 0);
                var quat1:Quaternion = EngineMath.eulerToQuat( moveVector);
                rotation = EngineMath.quatMul( rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
				
			}
			
			if (Model.down) {
				//rotation.x += Engine.rotateSpeed;
				
				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				var moveVector:Point3d = new Point3d(Engine.rotateSpeed * MATH_DEG_TO_RAD, 0, 0);
                var quat1:Quaternion = EngineMath.eulerToQuat( moveVector);
                rotation = EngineMath.quatMul( rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}
			
			if (Model.right) {
				
				//rotation.y += Engine.rotateSpeed * elapsedTime;
				
				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				var moveVector:Point3d = new Point3d(0, Engine.rotateSpeed * MATH_DEG_TO_RAD,0);
                var quat1:Quaternion = EngineMath.eulerToQuat( moveVector);
                rotation = EngineMath.quatMul( rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
                    
			}

			if (Model.left) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;
				
				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				var moveVector:Point3d = new Point3d(0, -Engine.rotateSpeed * MATH_DEG_TO_RAD, 0);
                var quat1:Quaternion = EngineMath.eulerToQuat( moveVector);
                rotation = EngineMath.quatMul( rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}
			
			if (Model.Q) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;
				
				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				var moveVector:Point3d = new Point3d(0, 0, -Engine.rotateSpeed * MATH_DEG_TO_RAD);
                var quat1:Quaternion = EngineMath.eulerToQuat( moveVector);
                rotation = EngineMath.quatMul( rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}
			
			if (Model.E) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;
				
				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				var moveVector:Point3d = new Point3d(0, 0, Engine.rotateSpeed * MATH_DEG_TO_RAD);
                var quat1:Quaternion = EngineMath.eulerToQuat( moveVector);
                rotation = EngineMath.quatMul( rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}
			
/**/		
			prevTime = currTime;

			//stage.removeEventListener(Event.ENTER_FRAME, update);

		}
		
		private function myKeyDown(e: KeyboardEvent): void {

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
			if (e.keyCode == Keyboard.E) {
				Model.E = true;
			}
			if (e.keyCode == Keyboard.Q) {
				Model.Q = true;
			}

		}




		private function myKeyUp(e: KeyboardEvent): void {

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
			if (e.keyCode == Keyboard.E) {
				Model.E = false;
			}
			if (e.keyCode == Keyboard.Q) {
				Model.Q = false;
			}

		}

	}
	
}
