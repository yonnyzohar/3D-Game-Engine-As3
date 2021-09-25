package {
	import flash.display.BitmapData;

	public class Plane extends GameObject{

		public function Plane(_positon:Point3d, _rotation:Quaternion, _scale:Point3d, _bd:BitmapData) {
			// constructor code
			position = _positon;//
			rotation = _rotation;//;
			scale = _scale;
			bd = _bd;
			
			var a:Array = [-42.6086311340332,58.5427474975586,118.599494934082,-40.6784591674805,54.9452171325684,119.912002563477,-37.3353118896484,52.8985786437988,120.671356201172,2.23260198848295e-13,52.6308288574219,120.771446228027,-5.38420749762736e-07,102.731803894043,103.51293182373,-37.3353118896484,102.418670654297,103.618690490723,-40.6784591674805,100.044784545898,104.419395446777,-42.6086311340332,95.9533996582031,105.795356750488,42.6086311340332,58.5427474975586,118.599494934082,42.6086311340332,95.9533996582031,105.795356750488,40.6784591674805,100.044784545898,104.419395446777,37.3353118896484,102.418670654297,103.618690490723,37.3353118896484,52.8985786437988,120.671356201172,40.6784591674805,54.9452171325684,119.912002563477];
			var p:Array = [3,4,39,2,4,40,1,4,41,0,4,34,7,4,35,4,5,35,4,3,30,11,3,31,10,3,32,9,3,33,8,3,28,3,12,28];
			
			var points:Array = [];
			for(var i:int = 0; i < a.length ; i+=3)
			{
				var point1:Point3d = new Point3d(a[i], a[i+1], a[i+2]);
				trace(i , a[i], a[i+1], a[i+2]);
				points.push(point1);
			}
			trace("----", points.length);
			polygons = [];
			for(i = 0; i < p.length ; i+=3)
			{
				var index1:int = p[i];
				var index2:int = p[i+1];
				var index3:int = p[i+2];
				polygons.push(new Polygon(points[index1], points[index2],points[index3],bd));
				trace(p[i], p[i+1], p[i+2], points[index1], points[index2],points[index3]);
				
			}

			//the makeup of the polygons is important. they need to be clockwise!
			
		}

		override public function update(): void {
			//rotation.y += 0.01;
			//rotation.x += 0.01;
		}

		



	}

}