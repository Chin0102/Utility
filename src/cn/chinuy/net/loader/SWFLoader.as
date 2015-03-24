package cn.chinuy.net.loader {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.getTimer;
	
	/**
	 * @author Chin
	 */
	[Event( name = "init", type = "flash.events.Event" )]
	[Event( name = "progress", type = "flash.events.ProgressEvent" )]
	public class SWFLoader extends BaseLoader implements ILoader {
		protected var _context : LoaderContext;
		protected var _loaderInfo : LoaderInfo;
		protected var _loader : Loader;
		
		private var _readyTime : Number;
		
		public function SWFLoader( appDomain : ApplicationDomain = null ) {
			_context = new LoaderContext();
			_context.applicationDomain = new ApplicationDomain( appDomain );
		}
		
		public function get loader() : Loader {
			return _loader;
		}
		
		public function get info() : LoaderInfo {
			return _loaderInfo;
		}
		
		public function loadDuration() : Number {
			return super.requestTime;
		}
		
		override public function get requestTime() : Number {
			return _readyTime;
		}
		
		override public function get content() : * {
			return _loader.content;
		}
		
		override protected function newLoader() : void {
			_loader = new Loader();
			_dispatcher = _loader.contentLoaderInfo;
		}
		
		override protected function eventMap( func : Function ) : void {
			super.eventMap( func );
			func.apply( null, [ ProgressEvent.PROGRESS, dispatchEvent ]);
			func.apply( null, [ Event.INIT, onSWFInit ]);
		}
		
		override protected function toLoad( request : URLRequest ) : void {
			_readyTime = getTimer();
			_loader.load( request, _context );
		}
		
		override protected function toUnload() : void {
			_loader.close();
		}
		
		protected function onSWFInit( e : Event ) : void {
			_readyTime = getTimer() - _readyTime;
			_loaderInfo = e.currentTarget as LoaderInfo;
			onInit();
			dispatchEvent( e );
		}
		
		protected function onInit() : void {
		}
	}
}
