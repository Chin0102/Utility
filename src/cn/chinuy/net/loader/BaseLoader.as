package cn.chinuy.net.loader {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * @author Chin
	 */
	[Event( name = "complete", type = "flash.events.Event" )]
	[Event( name = "ioError", type = "flash.events.IOErrorEvent" )]
	[Event( name = "timerComplete", type = "flash.events.TimerEvent" )]
	[Event( name = "securityError", type = "flash.events.SecurityErrorEvent" )]
	public class BaseLoader extends EventDispatcher implements ILoader {
		private var _requestTime : Number;
		private var _error : Boolean = false;
		private var _loading : Boolean;
		private var _valid : Boolean;
		private var _request : URLRequest = new URLRequest;
		protected var _dispatcher : IEventDispatcher;
		
		private var timeoutTimer : Timer;
		
		public function BaseLoader() {
			super();
		}
		
		// !valid && !loading = 失败或未加载
		// !valid && loading = 加载中
		// valid && !loading = 加载成功
		public function set url( u : String ) : void {
			_request.url = u;
		}
		
		public function set method( m : String ) : void {
			_request.method = m;
		}
		
		public function set param( d : Object ) : void {
			_request.data = d;
		}
		
		public function load( timeout : Number = 60000 ) : void {
			if( _request.url ) {
				_error = false;
				_valid = false;
				_loading = true;
				_requestTime = getTimer();
				eventFlag( false );
				newLoader();
				eventFlag( true );
				clearTimer();
				if( timeout > 0 ) {
					timeoutTimer = new Timer( timeout, 1 );
					timeoutTimer.addEventListener( TimerEvent.TIMER_COMPLETE, onError );
					timeoutTimer.start();
				}
				toLoad( _request );
			}
		}
		
		private function clearTimer() : void {
			if( timeoutTimer ) {
				timeoutTimer.removeEventListener( TimerEvent.TIMER_COMPLETE, onError );
				timeoutTimer.stop();
			}
		}
		
		public function unload() : void {
			eventFlag( false );
			if( _loading ) {
				try {
					toUnload();
				} catch( e : Error ) {
				}
			}
		}
		
		public function get error() : Boolean {
			return _error;
		}
		
		public function get valid() : Boolean {
			return _valid;
		}
		
		public function get loading() : Boolean {
			return _loading;
		}
		
		public function get requestTime() : Number {
			return _requestTime;
		}
		
		public function get content() : * {
			return null;
		}
		
		private function onFeedback() : void {
			_requestTime = getTimer() - _requestTime;
			_loading = false;
		}
		
		protected function onError( e : Event ) : void {
			if( e.type == TimerEvent.TIMER_COMPLETE ) {
				unload();
			} else {
				eventFlag( false );
			}
			onFeedback();
			_error = true;
			onGetError( e );
			dispatchEvent( e );
		}
		
		protected function onComplete( e : Event ) : void {
			eventFlag( false );
			onFeedback();
			_valid = true;
			onGet( e );
			dispatchEvent( e );
		}
		
		private function eventFlag( flag : Boolean ) : void {
			clearTimer();
			if( _dispatcher )
				eventMap( flag ? _dispatcher.addEventListener : _dispatcher.removeEventListener );
		}
		
		protected function newLoader() : void {
		}
		
		protected function eventMap( func : Function ) : void {
			func.apply( null, [ Event.COMPLETE, onComplete ]);
			func.apply( null, [ IOErrorEvent.IO_ERROR, onError ]);
			func.apply( null, [ SecurityErrorEvent.SECURITY_ERROR, onError ]);
		}
		
		protected function toLoad( request : URLRequest ) : void {
		}
		
		protected function toUnload() : void {
		}
		
		protected function onGet( e : Event ) : void {
		}
		
		protected function onGetError( e : Event ) : void {
		}
	}
}
