package cn.chinuy.utils {
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * @author Chin
	 */
	[Event( name = "fullScreen", type = "flash.events.Event" )]
	[Event( name = "resize", type = "flash.events.Event" )]
	public class StageUtil extends EventDispatcher {
		private static var _instance : StageUtil;
		
		public static function get instance() : StageUtil {
			if( _instance == null ) {
				_instance = new StageUtil();
			}
			return _instance;
		}
		
		private var _stage : Stage;
		private var _stagew : Number;
		private var _stageh : Number;
		
		public function init( stage : Stage ) : void {
			_stage = stage;
			_stage.align = StageAlign.TOP_LEFT;
			_stage.scaleMode = StageScaleMode.NO_SCALE;
			_stage.addEventListener( Event.FULLSCREEN, dispatchEvent );
			_stage.addEventListener( Event.RESIZE, checkStageSize );
			checkStageSize( new Event( Event.RESIZE ));
		}
		
		private function checkStageSize( e : Event ) : void {
			var wchanged : Boolean = _stagew != _stage.stageWidth;
			var hchanged : Boolean = _stageh != _stage.stageHeight;
			if( wchanged || hchanged ) {
				_stagew = _stage.stageWidth;
				_stageh = _stage.stageHeight;
				dispatchEvent( e );
			}
		}
		
		public function get data() : Stage {
			return _stage;
		}
		
		public function get width() : Number {
			return _stagew;
		}
		
		public function get height() : Number {
			return _stageh;
		}
		
		public function get isFullScreen() : Boolean {
			return _stage.displayState == StageDisplayState.FULL_SCREEN || _stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE;
		}
		
		public function fullScreen( flag : Object = null, allowInput : Boolean = false ) : Boolean {
			if( flag == null ) {
				return fullScreen( !isFullScreen, allowInput );
			} else if( flag ) {
				_stage.displayState = allowInput ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.FULL_SCREEN;
				return isFullScreen;
			}
			_stage.displayState = StageDisplayState.NORMAL;
			return false;
		}
	}
}
