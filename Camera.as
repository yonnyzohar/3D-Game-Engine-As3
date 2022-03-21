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
		private var iterator:int = 0;

		public var position: Point3d;
		public var positionMinusZ:Point3d;
		public var rotation: Quaternion;
		public var scale: Vector3;

		private var currTime: Number;
		private var prevTime: Number;
		public var transformMatrix: Matrix4x4;
		private var theStage: Stage;
		public static var zNear;
		public static var zFar = 10000;
		private static var fieldOfView: Number = 30;
		public var aspectRatio:Number ;
		public var fovY:Number;
		private var lastMouseX:Number = 0;
		private var lastMouseY:Number = 0;
		private var mouseIsDown:Boolean = false;
		private var prevEpoch:Number;
		var date:Date;

		public function Camera(_theStage: Stage, _position: Point3d, _rotation: Quaternion) {
			// constructor code
			date = new Date();
			theStage = _theStage;
			position = _position;
			rotation = _rotation;
			scale = new Vector3(1, 1, 1);
			_theStage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			_theStage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			_theStage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_theStage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			currTime = getTimer();
			prevTime = getTimer();
			transformMatrix = new Matrix4x4();
			transformMatrix.createFromTransform(position, rotation, scale);
			zNear = (Engine.resolutionX / 2.0) / Math.tan(EngineMath.degreesToRad(fieldOfView / 2.0));
			trace(zNear);
			aspectRatio = Engine.resolutionX / Engine.resolutionY;
			
			//get the field of view from top to bottom
			var oneDivAspectRatio:Number = 1.0/aspectRatio;
			fovY = 2 * Math.atan(Math.tan(EngineMath.degreesToRad(fieldOfView) / 2.0) * oneDivAspectRatio);


			positionMinusZ = new Point3d(position.x, position.y, position.z - zNear);

		}
	
		private function mouseDown(e:MouseEvent):void{
			mouseIsDown = true;
		}
		
		private function mouseUp(e:MouseEvent):void{
			mouseIsDown = false;
		}


		public function getPosition(): Point3d {
			return positionMinusZ;
		}

		public function getRotation(): Quaternion {
			return rotation;
		}



		public function update(): void {

			currTime = getTimer();
			var epoch:Number = date.time;
			
			var elapsedTime: Number = currTime - prevTime;
			var elapsedEpoch: Number = epoch - prevEpoch;
			
			
			var COS: Number;
			var SIN: Number;
			var MATH_DEG_TO_RAD: Number = 0.0174532925;
			var moveVector: Point3d;
			var quat1: Quaternion;
			
			if(elapsedTime < .1)
			{
				elapsedTime = .1;
			}
			
			var ms:Number = Engine.moveSpeed * elapsedTime;
			var rs:Number = Engine.rotateSpeed * elapsedTime;



			if (Model.W) {

				var deltaX:Number = ms * (rotation.x * rotation.z + rotation.w * rotation.y);
				var deltaY:Number = ms * (rotation.y * rotation.z - rotation.w * rotation.x);
				var deltaZ:Number = (ms/2) - ms * (rotation.x * rotation.x + rotation.y * rotation.y);
				position.x += deltaX;
				position.y += deltaY;
				position.z += deltaZ;

				positionMinusZ.x += deltaX;
				positionMinusZ.y += deltaY;
				positionMinusZ.z += deltaZ;
			}

			if (Model.S) {

				var deltaX:Number = ms * (rotation.x * rotation.z + rotation.w * rotation.y);
				var deltaY:Number = ms * (rotation.y * rotation.z - rotation.w * rotation.x);
				var deltaZ:Number = (ms/2) - ms * (rotation.x * rotation.x + rotation.y * rotation.y);

				position.x -= deltaX;
				position.y -= deltaY;
				position.z -= deltaZ;

				positionMinusZ.x -= deltaX;
				positionMinusZ.y -= deltaY;
				positionMinusZ.z -= deltaZ;
				
			}

			if (Model.A) {
				//strafe left
				//left vector
				var deltaX:Number = (ms/2) - ms * (rotation.y * rotation.y + rotation.z * rotation.z);
				var deltaY:Number = ms * (rotation.x * rotation.y + rotation.w * rotation.z);
				var deltaZ:Number = ms * (rotation.x * rotation.z - rotation.w * rotation.y);

				position.x -= deltaX;
				position.y -= deltaY;
				position.z -= deltaZ;

				positionMinusZ.x -= deltaX;
				positionMinusZ.y -= deltaY;
				positionMinusZ.z -= deltaZ;
				
			}

			if (Model.D) {

				var deltaX:Number = (ms/2) - ms * (rotation.y * rotation.y + rotation.z * rotation.z);
				var deltaY:Number = ms * (rotation.x * rotation.y + rotation.w * rotation.z);
				var deltaZ:Number = ms * (rotation.x * rotation.z - rotation.w * rotation.y);

				position.x += deltaX;
				position.y += deltaY;
				position.z += deltaZ;

				positionMinusZ.x += deltaX;
				positionMinusZ.y += deltaY;
				positionMinusZ.z += deltaZ;
				
			}

			if (Model.up) {
				//rotation.x -= Engine.rotateSpeed;

				//var quat:Quaternion = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(-rs * MATH_DEG_TO_RAD, 0, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/

			}

			if (Model.down) {
				//rotation.x += Engine.rotateSpeed;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(rs * MATH_DEG_TO_RAD, 0, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			if (Model.right) {

				//rotation.y += Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, rs * MATH_DEG_TO_RAD, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/

			}

			if (Model.left) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, -rs * MATH_DEG_TO_RAD, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			if (Model.Q) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, 0, -rs * MATH_DEG_TO_RAD);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			if (Model.E) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, 0, rs * MATH_DEG_TO_RAD);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}
			
			

			/**/
			prevTime = currTime;
			prevEpoch = epoch;
			
		
			
			//trace("pos: ", position.x, position.y, position.z, "rotation:", rotation.x, rotation.y, rotation.z, rotation.w);
			var angleStep:Number = .2;
			var mouseSensitivity:Number = .2;


			
			//cameraLookAt(
			//stage.removeEventListener(Event.ENTER_FRAME, update);
			var mousePosX:Number = theStage.mouseX - (theStage.stageWidth/2);
			var mousePosY:Number = theStage.mouseY - (theStage.stageHeight/2); 

			if(mouseIsDown)
			{
				if (Math.abs(mousePosX - lastMouseX) > 0  && Math.abs(mousePosY - lastMouseY) > 0)
				{
					var p:Point3d =new Point3d(0, EngineMath.degreesToRad(mousePosX * angleStep * mouseSensitivity), 0);
					var quat1:Quaternion = EngineMath.eulerToQuat(p);
					rotation = EngineMath.quatMul(rotation, quat1);
				
					var p2:Point3d =new Point3d(EngineMath.degreesToRad(mousePosY * angleStep * mouseSensitivity),0 , 0);
					var quat2:Quaternion = EngineMath.eulerToQuat(p2);
					//rotation = EngineMath.quatMul(rotation, quat2);		
				}

			}

			

			lastMouseX = mousePosX;
			lastMouseY = mousePosY;

			transformMatrix.createFromTransform(position, rotation, scale);

            /*
				shaker::Quaternion rotation = transformManager->rotation(inst);
                shaker::Quaternion quat1;
                
                bx::EulerToQuat(quat1.val, 0, MATH_DEG_TO_RAD(g_mouseOffset.x * angleStep * mouseSensitivity), 0);
                bx::quatMul(&rotation.x, &rotation.x, &quat1.x);
                
                bx::EulerToQuat(quat1.val, MATH_DEG_TO_RAD(g_mouseOffset.y * angleStep * mouseSensitivity),0 , 0);
                bx::quatMul(&rotation.x, &rotation.x, &quat1.x);
                
                transformManager->setRotation(inst, rotation);


            */

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