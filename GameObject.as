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
		
		
	}
	
}
