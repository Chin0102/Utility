package cn.chinuy.net.loader {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	
	/**
	 * @author chin
	 */
	public class SWFReader {
		
		private var _loaderInfo : LoaderInfo;
		private var classMap : Object;
		
		public function SWFReader( info : LoaderInfo = null ) {
			loaderInfo = info;
		}
		
		public function get loaderInfo() : LoaderInfo {
			return _loaderInfo;
		}
		
		public function set loaderInfo( loaderInfo : LoaderInfo ) : void {
			classMap = [];
			_loaderInfo = loaderInfo;
		}
		
		public function get content() : DisplayObject {
			return _loaderInfo.content;
		}
		
		public function hasProperty( key : String ) : Boolean {
			return content.hasOwnProperty( key );
		}
		
		public function getProperty( key : String ) : * {
			var value : *;
			try {
				if( hasProperty( key )) {
					value = content[ key ];
				}
			} catch( e : Error ) {
			}
			return value;
		}
		
		public function setProperty( key : String, value : * ) : void {
			if( hasProperty( key )) {
				content[ key ] = value;
			}
		}
		
		public function call( func : String, ... param ) : * {
			if( hasProperty( func )) {
				var f : Function = content[ func ] as Function;
				if( f != null )
					return f.apply( null, param );
			}
		}
		
		public function addEventListener( type : String, func : Function ) : void {
			call( "addEventListener", type, func );
		}
		
		public function removeEventListener( type : String, func : Function ) : void {
			call( "removeEventListener", type, func );
		}
		
		public function getClass( name : String ) : Class {
			if( _loaderInfo != null ) {
				var C : Class = classMap[ name ];
				if( C == null ) {
					try {
						C = _loaderInfo.applicationDomain.getDefinition( name ) as Class;
						classMap[ name ] = C;
					} catch( e : ReferenceError ) {
					}
				}
			}
			return C;
		}
		
		public function getDisplayObject( name : String ) : DisplayObject {
			var C : Class = getClass( name );
			if( C != null ) {
				return new C();
			}
			return null;
		}
		
		public function getBitmap( name : String, w : int = 0, h : int = 0 ) : Bitmap {
			var C : Class = getClass( name );
			if( C != null ) {
				var bd : BitmapData = new C( w, h );
				return new Bitmap( bd );
			}
			return null;
		}
	}
}
