package {
	import flash.display.BitmapData;

	public class Plane extends GameObject{

		public function Plane(_positon:Point3d, _rotation:Point3d, _scale:Point3d, _bd:BitmapData) {
			// constructor code
			position = _positon;//
			rotation = _rotation;//;
			scale = _scale;
			bd = _bd;


			//the makeup of the polygons is important. they need to be clockwise!
			polygons = [
			
				new Polygon(new Point3d(-200 * scale.x, -200 * scale.y, -200 * scale.z, 0, 0), new Point3d(-200* scale.x, 200 * scale.y, -200 * scale.z, 0, 1), new Point3d(200* scale.x, -200 * scale.y, -200 * scale.z, 1, 0), bd),
				new Polygon(new Point3d(-200* scale.x, 200 * scale.y, -200 * scale.z, 0, 1), new Point3d(200* scale.x, 200 * scale.y, -200 * scale.z, 1, 1), new Point3d(200* scale.x, -200 * scale.y, -200 * scale.z, 1, 0), bd),
			];
		}

		override public function update(): void {
			//rotation.y += 0.01;
			//rotation.x += 0.01;
		}

		



	}

}