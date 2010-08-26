package texteffects {

	import flash.text.*

	public class ControlText extends TextField {
		
		private var _format		:TextFormat;
				
		public function ControlText(size:int = 11, colour:uint = 0x222222, align:String = "left", mult:Boolean = true, auto:String = "none", sel:Boolean = false){
			
			//var myFont:Font;
				
			_format					= new TextFormat("_sans");
			_format.color			= colour;
			_format.size			= size;
			_format.align			= align;
						  
			autoSize				= auto;
			multiline				= mult;
			wordWrap				= mult;
			selectable				= sel;
			antiAliasType			= AntiAliasType.ADVANCED;
			width 					= 100;
						  
			defaultTextFormat		= _format;
			mouseEnabled			= false;
								  
		}
		
		public function get format():TextFormat { return _format; }
		  
	}
}