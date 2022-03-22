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

		public static function RotateTowards( from:Quaternion,  to:Quaternion,  maxDegreesDelta:Number)
		{
			var num:Number = Quaternion.Angle(from, to);
			if (num == 0)
			{
				return to;
			}
			var t:Number = Math.min(1, maxDegreesDelta / num);
			return Quaternion.SlerpUnclamped(from, to, t);
		}

		public static function Dot(a:Quaternion , b:Quaternion ):Number
		{
			return a.x * b.x + a.y * b.y + a.z * b.z + a.w * b.w;
		}

		public static function Angle(a:Quaternion , b:Quaternion ):Number
		{
			var f:Number = Quaternion.Dot(a, b);
			return Math.acos(Math.min(Math.abs(f), 1)) * 2 * radToDeg;
		}

		private static function SlerpUnclamped(a: Quaternion , b: Quaternion ,  t:Number):Quaternion
		{
			// if either input is zero, return the other.
			
			if (a.LengthSquared() == 0)
			{
				if (b.LengthSquared() == 0)
				{
					return new Quaternion(0, 0, 0, 1);
				}
				return b;
			}
			else if (b.LengthSquared() == 0.0)
			{
				return a;
			}
			


			var cosHalfAngle:Number = a.w * b.w + EngineMath.vec3Dot(new Vector3(a.x, a.y, a.z),new Vector3(b.x, b.y, b.z));

			if (cosHalfAngle >= 1.0 || cosHalfAngle <= -1.0)
			{
				// angle = 0.0f, so just return one input.
				return a;
			}
			else if (cosHalfAngle < 0.0)
			{
				b.x = -b.x;
				b.y = -b.y;
				b.z = -b.z;
				b.w = -b.w;
				cosHalfAngle = -cosHalfAngle;
			}

			var blendA:Number;
			var blendB:Number;
			if (cosHalfAngle < 0.99)
			{
				// do proper slerp for big angles
				var halfAngle:Number = Math.acos(cosHalfAngle);
				var sinHalfAngle:Number = Math.sin(halfAngle);
				var oneOverSinHalfAngle:Number = 1.0 / sinHalfAngle;
				blendA = Math.sin(halfAngle * (1.0 - t)) * oneOverSinHalfAngle;
				blendB = Math.sin(halfAngle * t) * oneOverSinHalfAngle;
			}
			else
			{
				// do lerp if angle is really small.
				blendA = 1.0 - t;
				blendB = t;
			}

			var n1X:Number = blendA * a.x;
			var n1Y:Number = blendA * a.y;
			var n1Z:Number = blendA * a.z;

			var n2X:Number = blendB * b.x;
			var n2Y:Number = blendB * b.y;
			var n2Z:Number = blendB * b.z;

			var result:Quaternion = new Quaternion(n1X + n2X, n1Y+n2Y, n1Z+n2Z, blendA * a.w + blendB * b.w);
			if (result.LengthSquared() > 0)
			{
				return Normalize(result);
			}
			else
			{
				return new Quaternion(0, 0, 0, 1);
			}
		}

		public function Length():Number
		{
			
			return Math.sqrt(x * x + y * y + z * z + w * w);
			
		}

		public function LengthSquared():Number
		{
			
			return x * x + y * y + z * z + w * w;
			
		}

		public static function Normalize(q:Quaternion):Quaternion
		{
			var scale:Number = 1.0 / q.Length();
			q.x *= scale;
			q.y *= scale;
			q.z *= scale;
			q.w *= scale;
			return q;
		}



	}
	
}
