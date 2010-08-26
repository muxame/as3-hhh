package { //sample.TypeWriterSprite
	import texteffects.TypeDown;
	import texteffects.Typeout;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author binhdocco
	 */
	public class TypeWriterSprite extends MovieClip {
		
		public function TypeWriterSprite() {
			init();
		}
		
		private function init():void{
			//TypeOut
			//show from beginning and hide from ending
			var typeOut: Typeout = new Typeout("Hello world !", 60);
			this.addChild(typeOut);
			//Typedonw
			var typeDown: TypeDown = new TypeDown("Can you see me ???", 400, 100, 18);
			typeDown.y = 50;
			typeDown.name = "type_down";
			addChild(typeDown);
			
			typeDown.addEventListener(MouseEvent.ROLL_OVER, onRollOverMovie);
		}
		
		private function onRollOverMovie(e:MouseEvent):void {
			(this.getChildByName('type_down') as TypeDown).start();;
		}
		
	}
	
}