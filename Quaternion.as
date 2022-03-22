package  {
	
	public class Quaternion {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		public var w:Number = 1;//this is to prevent texture warping when polygon is not directly in front of me
		private static var radToDeg:Number = (180.0 / Math.PI);

		
		public function Quaternion(_x:Number, _y:Number, _z:Number, _w:Number) {

			x = _x;
			y = _y;
			z = _z;
			w = _w;
		}

		

	}
	
}
