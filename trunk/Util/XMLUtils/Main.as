package 
{	
	import com.flexcomps.utils.CustomEvent;
	import com.flexcomps.utils.XMLLoaderUtil;
	import flash.display.MovieClip;
	/**
	* ...
	* @author Yogesh Puri
	*/
	public class Main extends MovieClip
	{
		public var xmlData:XML;
		public var xmlPath:String;
		
		public function Main() {
			initVars();
		}
		
		public function initVars() {
			xmlPath = "data/data.xml";
			init();
		}
		
		public function init() {
			var xmlLoader:XMLLoaderUtil = new XMLLoaderUtil();
			xmlLoader.addEventListener(CustomEvent.ONLOADED, onXMLLoaded);
			xmlLoader.load(xmlPath);
		}
		
		private function onXMLLoaded(evt:CustomEvent) {
			xmlData = evt.data as XML;
			trace(xmlData);
		}
		
	}
	
}