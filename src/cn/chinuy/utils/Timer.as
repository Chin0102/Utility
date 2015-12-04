package cn.chinuy.utils {
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	/**
	 * @author Chin
	 */
	[Event( name = "timer", type = "flash.events.TimerEvent" )]
	[Event( name = "timerComplete", type = "flash.events.TimerEvent" )]
	public class Timer extends EventDispatcher implements IEventDispatcher {
		private var time : uint;
		private var delay : uint;
		private var repeatCount : uint;
		private var _currentCount : uint;
		private var intervalId : int = -1;
		private var offsetIntervalId : int = -1;
		private var offset : uint;
		// start|stop
		private var _running : Boolean = false;
		// pause|resume
		private var _paused : Boolean = false;
		
		public function Timer( delay : int, repeatCount : int = 0 ) {
			super();
			this.delay = delay;
			this.repeatCount = repeatCount;
		}
		
		public function get running() : Boolean {
			return _running;
		}
		
		public function get paused() : Boolean {
			return _paused;
		}
		
		public function get currentCount() : int {
			return _currentCount;
		}
		
		public function start() : void {
			if( !running ) {
				_running = true;
				_currentCount = 0;
				time = getTimer();
				intervalId = setInterval( onTransition, delay );
			}
		}
		
		public function pause() : void {
			if( running && !_paused ) {
				_paused = true;
				var t : int = getTimer();
				var hasOffset : Boolean = checkOffset();
				if( hasOffset ) {
					offset -= ( t - time );
				} else {
					offset = delay - ( t - time );
				}
				clearInterval( intervalId );
				intervalId = -1;
			}
		}
		
		public function resume() : void {
			if( running && _paused ) {
				_paused = false;
				time = getTimer();
				offsetIntervalId = setInterval( onTransition, offset );
			}
		}
		
		public function stop() : void {
			if( running ) {
				_running = false;
				clearInterval( intervalId );
				intervalId = -1;
			}
		}
		
		private function checkOffset() : Boolean {
			var hasOffset : Boolean = offsetIntervalId >= 0;
			if( hasOffset ) {
				clearInterval( offsetIntervalId );
				offsetIntervalId = -1;
			}
			return hasOffset;
		}
		
		private function onTransition() : void {
			var t : int = getTimer();
			if( checkOffset()) {
				offset = 0;
				intervalId = setInterval( onTransition, delay );
			}
			time = t;
			_currentCount++;
			dispatchEvent( new TimerEvent( TimerEvent.TIMER ));
			if( repeatCount > 0 ) {
				repeatCount--;
				if( repeatCount <= 0 ) {
					stop();
					dispatchEvent( new TimerEvent( TimerEvent.TIMER_COMPLETE ));
				}
			}
		}
	}
}
