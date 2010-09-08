package com.flexcomps.utils
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class XMLLoaderUtil extends EventDispatcher
	{
		private var strFileURL:URLRequest;
		private var xmlObj:XML;
		private var urlLoader:URLLoader;
		
		
		public function XMLLoaderUtil(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public function load(strFileName:String):void{
			strFileURL = new URLRequest(strFileName);
			urlLoader = new URLLoader();
			urlLoader.load(strFileURL);
			urlLoader.addEventListener(Event.COMPLETE,onXMLLoaded);
		}
		
		private function onXMLLoaded(evt:Event):void {
			urlLoader.removeEventListener(Event.COMPLETE, onXMLLoaded);
			var dataLoader:URLLoader = evt.target as URLLoader;
			xmlObj = new XML(dataLoader.data);
			dispatchEvent(new CustomEvent(CustomEvent.ONLOADED,xmlObj));
			xmlObj = null;
			dataLoader = null;
			urlLoader = null;
		}
	}
}