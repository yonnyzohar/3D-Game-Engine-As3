package game{
	import flash.geom.Point;
	import flash.events.*;
	import flash.display.*;
	import flash.geom.Rectangle;
	import assets.*;


	public class BattleZone extends Engine {

		protected var player: Player;
		private var tileSize:Number = 200;
		private var map:Array = [
			[0,1,0,1,0,1,0,1,3,1,0,1,0,1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,3],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
			[1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,1,0,0,1]
		];

		private var initialCamPosX:Number;
		private var initialCamPosZ:Number;
		private var initialCamPosY:Number;
		private var showStats:Boolean = false;

		override protected function initGameObjects():void
		{

			wireFrameColor = 0x00ff00;

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
						position = new Point3d(_x, 0, _z);
						rotation = new Quaternion(0, 0, 0, 1);
						scale = new Point3d( 1, 1, 1);
						var p: Pyramid = new Pyramid(position, rotation, scale, arr[0]);
						p.setFrameColor(Math.random() * 0xffffff);
						gameObjects.push(p);
						p.destructable = false;
					}
					if(map[row][col] == 2)
					{
						initialCamPosZ = col * tileSize;
						initialCamPosX = row * tileSize;
						initialCamPosY = 100;
					}
					if(map[row][col] == 3)
					{
						position = new Point3d(_x, 100, _z);
						rotation = new Quaternion(0, 0, 0, 1);
						scale = new Point3d( 1, 1, 1);
						var pn:Mountain = new Mountain(position, rotation, scale, arr[0]);
						pn.setFrameColor(wireFrameColor);
						gameObjects.push(pn);
						pn.destructable = false;
					}
					
					if(map[row][col] == 4)
					{
						position = new Point3d(_x, 50, _z);
						rotation = new Quaternion(0, 0, 0, 1);
						scale = new Point3d(1, 1, 1);
						var c: Cube = new Cube(position, rotation, scale, arr[0]);
						c.setFrameColor(0xffffff);
						gameObjects.push(c);
					}
					
				}
			}
		}

		override protected function initCamera():void
		{
			var camPos: Point3d = new Point3d(initialCamPosX, initialCamPosY, initialCamPosZ);
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
			if(showStats)
			{
				var shrinkScale:Number = 0.01;

				var camPosX:Number = Number(activeCamera.getPosition().z*shrinkScale);
				var camPosY:Number = Number(activeCamera.getPosition().x*shrinkScale);
				

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

				

			
			}
			var cX:int = resolutionX/2;
			var cY:int = resolutionY/2;
			var h:int = 20;

			drawLine( new Vector3(cX-h,cY,0), new Vector3(cX-(h/2),cY,0));
			drawLine( new Vector3(cX+(h/2),cY,0), new Vector3(cX+h,cY,0));

			drawLine( new Vector3(cX,cY-h,0), new Vector3(cX,cY -h/2,0));
			drawLine( new Vector3(cX,cY+h/2,0), new Vector3(cX,cY +h,0));
			
			//draw floor line
			/*
			for(var i:int = 0; i < Engine.bd.width; i++)
			{
				Engine.bd.setPixel(i, Engine.bd.height/2, wireFrameColor);
			}*/

		}
	}
}