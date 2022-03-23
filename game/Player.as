package game{
	import flash.display.Stage;
	import assets.Bullet;

	public class Player extends GameCamera {
		public function Player(_theStage: Stage, _position: Point3d, _rotation: Quaternion) {
			super(_theStage, _position, _rotation);
		}


		override public function update(elapsedTime:Number): void 
		{
			if(InputHandler.SPACE)
			{
				var bullet: Bullet = new Bullet(
					new Point3d(positionMinusZ.x,positionMinusZ.y,positionMinusZ.z), 
					new Quaternion(rotation.x, rotation.y, rotation.z, rotation.w), 
					new Point3d(0.05,0.05,0.05), 
					null);
				Engine.gO.push(bullet);
			}
			super.update(elapsedTime);
			
		}
	}
}