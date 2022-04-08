﻿package game
{
	import flash.display.BitmapData;

	public class Tank extends GameObject {

		var cnt:int = 0;
		private var gun:Gun;

		public function Tank(_positon: Point3d, _rotation: Quaternion, _scale: Point3d, _bd: BitmapData) {
			// constructor code
			position = _positon; //
			rotation = _rotation; //;
			scale = _scale;
			bd = _bd;
			gun = new Gun();

			/**/
			polygons = [

new Polygon(new Point3d(-310 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-310 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-310 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), new Point3d(-310 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), new Point3d(-310 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), new Point3d(-310 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-110 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-110 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-110 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), new Point3d(-110 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), new Point3d(-110 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), new Point3d(-110 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-198.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-198.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-198.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 528.3002 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-310 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), new Point3d(-110 * scale.x, -99.99995 * scale.y, 410 * scale.z, 0, 0), new Point3d(-310 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), new Point3d(-110 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), new Point3d(-110 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), new Point3d(-310 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), new Point3d(-110 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-310 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99998 * scale.y, 210 * scale.z, 0, 0), new Point3d(-110 * scale.x, 2.384186E-05 * scale.y, 210 * scale.z, 0, 0), bd),new Polygon(new Point3d(-198.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -140 * scale.y, 528.3001 * scale.z, 0, 0), bd),
new Polygon(new Point3d(-310 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), new Point3d(-110 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), new Point3d(-310 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), new Point3d(-110 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), new Point3d(-110 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), bd),new Polygon(new Point3d(-280 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-280 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-280 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-175 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-140 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-140 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), new Point3d(-140 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-228.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-280 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-280 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-175 * scale.x, -110 * scale.y, 250 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), new Point3d(-140 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-175 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-140 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-198.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -110 * scale.y, 348.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-280 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), new Point3d(-175 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-175 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), new Point3d(-175 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-140 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -160 * scale.y, 250 * scale.z, 0, 0), bd),new Polygon(new Point3d(-280 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-280 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-280 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-245 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-228.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-245 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-175 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-198.3 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-198.3 * scale.x, -140 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-175 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-175 * scale.x, -160 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-140 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-175 * scale.x, -110 * scale.y, 366.6001 * scale.z, 0, 0), new Point3d(-140 * scale.x, -160 * scale.y, 308.3001 * scale.z, 0, 0), new Point3d(-140 * scale.x, -110 * scale.y, 308.3001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-110 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), new Point3d(-110 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), new Point3d(-110 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-110 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), new Point3d(-110 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-110 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), new Point3d(-310 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), new Point3d(-310 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), new Point3d(-310 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-310 * scale.x, 4.768372E-05 * scale.y, 401.63 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, -0.01993179 * scale.y, 400.03 * scale.z, 0, 0), new Point3d(-310 * scale.x, -99.99995 * scale.y, 402.4701 * scale.z, 0, 0), new Point3d(-310 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), bd),new Polygon(new Point3d(-110 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-110 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), new Point3d(-310 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), bd),new Polygon(new Point3d(-310 * scale.x, 1.730061 * scale.y, 540.0001 * scale.z, 0, 0), new Point3d(-310 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), new Point3d(-110 * scale.x, -94.42997 * scale.y, 410 * scale.z, 0, 0), bd)

			];
			
			

			super();
		}

		
		override public function update(elapsedTime:Number): void {
			var ms:Number = Engine.moveSpeed * elapsedTime/50;
			var rs:Number = Engine.rotateSpeed * elapsedTime;

			cnt++;

			if(cnt % 100 == 0)
			{
				/*
				var camRotY:Number = EngineMath.quatToEuler(Engine.activeCamera.getRotation()).y;

				if(camRotY > Math.PI*2)
				{
					camRotY = camRotY - Math.PI*2;
				}
				if(camRotY < 0 )
				{
					camRotY = camRotY + Math.PI*2;
				}

				var tankY:Number = EngineMath.quatToEuler(rotation).y;
				tankY *= -1;

				if(tankY > Math.PI*2)
				{
					tankY = tankY - Math.PI*2;
				}
				if(tankY < 0 )
				{
					tankY = tankY + Math.PI*2;
				}
				*/

				var r:Quaternion = getInverseYRotation(rotation);
				//set true matrix
				var t:Matrix4x4 = new Matrix4x4();
				t.createFromTransform(position, r, scale);
				//get forward vector
				var forward:Vector3 = t.getForwardVector();


				var dot:Number = EngineMath.vec3Dot(forward, Engine.activeCamera.getForwardVector());
				trace( dot);
				if(dot < -0.8)
				{
					moveBackWards(Engine.moveSpeed, true);
					gun.fire(position, getInverseYRotation(rotation), this);
				}
				cnt = 0;

				
			}

			//lookAt(Engine.activeCamera.getPosition());
			lookAtCameraGradual();

			moveForward(ms, true);

			

			

			
			super.update(elapsedTime)

		}
	}
}