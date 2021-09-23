package {
	import flash.display.BitmapData;

	public class Cube extends GameObject{

		public function Cube(_positon:Point3d, _rotation:Point3d, _scale:Point3d ,_bd:BitmapData) {
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
			rotation.y += 0.01;
			rotation.x += 0.01;
		}

		



	}

}