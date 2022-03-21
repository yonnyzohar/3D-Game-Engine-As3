package {
	import flash.geom.Point;
	import flash.events.*;
	import flash.display.*;
	import flash.geom.Rectangle;
	import assets.Cube;
	import assets.Mountains;


	public class BattleZone extends Engine {

		private var tileSize:Number = 300;
		private var map:Array = [
			[0,1,1,1,1,1,1,1,1,1,1],
			[0,0,0,0,0,0,0,0,0,0,1],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,1],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,2,0,0,0,0,1],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,1],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,1]


		];

		private var initialCamPosX:Number;
		private var initialCamPosZ:Number;

		override protected function initGameObjects():void
		{
			var arr: Array = [new Img0(), new Img1(), new Img2(), new Img3(), new Img4, new Img5()];

			for(var row:int = 0; row < map.length; row++)
			{
				for(var col:int = 0; col < map[row].length; col++)
				{
					var _z:Number = col * tileSize;
					var _x:Number = row * tileSize;
					var position: Point3d = new Point3d(_x, 0, _z);
					var rotation: Quaternion = new Quaternion(0, 0, 0, 1);
					var scale: Point3d = new Point3d(1, 1, 1);

					if(map[row][col] == 1)
					{
						var cube: Cube = new Cube(position, rotation, scale, arr[0])
						gameObjects.push(cube);
					}
					if(map[row][col] == 2)
					{
						initialCamPosZ = col * tileSize;
						initialCamPosX = row * tileSize;
						


						//var m: Mountains = new Mountains(position, rotation, scale,  arr[1])
						//gameObjects.push(m);
					}
				}
			}
		}

		override protected function initCamera():void
		{
				var camPos: Point3d = new Point3d(initialCamPosX, 0, initialCamPosZ);
				var camRot: Quaternion = new Quaternion(0, 0, 0, 1);

				camera = new Camera(stage, camPos, camRot);
				activeCamera = camera;
		}
	}
}