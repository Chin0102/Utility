package cn.chinuy.utils {
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	/**
	 * @author chin
	 */
	[Event( name = "click", type = "flash.events.MouseEvent" )]
	[Event( name = "doubleClick", type = "flash.events.MouseEvent" )]
	[Event( name = "mouseOver", type = "flash.events.MouseEvent" )]
	[Event( name = "mouseOut", type = "flash.events.MouseEvent" )]
	[Event( name = "mouseUp", type = "flash.events.MouseEvent" )]
	[Event( name = "mouseDown", type = "flash.events.MouseEvent" )]
	public class MouseEventListener extends EventDispatcher {
		
		private var _target : DisplayObject;
		
		private var listenDoubleClick : Boolean;
		private var clickTime : int;
		private var timer : Timer = new Timer( 300 );
		private var singleClickEvent : MouseEvent;
		
		private var _useStrictClick : Boolean;
		private var mouseDownEvent : MouseEvent;
		
		public function MouseEventListener( target : DisplayObject ) {
			super();
			timer.addEventListener( TimerEvent.TIMER, dispatchSingleClick );
			_target = target;
		}
		
		override public function removeEventListener( type : String, listener : Function, useCapture : Boolean = false ) : void {
			super.removeEventListener( type, listener, useCapture );
			if( hasEventListener( type ))
				return;
			if( type == MouseEvent.DOUBLE_CLICK ) {
				type = MouseEvent.CLICK;
				listenDoubleClick = false;
				if( hasEventListener( type ))
					return;
			}
			_target.removeEventListener( type, targetMouseEventHandler );
		}
		
		override public function addEventListener( type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false ) : void {
			super.addEventListener( type, listener, useCapture, priority, useWeakReference );
			if( type == MouseEvent.DOUBLE_CLICK ) {
				type = MouseEvent.CLICK;
				listenDoubleClick = true;
				if( _target.hasEventListener( type ))
					return;
			}
			_target.addEventListener( type, targetMouseEventHandler );
		}
		
		public function get useStrictClick() : Boolean {
			return _useStrictClick;
		}
		
		public function set useStrictClick( value : Boolean ) : void {
			_useStrictClick = value;
			var func : Function = useStrictClick ? _target.addEventListener : _target.removeEventListener;
			func.apply( null, [ MouseEvent.MOUSE_DOWN, targetMouseDownHandler ]);
		}
		
		private function targetMouseDownHandler( e : MouseEvent ) : void {
			mouseDownEvent = e;
		}
		
		private function targetMouseEventHandler( e : MouseEvent ) : void {
			if( e.type == MouseEvent.CLICK ) {
				if( listenDoubleClick ) {
					clickTime++;
					if( clickTime == 1 ) {
						singleClickEvent = e;
						timer.start();
						return;
					} else if( clickTime == 2 ) {
						e = new MouseEvent( MouseEvent.DOUBLE_CLICK, e.bubbles, e.cancelable, e.localX, e.localY, e.relatedObject, e.ctrlKey, e.altKey, e.shiftKey, e.buttonDown, e.delta );
					}
				}
				if( useStrictClick && !checkStrictClick( e )) {
					return;
				}
			}
			resetClick();
			dispatchEvent( e );
		}
		
		private function dispatchSingleClick( e : TimerEvent ) : void {
			var send : Boolean = !useStrictClick || checkStrictClick( singleClickEvent );
			resetClick();
			if( send )
				dispatchEvent( singleClickEvent );
		}
		
		private function checkStrictClick( e : MouseEvent ) : Boolean {
			if( mouseDownEvent == null )
				return false;
			var offsetX : Number = Math.abs( e.localX - mouseDownEvent.localX );
			var offsetY : Number = Math.abs( e.localY - mouseDownEvent.localY );
			return offsetX <= 1 && offsetY <= 1;
		}
		
		private function resetClick() : void {
			mouseDownEvent = null;
			timer.stop();
			clickTime = 0;
		}
	
	}
}
