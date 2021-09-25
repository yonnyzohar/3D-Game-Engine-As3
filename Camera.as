package {
	import flash.events.*;
	import flash.ui.*;
	import flash.display.Stage;
	import flash.utils.getTimer;
	import flash.geom.Vector3D;

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
		private var counter: Number = 0;
		private var position: Point3d;
		private var rotation: Quaternion;
		private var scale: Vector3;
		private var currTime: Number;
		private var prevTime: Number;
		public var transformMatrix: Matrix4x4;
		private var theStage: Stage;
		public static var zNear;
		public static var zFar = 10000;
		private static var fieldOfView: Number = 45;
		public var aspectRatio:Number ;
		public var fovY:Number;

		public function Camera(_theStage: Stage, _position: Point3d, _rotation: Quaternion) {
			// constructor code
			theStage = _theStage;
			position = _position;
			rotation = _rotation;
			scale = new Vector3(1, 1, 1);
			_theStage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			_theStage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			currTime = getTimer();
			prevTime = getTimer();
			transformMatrix = new Matrix4x4();
			transformMatrix.createFromTransform(position, rotation, scale);
			zNear = (Engine.resolutionX / 2.0) / Math.tan(EngineMath.degreesToRad(fieldOfView / 2.0));
			aspectRatio = Engine.resolutionX / Engine.resolutionY;
			
			//get the field of view from top to bottom
			var oneDivAspectRatio:Number = 1.0/aspectRatio;
			fovY = 2 * Math.atan(Math.tan(EngineMath.degreesToRad(fieldOfView) / 2.0) * oneDivAspectRatio);

		}

		public function getPosition(): Point3d {
			return position;
		}

		public function getRotation(): Quaternion {
			return rotation;
		}



		public function update(): void {

			currTime = getTimer();
			var elapsedTime: Number = currTime - prevTime;
			var COS: Number;
			var SIN: Number;
			var MATH_DEG_TO_RAD: Number = 0.0174532925;
			var moveVector: Point3d;
			var quat1: Quaternion;

			//If you''re wondering how I got this, I derived it from quaternion to matrix conversion code. I took the matrix form and multiplied by the vectors (0,0,1) (0,1,0) and (1,0,0) to get these simplified forms.

			//up vector
			//position.x += 2 * (rotation.x*rotation.y - rotation.w*rotation.z)
			//position.y += 1 - 2 * (rotation.x*rotation.x + rotation.z*rotation.z)
			//position.z += 2 * (rotation.y*rotation.z + rotation.w*rotation.x)

			elapsedTime = 1;

			if (Model.W) {

				position.x += 2 * (rotation.x * rotation.z + rotation.w * rotation.y);
				position.y += 2 * (rotation.y * rotation.z - rotation.w * rotation.x);
				position.z += 1 - 2 * (rotation.x * rotation.x + rotation.y * rotation.y);

			}

			if (Model.S) {

				position.x -= 2 * (rotation.x * rotation.z + rotation.w * rotation.y);
				position.y -= 2 * (rotation.y * rotation.z - rotation.w * rotation.x);
				position.z -= 1 - 2 * (rotation.x * rotation.x + rotation.y * rotation.y);
			}

			if (Model.A) {
				//strafe left
				//left vector
				position.x -= 1 - 2 * (rotation.y * rotation.y + rotation.z * rotation.z);
				position.y -= 2 * (rotation.x * rotation.y + rotation.w * rotation.z);
				position.z -= 2 * (rotation.x * rotation.z - rotation.w * rotation.y);
			}

			if (Model.D) {
				position.x += 1 - 2 * (rotation.y * rotation.y + rotation.z * rotation.z);
				position.y += 2 * (rotation.x * rotation.y + rotation.w * rotation.z);
				position.z += 2 * (rotation.x * rotation.z - rotation.w * rotation.y);
			}

			if (Model.up) {
				//rotation.x -= Engine.rotateSpeed;

				//var quat:Quaternion = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(-Engine.rotateSpeed * MATH_DEG_TO_RAD, 0, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/

			}

			if (Model.down) {
				//rotation.x += Engine.rotateSpeed;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(Engine.rotateSpeed * MATH_DEG_TO_RAD, 0, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			if (Model.right) {

				//rotation.y += Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, Engine.rotateSpeed * MATH_DEG_TO_RAD, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/

			}

			if (Model.left) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, -Engine.rotateSpeed * MATH_DEG_TO_RAD, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			if (Model.Q) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, 0, -Engine.rotateSpeed * MATH_DEG_TO_RAD);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			if (Model.E) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, 0, Engine.rotateSpeed * MATH_DEG_TO_RAD);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			/**/
			prevTime = currTime;
			transformMatrix.createFromTransform(position, rotation, scale);
			
			if(counter % 10 == 0)
			{
				var pos:Vector3 = Engine.unprojectCoordinate(this, theStage.mouseX, Engine.resolutionY - theStage.mouseY, 0.05);
				//trace(pos.x, pos.y, pos.z);
				//trace(position.x, position.y, position.z, "", rotation.x, rotation.y, rotation.z, rotation.w);
				cameraLookAt(pos);
			}
			
			
			counter++;
			
			
			//cameraLookAt(
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

		public function cameraLookAt(worldPosition: Vector3): void {
			var destPosition: Vector3 = new Vector3(worldPosition.x, worldPosition.y, worldPosition.z);

			//get the forward vector by subtracting the destination from the current entity
			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);

			rotation = EngineMath.quatLookAt(forward, EngineMath.UP);



		}

	}

}