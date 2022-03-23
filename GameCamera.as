package {
	import flash.events.*;
	import flash.ui.*;
	import flash.display.Stage;
	
	import flash.geom.Vector3D;

	public class GameCamera {

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

		
		public var transformMatrix: Matrix4x4;
		private var theStage: Stage;

		public var zNear;
		public var zFar = 10000;
		private var fieldOfView: Number = 30;

		public var aspectRatio:Number ;
		public var fovY:Number;
		private var lastMouseX:Number = 0;
		private var lastMouseY:Number = 0;
		private var mouseIsDown:Boolean = false;

		public function GameCamera(_theStage: Stage, _position: Point3d, _rotation: Quaternion) {
			// constructor code
			theStage = _theStage;
			position = _position;
			rotation = _rotation;
			scale = new Vector3(1, 1, 1);
			_theStage.addEventListener(KeyboardEvent.KEY_DOWN, myKeyDown);
			_theStage.addEventListener(KeyboardEvent.KEY_UP, myKeyUp);
			_theStage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_theStage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			transformMatrix = new Matrix4x4();
			transformMatrix.createFromTransform(position, rotation, scale);
			zNear = (Engine.resolutionX / 2.0) / Math.tan(EngineMath.degreesToRad(fieldOfView / 2.0));
			aspectRatio = Engine.resolutionX / Engine.resolutionY;
			
			//get the field of view from top to bottom
			var oneDivAspectRatio:Number = 1.0/aspectRatio;
			fovY = 2 * Math.atan(Math.tan(EngineMath.degreesToRad(fieldOfView) / 2.0) * oneDivAspectRatio);

			
			positionMinusZ = new Point3d(position.x, position.y, position.z);
			position.z += zNear;

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

		private function collidingPlus(dir:Vector3, ms:Number):Boolean
		{
			var isColission:Boolean = false;
			var p:Point3d = new Point3d(position.x + (dir.x *ms), position.y + (dir.y *ms), position.z + (dir.z *ms)  );

			outer : for(var i:int = 0; i < Engine.gO.length; i++)
			{
				var go:GameObject = Engine.gO[i];
				var boundingBox:Object = go.boundingBox;
				for(var k:String in boundingBox)
				{
					if(boundingBox[k] is Point3d)
					{
						var edgeVertex:Point3d = boundingBox[k];
						isColission = go.checkColission(Engine.translate(edgeVertex, p));
						if(isColission)
						{
							break outer;
						}

					}
				}
				
			}
			return isColission;
			
		}

		private function collidingMinus(dir:Vector3, ms:Number):Boolean
		{
			var isColission:Boolean = false;
			var mpZ:Point3d = new Point3d(positionMinusZ.x - (dir.x *ms), positionMinusZ.y - (dir.y *ms), positionMinusZ.z - (dir.z *ms)  );

			outer : for(var i:int = 0; i < Engine.gO.length; i++)
			{
				var go:GameObject = Engine.gO[i];
				var boundingBox:Object = go.boundingBox;
				for(var k:String in boundingBox)
				{
					if(boundingBox[k] is Point3d)
					{
						var edgeVertex:Point3d = boundingBox[k];
						isColission = go.checkColission(Engine.translate(edgeVertex, mpZ));
						if(isColission)
						{
							break outer;
						}
						
					}
				}
				
			}
			return isColission;
			
		}


		public function update(elapsedTime:Number): void {

			var COS: Number;
			var SIN: Number;
			var MATH_DEG_TO_RAD: Number = 0.0174532925;
			var moveVector: Point3d;
			var quat1: Quaternion;
			
		
			var ms:Number = Engine.moveSpeed * elapsedTime;
			var rs:Number = Engine.rotateSpeed * elapsedTime;
			ms /= 2;



			if (Model.W) {
				/*
				var deltaX:Number = ms * (rotation.x * rotation.z + rotation.w * rotation.y);
				var deltaY:Number = ms * (rotation.y * rotation.z - rotation.w * rotation.x);
				var deltaZ:Number = (ms/2) - ms * (rotation.x * rotation.x + rotation.y * rotation.y);
				position.x += deltaX;
				position.y += deltaY;
				position.z += deltaZ;

				positionMinusZ.x += deltaX;
				positionMinusZ.y += deltaY;
				positionMinusZ.z += deltaZ;
				*/
				var forward:Vector3 = transformMatrix.getForwardVector();
				if(!collidingPlus(forward, ms))
				{
					
					position.x += (forward.x *ms);
					position.y += (forward.y *ms);
					position.z += (forward.z *ms);

					positionMinusZ.x += (forward.x *ms);
					positionMinusZ.y += (forward.y *ms);
					positionMinusZ.z += (forward.z *ms);


				}

				
			}

			if (Model.S) {
				/*
				var deltaX:Number = ms * (rotation.x * rotation.z + rotation.w * rotation.y);
				var deltaY:Number = ms * (rotation.y * rotation.z - rotation.w * rotation.x);
				var deltaZ:Number = (ms/2) - ms * (rotation.x * rotation.x + rotation.y * rotation.y);

				position.x -= deltaX;
				position.y -= deltaY;
				position.z -= deltaZ;

				positionMinusZ.x -= deltaX;
				positionMinusZ.y -= deltaY;
				positionMinusZ.z -= deltaZ;
				*/
				var forward:Vector3 = transformMatrix.getForwardVector();
				if(!collidingMinus(forward, ms))
				{
					position.x -= (forward.x *ms);
					position.y -= (forward.y *ms);
					position.z -= (forward.z *ms);

					positionMinusZ.x -= (forward.x *ms);
					positionMinusZ.y -= (forward.y *ms);
					positionMinusZ.z -= (forward.z *ms);
				}
				
				
			}

			if (Model.D) {
				/*
				var deltaX:Number = (ms/2) - ms * (rotation.y * rotation.y + rotation.z * rotation.z);
				var deltaY:Number = ms * (rotation.x * rotation.y + rotation.w * rotation.z);
				var deltaZ:Number = ms * (rotation.x * rotation.z - rotation.w * rotation.y);

				position.x += deltaX;
				position.y += deltaY;
				position.z += deltaZ;

				positionMinusZ.x += deltaX;
				positionMinusZ.y += deltaY;
				positionMinusZ.z += deltaZ;
				*/
				var right:Vector3 = transformMatrix.getRightVector();
				if(!collidingPlus(right, ms))
				{
					position.x += (right.x *ms);
					position.y += (right.y *ms);
					position.z += (right.z *ms);

					positionMinusZ.x += (right.x *ms);
					positionMinusZ.y += (right.y *ms);
					positionMinusZ.z += (right.z *ms);
				}
				
				
			}


			if (Model.A) {
				//strafe left
				//left vector
				/*
				var deltaX:Number = (ms/2) - ms * (rotation.y * rotation.y + rotation.z * rotation.z);
				var deltaY:Number = ms * (rotation.x * rotation.y + rotation.w * rotation.z);
				var deltaZ:Number = ms * (rotation.x * rotation.z - rotation.w * rotation.y);

				position.x -= deltaX;
				position.y -= deltaY;
				position.z -= deltaZ;

				positionMinusZ.x -= deltaX;
				positionMinusZ.y -= deltaY;
				positionMinusZ.z -= deltaZ;
				*/
				var right:Vector3 = transformMatrix.getRightVector();
				if(!collidingMinus(right, ms))
				{
					position.x -= (right.x *ms);
					position.y -= (right.y *ms);
					position.z -= (right.z *ms);

					positionMinusZ.x -= (right.x *ms);
					positionMinusZ.y -= (right.y *ms);
					positionMinusZ.z -= (right.z *ms);
				}
				
				
			}

			
			if (Model.up) {

				moveVector = new Point3d(-rs * MATH_DEG_TO_RAD, 0, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
			}

			if (Model.down) {
				moveVector = new Point3d(rs * MATH_DEG_TO_RAD, 0, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
			}
			/**/

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

			/*
			if (Model.Q) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, 0, -rs * MATH_DEG_TO_RAD);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
			}

			if (Model.E) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, 0, rs * MATH_DEG_TO_RAD);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
			}
			
			*/

			//trace("pos: ", position.x, position.y, position.z, "rotation:", rotation.x, rotation.y, rotation.z, rotation.w);
			var angleStep:Number = .2;
			var mouseSensitivity:Number = .2;


			/*
		
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
			*/

			transformMatrix.createFromTransform(position, rotation, scale);

		}

		public function cameraLookAt(worldPosition: Vector3): void {
			var destPosition: Vector3 = new Vector3(worldPosition.x, worldPosition.y, worldPosition.z);

			//get the forward vector by subtracting the destination from the current entity
			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);

			rotation = EngineMath.quatLookAt(forward, EngineMath.UP);



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
			if(e.keyCode == Keyboard.SPACE)
			{
				onSpacePressed();
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
		protected function onSpacePressed():void
		{

		}

		protected function onSpaceReleased():void
		{

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

			if(e.keyCode == Keyboard.SPACE)
			{
				onSpaceReleased();
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