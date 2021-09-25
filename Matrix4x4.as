package {

	public class Matrix4x4 {
		
		public var a1:Number;
		public var a2:Number;
		public var a3:Number;
		public var a4:Number;
		
		public var b1:Number;
		public var b2:Number;
		public var b3:Number; 
		public var b4:Number;
		
		public var c1:Number
		public var c2:Number;
		public var c3:Number;
		public var c4:Number;
		
		public var d1:Number
		public var d2:Number;
		public var d3:Number;
		public var d4:Number;
		
		public function Matrix4x4() {
			// constructor code
		}

		public function createFromTransform(pos: Vector3 , rot: Quaternion , scale : Vector3 ):void {
			var m:Matrix4x4 = createRotation(rot);

			var sx:Number = scale.x;
			var sy:Number = scale.y;
			var sz:Number = scale.z;

			var tx:Number = pos.x;
			var ty:Number = pos.y;
			var tz:Number = pos.z;

			a1 = m.a1 * sx;
			a2 = m.a2 * sx;
			a3 = m.a3 * sx;
			d1 = tx;

			b1 = m.b1 * sy;
			b2 = m.b2 * sy;
			b3 = m.b3 * sy;
			d2 = ty;

			c1 = m.c1 * sz;
			c2 = m.c2 * sz;
			c3 = m.c3 * sz;
			d3 = tz;

			a4 = (0.0);
			b4 = (0.0);
			c4 = (0.0);
			d4 = (1.0);
		}

		public function createRotation(quat: Quaternion):Matrix4x4 
		{
			var m:Matrix4x4 = new Matrix4x4();
			var x:Number = quat.x;
			var y:Number = quat.y;
			var z:Number = quat.z;
			var w:Number = quat.w;

			m.a1 = (1.0) - (2.0) * (y * y + z * z);
			m.a2 = (2.0) * (x * y + z * w);
			m.a3 = (2.0) * (x * z - y * w);

			m.b1 = (2.0) * (x * y - z * w);
			m.b2 = (1.0) - (2.0) * (x * x + z * z);
			m.b3 = (2.0) * (y * z + x * w);

			m.c1 = (2.0) * (x * z + y * w);
			m.c2 = (2.0) * (y * z - x * w);
			m.c3 = (1.0) - (2.0) * (x * x + y * y);
			return m;
		}

	}

}