package  {
	
	import flash.display.BitmapData;
	public class GameObject {
		public var polygons: Array;
		public var position: Point3d;
		public var rotation: Quaternion;
		public var scale:Point3d;
		public var bd:BitmapData;
		public var transformMatrix:Matrix4x4;
		public var boundingBox:Object;
		public var destructable:Boolean = true;
		public var _collideable:Boolean = true;
		
		public function GameObject(_c:Boolean = true) {
			_collideable = _c;
			if(_collideable)
			{
				getBoundingBox(polygons);
				centerMesh(polygons);
				getBoundingBox(polygons);
			}
			
			

			transformMatrix = new Matrix4x4();
			transformMatrix.createFromTransform(position, rotation, scale);
		}

		public function get collideable():Boolean
		{
			return _collideable;
		}

		public function set collideable(val:Boolean):void
		{
			_collideable = val;
			if(val == false)
			{
				boundingBox = null;
			}
		}

		public function setFrameColor(color:uint):void
		{

			for(var i:int = 0; i < polygons.length; i++)
			{
				var polygon:Polygon = polygons[i];
				polygon.setFrameColor(color);
			}
		}

		function centerMesh(_polygons:Array):void
		{
			var bb = boundingBox;
			for(var i:int = 0; i < _polygons.length; i++)
			{
				var polygon:Polygon = _polygons[i];
				for(var j:int = 0; j < 3; j++)
				{
					var p:Point3d = polygon.localPositions[j];
					
					p.x -= bb.minX;
					p.x -= (bb.xDist/2);
					
					p.y -= bb.minY;
					//p.y -= (bb.yDist/2);

					p.z -= bb.minZ;
					p.z -= (bb.zDist/2);
				}
			}
		
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

			boundingBox = {
				"frontBtmLeft"  : new Point3d(minX, minY, minZ),
				"frontTopLeft"  : new Point3d(minX, maxY, minZ),
				"backBtmLeft"   : new Point3d(minX, minY, maxZ),
				"backTopLeft"   : new Point3d(minX, maxY, maxZ),

				"frontBtmRight" : new Point3d(maxX, minY, minZ),
				"frontTopRight" : new Point3d(maxX, maxY, minZ),
				"backTopRight"  : new Point3d(maxX, maxY, maxZ),
				"backBtmRight"  : new Point3d(maxX, minY, maxZ),
				"minX"          : minX,
				"maxX"          : maxX,
				"xDist"         : maxX - minX,
				"minY"          : minY,
				"maxY"          : maxY,
				"yDist"         : maxY - minY,
				"minZ"          : minZ,
				"maxZ"          : maxZ,
				"zDist"         : maxZ - minZ
			};
		}

		public function checkColission(targetPos:Point3d):Boolean
		{
			var bb = boundingBox;
			if(bb == null)
			{
				return false;
			}
			var frontBtmLeft  :Point3d = new Point3d(position.x + bb.frontBtmLeft.x,  position.y + bb.frontBtmLeft.y,   position.z + bb.frontBtmLeft.z);
			var frontTopLeft  :Point3d = new Point3d(position.x + bb.frontTopLeft.x,  position.y + bb.frontTopLeft.y,   position.z + bb.frontTopLeft.z);
			var backBtmLeft   :Point3d = new Point3d(position.x + bb.backBtmLeft.x,   position.y  + bb.backBtmLeft.y,   position.z  + bb.backBtmLeft.z);
			var backTopLeft   :Point3d = new Point3d(position.x + bb.backTopLeft.x,   position.y  + bb.backTopLeft.y,   position.z  + bb.backTopLeft.z);
			var frontBtmRight :Point3d = new Point3d(position.x + bb.frontBtmRight.x, position.y  + bb.frontBtmRight.y, position.z  + bb.frontBtmRight.z);
			var frontTopRight :Point3d = new Point3d(position.x + bb.frontTopRight.x, position.y  + bb.frontTopRight.y, position.z  + bb.frontTopRight.z);
			var backTopRight :Point3d = new Point3d(position.x + bb.backTopRight.x, position.y  + bb.backTopRight.y, position.z  + bb.backTopRight.z);
			var backBtmRight :Point3d = new Point3d(position.x + bb.backBtmRight.x, position.y  + bb.backBtmRight.y, position.z  + bb.backBtmRight.z);


			if( targetPos.x >= frontBtmLeft.x && 
				targetPos.x <= backTopRight.x &&
				targetPos.y >= frontBtmLeft.y &&
				targetPos.y <= frontTopLeft.y &&
				targetPos.z >= frontBtmRight.z &&
				targetPos.z <= backBtmLeft.z

				)
			{
				return true;
			}
			return false;

		}

		
		public function update(elapsedTime:Number): void {

			transformMatrix.createFromTransform(position, rotation, scale);


		}

		

		public function getNextForwardMove(speed:Number):Point3d
		{
			var p:Point3d = new Point3d(position.x, position.y, position.z);
			var forward:Vector3 = transformMatrix.getForwardVector();
			p.x += (forward.x *speed);
			p.y += (forward.y *speed);
			p.z += (forward.z *speed);
			
			return p;
		}

		public function moveForward(speed:Number):void
		{
			//move forwards - some bug here with object shrinking
			
			var forward:Vector3 = transformMatrix.getForwardVector();
			position.x += (forward.x * speed);
			position.y += (forward.y * speed);
			position.z += (forward.z * speed);

			
		}

		public function lookAtCamera():void
		{
			//look at

			var destPosition: Vector3 = Engine.activeCamera.getPosition();

			//get the forward vector by subtracting the destination from the current entity

			var currentRotation:Quaternion = new Quaternion(rotation.x, rotation.y, rotation.z, rotation.w);
			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);
			rotation = EngineMath.quatLookAt(forward, EngineMath.UP);
			

		}

		public function lookAtCameraGradual(rotationSpeed:Number = 0.01):void
		{
			//gradually movr towards camera
			var currentRotation:Quaternion = new Quaternion(rotation.x, rotation.y, rotation.z, rotation.w);
			var destPosition: Vector3 = Engine.activeCamera.getPosition();
			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);

			var rotTowardsCam:Quaternion = EngineMath.quatLookAt(forward, EngineMath.UP);
			//for some reason we need o reverse y rotation...



			rotation = Quaternion.RotateTowards(currentRotation,rotTowardsCam, 1 );
			
		}

		
	}
}
