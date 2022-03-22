package {
	import flash.geom.Point;
	import flash.events.*;
	import flash.display.*;
	import flash.geom.Rectangle;
	import assets.Cube;


	public class BattleZone extends Engine {

		protected var player: Player;
		private var tileSize:Number = 200;
		private var map:Array = [
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,2,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0],
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
					}
				}
			}
		}

		override protected function initCamera():void
		{
			var camPos: Point3d = new Point3d(initialCamPosX, 0, initialCamPosZ);
			var camRot: Quaternion = new Quaternion(0, 0, 0, 1);

			player = new Player(stage, camPos, camRot);
			activeCamera = player as GameCamera;
		}

		private function drawLine(start:Vector3, end:Vector3):void
		{
			var distanceH: Number = EngineMath.getDistance(start, end);
			var distanceX: Number = end.x - start.x;
			var distanceY: Number = end.y - start.y;

			var cos: Number = distanceX / distanceH;
			var sin: Number = distanceY / distanceH;

			var startX: Number = start.x;
			var startY: Number = start.y;

			for (var i: int = 0; i < distanceH; i++) {
				Engine.bd.setPixel(startX, startY, 0xffffff);
				startX += cos;
				startY += sin;
			}
		}


		override public function lateUpdate():void
		{
			var shrinkScale:Number = 0.05;

			var camPosX:int = int(activeCamera.getPosition().z*shrinkScale);
			var camPosY:int = int(activeCamera.getPosition().x*shrinkScale);

			

			var rot:Point3d = EngineMath.quatToEuler(activeCamera.rotation);
			for(var j:int = 1; j < 10; j++)
			{
				var newX:int = Math.cos(rot.y) * j;
				var newY:int = Math.sin(rot.y) * j;
				Engine.bd.setPixel(camPosX+newX, camPosY+newY, 0xff0000);
			}

			Engine.bd.setPixel(camPosX, camPosY, 0xffff00);


			for(var i:int = 0; i < gameObjects.length; i++)
			{
				var boundingBox:Object = gameObjects[i].boundingBox;
				var position:Point3d = gameObjects[i].position;


				var minZ:Number = (position.z + boundingBox.frontBtmLeft.z)*shrinkScale;
				var maxZ:Number = (position.z + boundingBox.backBtmLeft.z)*shrinkScale;

				var minX:Number = (position.x + boundingBox.frontBtmLeft.x)*shrinkScale;
				var maxX:Number = (position.x + boundingBox.backBtmRight.x)*shrinkScale;
				

				drawLine( new Vector3(minZ,minX,0), new Vector3(maxZ,minX,0));
				drawLine( new Vector3(maxZ,minX,0), new Vector3(maxZ,maxX,0));
				drawLine( new Vector3(maxZ,maxX,0), new Vector3(minZ,maxX,0));
				drawLine( new Vector3(minZ,maxX,0), new Vector3(minZ,minX,0));

			}

			drawLine( new Vector3(map.length * tileSize * shrinkScale,0,0), new Vector3(map.length * tileSize * shrinkScale,map.length * tileSize * shrinkScale,0));


			//draw floor line
			for(var i:int = 0; i < Engine.bd.width; i++)
			{
				Engine.bd.setPixel(i, Engine.bd.height/2, 0x00ff00);
			}

		}
	}
}