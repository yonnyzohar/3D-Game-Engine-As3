package  {
	
	import flash.display.BitmapData;
	public class GameObject {
		public var polygons: Array;
		public var position: Point3d;
		public var rotation: Quaternion;
		public var scale:Point3d;
		public var bd:BitmapData;
		public var transformMatrix:Matrix4x4;
		
		public function GameObject() {
			// constructor code
			transformMatrix = new Matrix4x4();
			transformMatrix.createFromTransform(position, rotation, scale);
		}

		

		
		public function update(): void {

			transformMatrix.createFromTransform(position, rotation, scale);


		}

		public function lookAtCamera():void
		{
			//look at

			var destPosition: Vector3 = Engine.activeCamera.getPosition();

			//get the forward vector by subtracting the destination from the current entity

			var currentRotation:Quaternion = new Quaternion(rotation.x, rotation.y, rotation.z, rotation.w);

			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);

			rotation = EngineMath.quatLookAt(forward, EngineMath.UP);
			//for some reason we need o reverse y rotation...
			//rotation.y *= -1;
			//rotation.z *= -1;

		}

		public function moveForward(speed:Number = 1):void
		{
			//move forwards - some bug here with object shrinking
			
			var forward:Vector3 = transformMatrix.getForwardVector();
			position.x += (forward.x *speed);
			position.y += (forward.y *speed);
			position.z += (forward.z *speed);

			/**/
		}

		public function lookAtCameraGradual(rotationSpeed:Number = 0.01):void
		{
			//gradually movr towards camera
			var currentRotation:Quaternion = new Quaternion(rotation.x, rotation.y, rotation.z, rotation.w);
			var destPosition: Vector3 = Engine.activeCamera.getPosition();
			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);

			var rotTowardsCam:Quaternion = EngineMath.quatLookAt(forward, EngineMath.UP);
			//for some reason we need o reverse y rotation...

			var diff:Quaternion = new Quaternion(
					(rotTowardsCam.x - currentRotation.x) , 
					(rotTowardsCam.y - currentRotation.y),  
					(rotTowardsCam.z - currentRotation.z) , 
					(rotTowardsCam.w - currentRotation.w) 
				);
			
			if(Math.abs(diff.x) > 0.01 || Math.abs(diff.y) > 0.01 || Math.abs(diff.z) > 0.01 || Math.abs(diff.w) > 0.01 )
			{
				rotation.x += (diff.x * rotationSpeed);
				rotation.y += (diff.y * rotationSpeed);
				rotation.z += (diff.z * rotationSpeed);
				rotation.w += (diff.w * rotationSpeed);
			}
			
		}

		
	}
}
