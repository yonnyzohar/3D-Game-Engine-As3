package game{
	import flash.display.Stage;
	import assets.Bullet;

	public class Player extends GameCamera {
		var coolDown:int = 10;
		var c:int = 0;
		public function Player(_theStage: Stage, _position: Point3d, _rotation: Quaternion) {
			super(_theStage, _position, _rotation);
		}


		override public function update(elapsedTime:Number): void 
		{
			if(c != 0)
			{
				c--;
			}
			if(InputHandler.SPACE)
			{
				if(c == 0)
				{
					var po:Point3d = getPosition();
					var bullet: Bullet = new Bullet(
					new Point3d(po.x,po.y,po.z), 
					new Quaternion(rotation.x, rotation.y, rotation.z, rotation.w), 
					new Point3d(0.05,0.05,0.05), 
					null);
					Engine.gO.push(bullet);
					bullet.setFrameColor( 0xff00ff);
					c = coolDown;
				}
				
			}
			super.update(elapsedTime);
			
		}
	}
}