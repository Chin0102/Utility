package cn.chinuy.utils {
	
	import cn.chinuy.data.number.inRange;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	/**
	 * @author chin
	 */
	public class Duration extends EventDispatcher {
		
		private var _startTime : int;
		private var _startPosition : int;
		private var _value : Number;
		
		private var _running : Boolean;
		private var _paused : Boolean;
		private var _finished : Boolean;
		private var _seeking : Boolean;
		private var _playStatusBeforeSeek : * = null;
		
		private var intervalId : int = -1;
		
		public function Duration( value : Number = 0 ) {
			super();
			this.value = value;
		}
		
		public function get finished() : Boolean {
			return _finished;
		}
		
		public function get paused() : Boolean {
			return _paused;
		}
		
		public function get running() : Boolean {
			return _running;
		}
		
		public function set value( value : Number ) : void {
			_value = value;
			if( running ) {
				pause();
				resume();
			}
		}
		
		public function get value() : Number {
			return _value;
		}
		
		public function get position() : Number {
			if( finished ) {
				return value;
			} else if( running ) {
				if( paused ) {
					return _startPosition;
				} else {
					return _startPosition + ( getTimer() - _startTime );
				}
			} else {
				return 0;
			}
		}
		
		public function get countdown() : Number {
			return value - position;
		}
		
		public function start() : void {
			if( !running ) {
				_startTime = getTimer();
				_startPosition = 0;
				
				_finished = _paused = false;
				_running = true;
				
				if( value > 0 ) {
					listenFinish();
				} else {
					finish();
				}
			}
		}
		
		public function seek( position : Number, finishSeek : * = null ) : void {
			if( running ) {
				if( finishSeek == null ) {
					_playStatusBeforeSeek = paused;
					pause();
					_startPosition = inRange( position, value, 0 );
					resume();
					if( _playStatusBeforeSeek ) {
						pause();
						_playStatusBeforeSeek = null;
					}
				} else {
					if( finishSeek ) {
						resume();
						if( _playStatusBeforeSeek ) {
							pause();
							_playStatusBeforeSeek = null;
						}
					} else {
						if( _playStatusBeforeSeek == null ) {
							_playStatusBeforeSeek = paused;
						}
						pause();
						_startPosition = inRange( position, value, 0 );
					}
				}
			}
		}
		
		public function pause() : void {
			if( running && !paused ) {
				_startPosition = position;
				clearInterval( intervalId );
				_paused = true;
			}
		}
		
		public function resume() : void {
			if( running && paused ) {
				_startTime = getTimer();
				listenFinish();
				_paused = false;
			}
		}
		
		public function stop() : void {
			if( running ) {
				clearInterval( intervalId );
				_running = _paused = false;
			}
		}
		
		private function listenFinish() : void {
			if( value > 0 && value != Infinity )
				intervalId = setInterval( finish, countdown );
		}
		
		private function finish() : void {
			stop();
			_finished = true;
			dispatchEvent( new Event( Event.COMPLETE ));
		}
	}
}
