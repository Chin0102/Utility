package cn.chinuy.utils {
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	/**
	 * @author Chin
	 */
	public class DoubleClickUtil extends EventDispatcher implements IEventDispatcher {
		private var timer : Timer;
		private var firstClick : Boolean;
		private var secondClick : Boolean;
		private var _doubleClick : Boolean;
		
		public function DoubleClickUtil( target : DisplayObjectContainer = null ) {
			timer = new Timer( 300 );
			timer.addEventListener( TimerEvent.TIMER, checkTime );
			if( target != null ) {
				setTarget( target );
			}
		}
		
		public function get isDoubleClick() : Boolean {
			return _doubleClick;
		}
		
		public function setTarget( target : DisplayObject ) : void {
			if( target != null ) {
				target.removeEventListener( MouseEvent.CLICK, clickAction );
			}
			firstClick = true;
			target = target;
			target.addEventListener( MouseEvent.CLICK, clickAction );
		}
		
		private function clickAction( e : MouseEvent ) : void {
			if( firstClick ) {
				timer.start();
				secondClick = true;
				firstClick = false;
			} else {
				secondClick = false;
				callback( true );
			}
		}
		
		private function checkTime( e : TimerEvent ) : void {
			timer.stop();
			firstClick = true;
			if( secondClick ) {
				callback( false );
			}
		}
		
		private function callback( doubleClick : Boolean ) : void {
			_doubleClick = doubleClick;
			dispatchEvent( new MouseEvent( MouseEvent.DOUBLE_CLICK ));
		}
	}
}
