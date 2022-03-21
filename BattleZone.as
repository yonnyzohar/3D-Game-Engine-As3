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
			[0,0,0,0,0,0,0,0,0,0,1],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,1],
			[0,0,0,0,0,0,0,0,0,0,0],
			[2,0,0,0,0,0,0,0,0,0,1]


		];
		public function BattleZone()
		{
			super();

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
						var _z:Number = col * tileSize;
						var _x:Number = row * tileSize;
						activeCamera.position.x = _x;
						activeCamera.position.z = _z;
						var pointEuler:Point3d = EngineMath.quatToEuler(activeCamera.rotation);

						//var m: Mountains = new Mountains(position, rotation, scale,  arr[1])
						//gameObjects.push(m);
					}
				}
			}

			
			//var girl:Girl = new Girl(position, rotation, new Point3d(20, 20, 20), arr[int(Math.random() * arr.length)]);
			//gameObjects.push(girl);
			
			//arr[int(Math.random() * arr.length)]
		/*
			var position: Point3d = new Point3d(activeCamera.position.x, activeCamera.position.y, activeCamera.position.z);
			var rotation: Quaternion = new Quaternion(0, 0, 0, 1);
			var scale: Point3d = new Point3d(1, 1, 1);
			var sphere: Sphere = new Sphere(position, rotation, scale, null)
			gameObjects.push(sphere);
		*/
		}
	}
}