package {
	import flash.display.BitmapData;

	public class Cube extends GameObject{

		public function Cube(_positon:Point3d, _rotation:Quaternion, _scale:Point3d ,_bd:BitmapData) {
			// constructor code
			position = _positon;//
			rotation = _rotation;//;
			scale = _scale;
			bd = _bd;


			//the makeup of the polygons is important. they need to be clockwise!
			polygons = [
			
				//front
				new Polygon(new Point3d(-100 * scale.x, -100 * scale.y, -100 * scale.z, 0, 0), new Point3d(-100* scale.x, 100 * scale.y, -100 * scale.z, 0, 1), new Point3d(100* scale.x, -100 * scale.y, -100 * scale.z, 1, 0), bd),
				new Polygon(new Point3d(-100* scale.x, 100 * scale.y, -100 * scale.z, 0, 1), new Point3d(100* scale.x, 100 * scale.y, -100 * scale.z, 1, 1), new Point3d(100* scale.x, -100 * scale.y, -100 * scale.z, 1, 0), bd),
				// back
				new Polygon(new Point3d(100* scale.x, -100 * scale.y, 100 * scale.z, 1, 0), new Point3d(-100* scale.x, 100 * scale.y, 100 * scale.z, 0, 1), new Point3d(-100* scale.x, -100 * scale.y, 100 * scale.z, 0, 0), bd),
				new Polygon(new Point3d(100* scale.x, -100 * scale.y, 100 * scale.z, 1, 0), new Point3d(100* scale.x, 100 * scale.y, 100 * scale.z, 1, 1), new Point3d(-100* scale.x, 100 * scale.y, 100 * scale.z, 0, 1), bd),
				// left
				new Polygon(new Point3d(-100* scale.x, -100 * scale.y, 100 * scale.z, 0, 1), new Point3d(-100* scale.x, -100 * scale.y, -100 * scale.z, 0, 0), new Point3d(100* scale.x, -100 * scale.y, 100 * scale.z, 1, 1), bd),
				new Polygon(new Point3d(-100* scale.x, -100 * scale.y, -100 * scale.z, 0, 0), new Point3d(100* scale.x, -100 * scale.y, -100 * scale.z, 1, 0), new Point3d(100* scale.x, -100 * scale.y, 100 * scale.z, 1, 1), bd),
				// right
				new Polygon(new Point3d(-100* scale.x, 100 * scale.y, -100 * scale.z, 0, 0), new Point3d(100* scale.x, 100 * scale.y, 100 * scale.z, 1, 1), new Point3d(100* scale.x, 100 * scale.y, -100 * scale.z, 1, 0), bd),
				new Polygon(new Point3d(-100* scale.x, 100 * scale.y, -100 * scale.z, 0, 0), new Point3d(-100* scale.x, 100 * scale.y, 100 * scale.z, 0, 1), new Point3d(100* scale.x, 100 * scale.y, 100 * scale.z, 1, 1), bd),
				// top
				new Polygon(new Point3d(-100* scale.x, -100 * scale.y, 100 * scale.z, 0, 1), new Point3d(-100* scale.x, 100 * scale.y, -100 * scale.z, 1, 0), new Point3d(-100* scale.x, -100 * scale.y, -100 * scale.z, 0, 0), bd),
				new Polygon(new Point3d(-100* scale.x, -100 * scale.y, 100 * scale.z, 0, 1), new Point3d(-100* scale.x, 100 * scale.y, 100 * scale.z, 1, 1), new Point3d(-100* scale.x, 100 * scale.y, -100 * scale.z,1, 0), bd),
				// bottom
				new Polygon(new Point3d(100* scale.x, -100 * scale.y, -100 * scale.z, 0, 0), new Point3d(100* scale.x, 100 * scale.y, -100 * scale.z, 1, 0), new Point3d(100* scale.x, -100 * scale.y, 100 * scale.z, 0, 1), bd),
				new Polygon(new Point3d(100* scale.x, -100 * scale.y, 100 * scale.z, 0, 1), new Point3d(100* scale.x, 100 * scale.y, -100 * scale.z, 1, 0), new Point3d(100* scale.x, 100 * scale.y, 100 * scale.z, 1, 1), bd)


						
			

			];
		}

		override public function update(): void {
			var MATH_DEG_TO_RAD:Number =  0.0174532925;
			var moveVector:Point3d = new Point3d(0, -Engine.rotateSpeed *MATH_DEG_TO_RAD, 0);
			var quat1:Quaternion = EngineMath.eulerToQuat( moveVector);
			rotation = EngineMath.quatMul( rotation, quat1);
		}

		



	}

}