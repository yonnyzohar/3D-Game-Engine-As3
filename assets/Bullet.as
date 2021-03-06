package assets
{
	import flash.display.BitmapData;

	public class Bullet extends GameObject {

		var dist:int = 0;
		private var parent:GameObject;

		public function Bullet(_positon: Point3d, _rotation: Quaternion, _scale: Point3d, _bd: BitmapData, _parent:GameObject) {
			// constructor code
			position = _positon; //
			rotation = _rotation; //;
			scale = _scale;
			scale.x = scale.y = scale.z = 0.05;
			bd = _bd;
			parent = _parent;
		
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
			

			super();
		}

		

		override public function update(elapsedTime:Number): void {
			
			var ms:Number = Engine.moveSpeed * elapsedTime;
			
			dist++;
			if(dist < 200)
			{
				moveForward(ms * 25);
				//if(collide)
				{
					for(var i:int = 0; i < Engine.gO.length; i++)
					{
						var go:GameObject = Engine.gO[i];
						if(go != this && go != parent)
						{
							var hit:Boolean = go.checkColission(position);
							if(hit)
							{
								Engine.removeEntity(this);
								if(go.destructable)
								{
									
									Engine.removeEntity(go);
									new Explosion(go.position);
								}
							}
						}
					}
				}

				
			}
			else
			{
				Engine.removeEntity(this);
			}
			
			super.update(elapsedTime)

		}
	}
}