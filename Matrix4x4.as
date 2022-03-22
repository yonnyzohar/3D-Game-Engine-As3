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

		public function getForwardVector():Vector3
		{
			var res:Vector3 = new Vector3(c1, c2,c3);
			return res;
		}

		public function getTranslation():Vector3
	    {
	    	var res:Vector3 = new Vector3(d1, d2,d3);
	       	return res;
	    }
	    
	    public function getRightVector():Vector3
	    {
	        var res:Vector3 = new Vector3(a1, a2,a3);
	       	return res;
	    }

	    public function getUpVector():Vector3
	    {
	        var res:Vector3 = new Vector3(b1, b2,b3);
	       	return res;
	    }
/*
    bool decompose(Vector3* translation, Quaternion* rotation, Vector3* scale)
    {
        if (translation)
        {
            // Extract the translation.
            translation->x = un.val[12];
            translation->y = un.val[13];
            translation->z = un.val[14];
        }
        
        // Nothing left to do.
        if (scale == NULL && rotation == NULL)
            return true;
        
        
        // Extract the scale.
        // This is simply the length of each axis (row/column) in the matrix.
        Vector3 xaxis(un.val[0], un.val[1], un.val[2]);
        float scaleX = sqrt(xaxis.x * xaxis.x + xaxis.y * xaxis.y + xaxis.z * xaxis.z);

        Vector3 yaxis(un.val[4], un.val[5], un.val[6]);
        float scaleY = sqrt(yaxis.x * yaxis.x + yaxis.y * yaxis.y + yaxis.z * yaxis.z);

        Vector3 zaxis(un.val[8], un.val[9], un.val[10]);
        float scaleZ = sqrt(zaxis.x * zaxis.x + zaxis.y * zaxis.y + zaxis.z * zaxis.z);

        // Determine if we have a negative scale (true if determinant is less than zero).
        // In this case, we simply negate a single axis of the scale.
        float det = determinant();
        if (det < 0)
            scaleZ = -scaleZ;

        if (scale)
        {
            scale->x = scaleX;
            scale->y = scaleY;
            scale->z = scaleZ;
        }

        // Nothing left to do.
        if (rotation == NULL)
            return true;

        // Scale too close to zero, can't decompose rotation.
        if (scaleX < MATH_TOLERANCE || scaleY < MATH_TOLERANCE || fabs(scaleZ) < MATH_TOLERANCE)
            return false;

        float rn;

        // Factor the scale out of the matrix axes.
        rn = 1.0f / scaleX;
        xaxis.x *= rn;
        xaxis.y *= rn;
        xaxis.z *= rn;

        rn = 1.0f / scaleY;
        yaxis.x *= rn;
        yaxis.y *= rn;
        yaxis.z *= rn;

        rn = 1.0f / scaleZ;
        zaxis.x *= rn;
        zaxis.y *= rn;
        zaxis.z *= rn;

        // Now calculate the rotation from the resulting matrix (axes).
        float trace = xaxis.x + yaxis.y + zaxis.z + 1.0f;

        if (trace > MATH_EPSILON)
        {
            float s = 0.5f / sqrt(trace);
            rotation->w = 0.25f / s;
            rotation->x = (yaxis.z - zaxis.y) * s;
            rotation->y = (zaxis.x - xaxis.z) * s;
            rotation->z = (xaxis.y - yaxis.x) * s;
        }
        else
        {
            // Note: since xaxis, yaxis, and zaxis are normalized,
            // we will never divide by zero in the code below.
            if (xaxis.x > yaxis.y && xaxis.x > zaxis.z)
            {
                float s = 0.5f / sqrt(1.0f + xaxis.x - yaxis.y - zaxis.z);
                rotation->w = (yaxis.z - zaxis.y) * s;
                rotation->x = 0.25f / s;
                rotation->y = (yaxis.x + xaxis.y) * s;
                rotation->z = (zaxis.x + xaxis.z) * s;
            }
            else if (yaxis.y > zaxis.z)
            {
                float s = 0.5f / sqrt(1.0f + yaxis.y - xaxis.x - zaxis.z);
                rotation->w = (zaxis.x - xaxis.z) * s;
                rotation->x = (yaxis.x + xaxis.y) * s;
                rotation->y = 0.25f / s;
                rotation->z = (zaxis.y + yaxis.z) * s;
            }
            else
            {
                float s = 0.5f / sqrt(1.0f + zaxis.z - xaxis.x - yaxis.y );
                rotation->w = (xaxis.y - yaxis.x ) * s;
                rotation->x = (zaxis.x + xaxis.z ) * s;
                rotation->y = (zaxis.y + yaxis.z ) * s;
                rotation->z = 0.25f / s;
            }
        }
        return true;
    }
    */


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