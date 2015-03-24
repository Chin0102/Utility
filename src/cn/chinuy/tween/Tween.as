package cn.chinuy.tween {
	import cn.chinuy.tween.easing.None;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.clearInterval;
	import flash.utils.getTimer;
	import flash.utils.setInterval;
	
	/**
	 * @author Chin
	 */
	public class Tween extends EventDispatcher {
		public static const Transition : String = "Tween.Transition";
		public static const Finish : String = "Tween.Finish";
		private var intervalId : int = -1;
		private var start : int;
		private var _target : *;
		private var _tweens : Object;
		private var _duration : int;
		private var _easing : Function;
		
		public function Tween( target : * = null, toValue : Object = null, duration : int = -1, easing : Function = null ) {
			begin( target, toValue, duration, easing );
		}
		
		public function get running() : Boolean {
			return intervalId >= 0;
		}
		
		public function begin( target : *, toValue : Object, duration : int, easing : Function = null ) : void {
			if( target != null && toValue != null && duration > 0 ) {
				if( running )
					finish();
				_target = target;
				_duration = duration;
				_easing = easing == null ? None.easeNone : easing;
				_tweens = {};
				for( var i : String in toValue ) {
					var e : Number = toValue[ i ];
					var b : Number = _target[ i ];
					var c : Number = e - b;
					if( !isNaN( c )) {
						_tweens[ i ] = new SingleTween( b, c );
					}
				}
				start = getTimer();
				intervalId = setInterval( onTransition, 25 );
			}
		}
		
		public function stop() : void {
			if( running ) {
				clearInterval( intervalId );
				intervalId = -1;
			}
		}
		
		public function finish( toEnd : Boolean = false ) : void {
			if( toEnd ) {
				calculate( _duration );
			}
			_tweens = null;
			clearInterval( intervalId );
			intervalId = -1;
			dispatchEvent( new Event( Finish ));
		}
		
		private function onTransition() : void {
			var time : int = getTimer() - start;
			if( time >= _duration ) {
				time = _duration;
				finish( true );
			} else {
				calculate( time );
				dispatchEvent( new Event( Transition ));
			}
		}
		
		private function calculate( time : int ) : void {
			for( var i : String in _tweens ) {
				var tweenBase : SingleTween = _tweens[ i ];
				var value : Number = tweenBase.getValue( time, _duration, _easing );
				_target[ i ] = value;
			}
		}
	}
}

class SingleTween {
	private var b : Number;
	private var c : Number;
	
	public function SingleTween( b : Number, c : Number ) {
		this.b = b;
		this.c = c;
	}
	
	// t:当前时间 , d:持续时间
	public function getValue( t : Number, d : Number, easing : Function ) : Number {
		return easing.apply( null, [ t, b, c, d ]);
	}
}
