package  {
	
	import flash.display.BitmapData;
	public class GameObject {
		public var polygons: Array;
		public var position: Point3d;
		public var rotation: Quaternion;
		public var scale:Point3d;
		public var bd:BitmapData;
		public var transformMatrix:Matrix4x4;
		private var boundingBox:Object;
		
		public function GameObject() {
			// constructor code

			getBoundingBox(polygons);

			transformMatrix = new Matrix4x4();
			transformMatrix.createFromTransform(position, rotation, scale);
		}

		function getBoundingBox(_polygons:Array):void
		{
			var minX:Number = Number.MAX_VALUE;
			var maxX:Number = Number.MIN_VALUE;;
			var minY:Number = Number.MAX_VALUE;
			var maxY:Number = Number.MIN_VALUE;
			var minZ:Number = Number.MAX_VALUE;
			var maxZ:Number = Number.MIN_VALUE;

			for(var i:int = 0; i < _polygons.length; i++)
			{
				var polygon:Polygon = _polygons[i];
				for(var j:int = 0; j < 3; j++)
				{
					var p:Point3d = polygon.localPositions[j];
					if(p.x < minX)
					{
						minX = p.x;
					}
					if(p.x > maxX)
					{
						maxX = p.x;
					}

					if(p.y < minY)
					{
						minY = p.y;
					}
					if(p.y > maxY)
					{
						maxY = p.y;
					}

					if(p.z < minZ)
					{
						minZ = p.z;
					}
					if(p.z > maxZ)
					{
						maxZ = p.z;
					}
				}
				
			}

			boundingBox = {"minX" : minX , "maxX":maxX, "minY":minY, "maxY":maxY, "minZ":minZ, "maxZ":maxZ};
		}

		public function checkColission(targetPos:Point3d):Boolean
		{
			var minX:Number = position.x + boundingBox.minX;
			var maxX:Number = position.x + boundingBox.maxX;
			var minY:Number = position.y + boundingBox.minY;
			var maxY:Number = position.y + boundingBox.maxY;
			var minZ:Number = position.z + boundingBox.minZ;
			var maxZ:Number = position.z + boundingBox.maxZ;

			if( targetPos.x > minX && 
				targetPos.x < maxX &&
				targetPos.y > minY &&
				targetPos.y < maxY &&
				targetPos.z > minZ &&
				targetPos.z < maxZ

				)
			{
				return true;
			}
			return false;

		}

		
		public function update(elapsedTime:Number): void {

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

		public function moveForward(speed:Number):void
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
