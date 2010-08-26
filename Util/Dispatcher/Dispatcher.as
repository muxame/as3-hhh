package binhdocco.utils {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author binhdocco

	 */
	public class Dispatcher implements IEventDispatcher {
		
		private static var dispatcher: EventDispatcher;
		
		public function Dispatcher() {
			if (dispatcher == null)
				dispatcher = new EventDispatcher();
		}
		
		/* INTERFACE flash.events.IEventDispatcher */
		
		public function dispatchEvent(event:Event):Boolean{
			return dispatcher.dispatchEvent(event);
		}
		
		public function hasEventListener(type:String):Boolean{
			return dispatcher.hasEventListener(type);
		}
		
		public function willTrigger(type:String):Boolean{
			return dispatcher.willTrigger(type);
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void{
			return dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
	}

}