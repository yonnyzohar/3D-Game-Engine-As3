package {
	import flash.geom.Point;
	import flash.events.*;
	import flash.display.*;
	import flash.geom.Rectangle;
	

	public class Engine extends MovieClip {

		private static var fieldOfView: Number = 45;
		public static var resolutionX: Number;
		public static var resolutionY: Number;
		public static var z0;

		public static var moveSpeed: Number = 1;
		public static var rotateSpeed: Number = 0.001;

		private var gameObjects: Array = [];

		private var camera: Camera;

		private var bmp: Bitmap;
		public static var bd: BitmapData;
		private var zBuffer:Array = [];
		


		public function Engine() {
			// constructor code
			resolutionX = stage.stageWidth;
			resolutionY = stage.stageHeight;
			z0 = (resolutionX / 2.0) / Math.tan(degreesToRad(fieldOfView / 2.0));

			bd = new BitmapData(resolutionX, resolutionY, false);
			bmp = new Bitmap(bd);
			stage.addChild(bmp);
			
			
			var position:Point3d = new Point3d(0, 10, 5000);
			var rotation:Point3d = new Point3d(-1.5, 0, 0);
			var scale:Point3d = new Point3d(1, 1, 1);
			//gameObjects.push(new Plane(position, rotation, scale, img));
			
			var arr:Array = [new Img0(), new Img1(), new Img2(), new Img3()];
			
			var dist:int = 500;
			for(var row:int = 0; row < 5; row++)
			{
				for(var col:int = 0; col < 5; col++)
				{
					position = new Point3d(col * dist, (Math.random() * 500) - 200, dist * row);
					rotation = new Point3d(0, Math.random() * Math.PI, 0);
					scale = new Point3d(1, 1 , 1);
					gameObjects.push(new Cube(position, rotation, scale, arr[int (Math.random() * arr.length)]));
				}
				
			}
			

			camera = new Camera(stage, new Point3d(0, 0, 0), new Point3d(0, 0, 0));

			stage.addEventListener(Event.ENTER_FRAME, update);
		}

		function update(e: Event): void {
			Engine.bd.lock();
			var i: int = 0;
			for(i = 0; i < resolutionX * resolutionY; i++)
			{
				zBuffer[i] = 0;
			}
			
			Engine.bd.fillRect(new Rectangle(0, 0, resolutionX, resolutionY), 0x000000);

			var totalPolygonsPreClip: Array = [];
			for (i = 0; i < gameObjects.length; i++) {
				var go: GameObject = gameObjects[i];
				//this is for updating position, rotation and scale
				go.update();
				camera.update();

				//now we need to get all polygons from all game objects and sort them by average z
				var polygons: Array = go.polygons;
				for (var j: int = 0; j < polygons.length; j++) {
					polygons[j].calculateWorldPos(go.rotation, go.position);
					polygons[j].calculateCameraView(camera);
					totalPolygonsPreClip.push(polygons[j]);

				}
			}

			//sorting by average z will solve most z index issues but not all
			//totalPolygonsPreClip.sortOn("averageZ", Array.NUMERIC | Array.DESCENDING);//, 
			
			var totalPolygons:Array = [];
			for (var j: int = 0; j < totalPolygonsPreClip.length; j++) {
				var polygon: Polygon = totalPolygonsPreClip[j];
				
				var clippedTriangles: Array = polygon.getZClippedTriangles();
				for (var h: int = 0; h < clippedTriangles.length; h++) {
					totalPolygons.push(clippedTriangles[h]);
				}
				/**/
			}

			//we still need to render only the polygons facing us
			//we created the polygon indices in clockwise order sow we can check who is facing us and who is not
			//once we have that we can call draw only on those who face us
			for (i = 0; i < totalPolygons.length; i++) {
				var polygon: Polygon = totalPolygons[i];
				polygon.calculateScreenPos();
				if (polygon.normalZ < 0) {
					var clippedPolygons: Array = polygon.getClippedTriangles();
					for (var j: int = 0; j < clippedPolygons.length; j++) {
						clippedPolygons[j].draw(zBuffer);
					}

				}

			}
			Engine.bd.unlock();
			//stage.removeEventListener(Event.ENTER_FRAME, update);

		}


		public static function translate(orig: Point3d, translation: Point3d): Point3d {
			var newPoint: Point3d = new Point3d(orig.x + translation.x, orig.y + translation.y, orig.z + translation.z, orig.u, orig.v);
			newPoint.w = orig.w;
			return newPoint
		}

		public static function rotate(original: Point3d, rotation: Point3d): Point3d {
			var cos = Math.cos;
			var sin = Math.sin;


			var returnX: Number = original.x * (cos(rotation.z) * cos(rotation.y)) + original.y * (cos(rotation.z) * sin(rotation.y) * sin(rotation.x) - sin(rotation.z) * cos(rotation.x)) + original.z * (cos(rotation.z) * sin(rotation.y) * cos(rotation.x) + sin(rotation.z) * sin(rotation.x));
			var returnY: Number = original.x * (sin(rotation.z) * cos(rotation.y)) + original.y * (sin(rotation.z) * sin(rotation.y) * sin(rotation.x) + cos(rotation.z) * cos(rotation.x)) + original.z * (sin(rotation.z) * sin(rotation.y) * cos(rotation.x) - cos(rotation.z) * sin(rotation.x));
			var returnZ: Number = original.x * (-sin(rotation.y)) + original.y * (cos(rotation.y) * sin(rotation.x)) + original.z * (cos(rotation.y) * cos(rotation.x));

			var newPoint: Point3d = new Point3d(returnX, returnY, returnZ, original.u, original.v);
			newPoint.w = original.w;

			return newPoint;

		}

		public static function applyPerspective(orig: Point3d): Point3d {
			var returnX: Number = orig.x * z0 / (z0 + orig.z);
			var returnY: Number = orig.y * z0 / (z0 + orig.z);
			var returnZ: Number = orig.z;

			//this is to fix texture warping
			var returnU: Number = orig.u * z0 / (z0 + orig.z);
			var returnV: Number = orig.v * z0 / (z0 + orig.z);
			var returnW: Number = orig.w * z0 / (z0 + orig.z);

			var newPoint: Point3d = new Point3d(returnX, returnY, returnZ, returnU, returnV);
			newPoint.w = returnW;

			return newPoint;
		}

		public static function centerScreen(orig: Point3d): Point3d {
			var returnX: Number = orig.x + resolutionX / 2;
			var returnY: Number = orig.y + resolutionY / 2;
			var returnZ: Number = orig.z;

			var newPoint: Point3d = new Point3d(returnX, returnY, returnZ, orig.u, orig.v);
			newPoint.w = orig.w;
			return newPoint;

		}

	

		/////////////////-------------------------/////////////////////////////////
		public static function radToDegrees(rads: Number): Number {
			return rads * 180.0 / Math.PI;
		}

		public static function degreesToRad(degs: Number): Number {
			return degs * Math.PI / 180.0;
		}

		public static function getDistance(p1: Point3d, p2: Point3d): Number {

			var dX: Number = p1.x - p2.x;
			var dY: Number = p1.y - p2.y;
			var dist: Number = Math.sqrt(dX * dX + dY * dY);
			return dist;
		}

	}

}