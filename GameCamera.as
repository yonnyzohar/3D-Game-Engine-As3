package {
	import flash.events.*;
	import flash.ui.*;
	import flash.display.Stage;
	
	import flash.geom.Vector3D;

	public class GameCamera {

		
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
		

		public function GameCamera(_theStage: Stage, _position: Point3d, _rotation: Quaternion) {
			// constructor code
			theStage = _theStage;
			position = _position;
			rotation = _rotation;
			scale = new Vector3(1, 1, 1);
			
			
			transformMatrix = new Matrix4x4();
			transformMatrix.createFromTransform(position, rotation, scale);
			zNear = (Engine.resolutionX / 2.0) / Math.tan(EngineMath.degreesToRad(fieldOfView / 2.0));
			aspectRatio = Engine.resolutionX / Engine.resolutionY;
			
			//get the field of view from top to bottom
			var oneDivAspectRatio:Number = 1.0/aspectRatio;
			fovY = 2 * Math.atan(Math.tan(EngineMath.degreesToRad(fieldOfView) / 2.0) * oneDivAspectRatio);

			
			positionMinusZ = new Point3d(position.x, position.y, position.z-zNear);
			position.z += zNear;
			positionMinusZ.z += zNear;

		}
	
		


		public function getPosition(): Point3d {
			return positionMinusZ;//MinusZ
		}

		public function getRotation(): Quaternion {
			return rotation;
		}

		private function collidingPlus(dir:Vector3, ms:Number):Boolean
		{
			var isColission:Boolean = false;
			var p:Point3d = new Point3d(positionMinusZ.x + (dir.x *ms), positionMinusZ.y + (dir.y *ms), positionMinusZ.z + (dir.z *ms)  );

			outer : for(var i:int = 0; i < Engine.gO.length; i++)
			{
				var go:GameObject = Engine.gO[i];
				var boundingBox:Object = go.boundingBox;
				if(boundingBox)
				{
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
				if(boundingBox)
				{
					for(var k:String in boundingBox)
					{
						if(boundingBox[k] is Point3d)
						{
							var edgeVertex:Point3d = boundingBox[k];
							isColission = go.checkColission(Engine.translate(edgeVertex, mpZ));
							if(isColission)
							{
								//go.setFrameColor(Math.random() * 0xffffff);
								break outer;
							}
							
						}
					}
				}
				
				
			}
			return isColission;
			
		}

		public function getForwardVector():Vector3
		{
			return transformMatrix.getForwardVector();
		}


		public function update(elapsedTime:Number): void {

			var COS: Number;
			var SIN: Number;
			
			var moveVector: Point3d;
			var quat1: Quaternion;
			
		
			var ms:Number = Engine.moveSpeed * elapsedTime;
			var rs:Number = Engine.rotateSpeed * elapsedTime;
			ms /= 2;



			if (InputHandler.W) {
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

			if (InputHandler.S) {
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

			if (InputHandler.D) {
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


			if (InputHandler.A) {
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

			
			if (InputHandler.up) {

				lookDown(rs);
				
			}

			if (InputHandler.down) {
				lookUp(rs);
				
			}
			/**/

			if (InputHandler.right) {

				//rotation.y += Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, rs * EngineMath.MATH_DEG_TO_RAD, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/

			}

			if (InputHandler.left) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, -rs * EngineMath.MATH_DEG_TO_RAD, 0);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
				/**/
			}

			/*
			if (InputHandler.Q) {
				//rotation.y -= Engine.rotateSpeed * elapsedTime;

				//var quat:Quaternion  = Engine.eulerToQuat(rotation);
				moveVector = new Point3d(0, 0, -rs * MATH_DEG_TO_RAD);
				quat1 = EngineMath.eulerToQuat(moveVector);
				rotation = EngineMath.quatMul(rotation, quat1);
				//rotation = Engine.quatToEuler(res);
			}

			if (InputHandler.E) {
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

		public function lookDown(rs:Number):void
		{
			var moveVector: Point3d;
			var quat1: Quaternion;
			moveVector = new Point3d(-rs * EngineMath.MATH_DEG_TO_RAD, 0, 0);
			quat1 = EngineMath.eulerToQuat(moveVector);
			rotation = EngineMath.quatMul(rotation, quat1);
		}

		public function lookUp(rs:Number):void
		{
			var moveVector: Point3d;
			var quat1: Quaternion;
			moveVector = new Point3d(rs * EngineMath.MATH_DEG_TO_RAD, 0, 0);
			quat1 = EngineMath.eulerToQuat(moveVector);
			rotation = EngineMath.quatMul(rotation, quat1);
		}


		public function cameraLookAt(worldPosition: Vector3): void {
			var destPosition: Vector3 = new Vector3(worldPosition.x, worldPosition.y, worldPosition.z);

			//get the forward vector by subtracting the destination from the current entity
			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);

			rotation = EngineMath.quatLookAt(forward, EngineMath.UP);



		}

		

		

		

	}

}