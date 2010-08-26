package texteffects {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import util.Utils;
	
	public class TypeDown extends Sprite {
	
		private var _tf		:ControlText;
		private var _arr	:Array;
		private var _str	:Array;
		private var _st		:String;
	
		public function TypeDown(str:String, w:Number = 100, h:Number = 40, textsize:Number = 12){
			
			_tf = new ControlText(textsize);
			addChild(_tf);
			_tf.width = w;
			_tf.height = h;
			
			_st = str;
			_str = str.split("");
				
			_arr = []
		
			for(var i:Number=0;i<_str.length;i++){
				
				var ob:Object = new Object();
				ob.lettered = false;
				ob.letter = _str[i];
				var extra:int = Utils.randRange(10, 30);
				// var extra:int = 20+i; // finishes from left to right
				ob.letterCode = _str[i].charCodeAt(0) + extra;
				_arr.push(ob);
				
			}
								
			addEventListener(Event.ENTER_FRAME, onFrame);
			
		}
		
		
		private function onFrame(e:Event):void {
			
			var s:String = ""
			
			for(var i:Number=0;i<_str.length;i++){
				if(_arr[i].lettered){
					s += _str[i];
				} else {
					_arr[i].letterCode-=1
					var letter:String = String.fromCharCode(_arr[i].letterCode) // 50-130
					s += letter;
					if(letter == _arr[i].letter){
						_arr[i].lettered = true;
					}
				}
			}
			
			_tf.text = s;
			
			if(s == _st) end();
			
		}
		
		private function end():void {
			_tf.text = _st;
			removeEventListener(Event.ENTER_FRAME, onFrame);
		}
		
		public function start(): void {
			removeEventListener(Event.ENTER_FRAME, onFrame);

			_str = _st.split("");
				
			_arr = []
		
			for(var i:Number=0;i<_str.length;i++){
				
				var ob:Object = new Object();
				ob.lettered = false;
				ob.letter = _str[i];
				var extra:int = Utils.randRange(10, 30);
				// var extra:int = 20+i; // finishes from left to right
				ob.letterCode = _str[i].charCodeAt(0) + extra;
				_arr.push(ob);
				
			}
			addEventListener(Event.ENTER_FRAME, onFrame);
		}
		
	}
	
}