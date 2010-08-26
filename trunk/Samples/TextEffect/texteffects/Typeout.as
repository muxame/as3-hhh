package texteffects {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.text.TextField;
	
	public class Typeout extends Sprite {
			
		private var _str		:Array;
		private var _tf			:ControlText;
		private var _letters	:String;
		private var timer		:Timer;
		private var count		:Number = -1;
		
		public function Typeout(str:String, timeStop:Number = 100, auto:Boolean = true){
			
			_tf = new ControlText(20);
			_tf.width = 300;
			addChild(_tf);
			
			_str = str.split("");
							
			_letters = "";
			
			timer = new Timer(timeStop);
			
			if(auto){
				show();
			}
		}
		
		public function show():void {
			timer.reset();
			timer.start();
			timer.removeEventListener(TimerEvent.TIMER, hideCopy);
			timer.addEventListener(TimerEvent.TIMER, showCopy);
		}
		
		public function hide():void {
			timer.reset();
			timer.start();
			timer.removeEventListener(TimerEvent.TIMER, showCopy);
			timer.addEventListener(TimerEvent.TIMER, hideCopy);
		}
		
		public function changeWord(word:String):void {
			
		}
		
		private function showCopy(e:TimerEvent):void {
			
			count++
			_letters += _str[count];
			
			_tf.text = _letters;
			
			if(count==_str.length-1){
				timer.stop();
				hide()
			}
				
		}
		
		private function hideCopy(e:TimerEvent):void {
			count--
			var s:String = ""
			for(var i:Number=0;i<count;i++){
				s+=_str[i];
			}
			_letters = s;
			_tf.text = _letters;
			if(count<0){
				timer.stop();
				show();
			}
		}
		
	}
}