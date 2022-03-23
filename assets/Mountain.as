package assets
{
	import flash.display.BitmapData;

	public class Mountain extends GameObject {

		public function Mountain(_positon: Point3d, _rotation: Quaternion, _scale: Point3d, _bd: BitmapData) {
			// constructor code
			position = _positon; //
			rotation = _rotation; //;

			//rotation.y = Math.random();
			scale = _scale;
			bd = _bd;
			/*
			polygons = [


			];
*/
			//the makeup of the polygons is important. they need to be clockwise!
			
			polygons = [

				new Polygon(
					new Point3d(21.21305 * scale.x, 9 * scale.y, 1350.574 * scale.z, 0, 0), 
					new Point3d(-120.2083 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
					new Point3d(-49.4976 * scale.x, -99 * scale.y, 1279.863 * scale.z, 0, 0), 
				bd),
				new Polygon(
					new Point3d(91.92381 * scale.x, -99 * scale.y, 1138.442 * scale.z, 0, 0), 
					new Point3d(21.21315 * scale.x, 9 * scale.y, 1067.731 * scale.z, 0, 0), 
					new Point3d(162.6345 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
				bd),
				new Polygon(
					new Point3d(-120.2083 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
					new Point3d(162.6345 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
					new Point3d(21.21315 * scale.x, 9 * scale.y, 1067.731 * scale.z, 0, 0), 
				bd),
				new Polygon(
					new Point3d(-120.2083 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
					new Point3d(21.21305 * scale.x, 9 * scale.y, 1350.574 * scale.z, 0, 0), 
					new Point3d(162.6345 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
				bd),
				new Polygon(
					new Point3d(-49.4976 * scale.x, -99 * scale.y, 1279.863 * scale.z, 0, 0), 
					new Point3d(162.6345 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
					new Point3d(21.21305 * scale.x, 9 * scale.y, 1350.574 * scale.z, 0, 0), 
				bd),
				new Polygon(
					new Point3d(-49.4976 * scale.x, -99 * scale.y, 1279.863 * scale.z, 0, 0), 
					new Point3d(91.92381 * scale.x, -99 * scale.y, 1138.442 * scale.z, 0, 0), 
					new Point3d(162.6345 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
				bd),
				new Polygon(
					new Point3d(-49.4976 * scale.x, -99 * scale.y, 1279.863 * scale.z, 0, 0), 
					new Point3d(21.21315 * scale.x, 9 * scale.y, 1067.731 * scale.z, 0, 0), 
					new Point3d(91.92381 * scale.x, -99 * scale.y, 1138.442 * scale.z, 0, 0), 
				bd),
				new Polygon(
					new Point3d(-49.4976 * scale.x, -99 * scale.y, 1279.863 * scale.z, 0, 0), 
					new Point3d(-120.2083 * scale.x, 9 * scale.y, 1209.153 * scale.z, 0, 0), 
					new Point3d(21.21315 * scale.x, 9 * scale.y, 1067.731 * scale.z, 0, 0), 
				bd)
			];

			super();
		}

		




	}

}