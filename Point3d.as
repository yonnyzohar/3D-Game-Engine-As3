package  {
	
	public class Point3d {
		
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public var u:Number;
		public var v:Number;
		public var w:Number = 1;//this is to prevent texture warping when polygon is not directly in front of me

		public function Point3d(_x:Number, _y:Number, _z:Number, _u:Number = 0, _v:Number = 0) {
			x = _x;
			y = _y;
			z = _z;
			u = _u;
			v = _v;
		}

	}
	
}
