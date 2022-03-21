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
			var destPosition: Vector3 = new Vector3(Engine.activeCamera.position.x, Engine.activeCamera.position.y, Engine.activeCamera.position.z);

			//get the forward vector by subtracting the destination from the current entity
			var forward: Vector3 = EngineMath.vec3Sub(destPosition, position);

			rotation = EngineMath.quatLookAt(forward, EngineMath.UP);
			//for some reason we need o reverse y rotation...
			rotation.y *= -1;
			rotation.z *= -1;

		}
	}
}
