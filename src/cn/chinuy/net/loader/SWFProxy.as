package cn.chinuy.net.loader {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	
	/**
	 * @author Chin
	 */
	public class SWFProxy extends SWFLoader {
		
		private var reader : SWFReader;
		
		public function SWFProxy( url : String = null, appDomain : ApplicationDomain = null ) {
			super( appDomain );
			if( url ) {
				this.url = url;
			}
		}
		
		override protected function onInit() : void {
			reader = new SWFReader( info );
		}
		
		public function getProperty( key : String ) : * {
			return reader.getProperty( key );
		}
		
		public function setProperty( key : String, value : * ) : void {
			reader.setProperty( key, value );
		}
		
		public function hasProperty( key : String ) : Boolean {
			return reader.hasProperty( key );
		}
		
		public function call( func : String, ... param ) : * {
			return reader.call.apply( null, [ func ].concat( param ));
		}
		
		public function addSWFEventListener( type : String, func : Function ) : void {
			reader.addEventListener( type, func );
		}
		
		public function removeSWFEventListener( type : String, func : Function ) : void {
			reader.removeEventListener( type, func );
		}
		
		public function getClass( name : String ) : Class {
			return reader.getClass( name );
		}
		
		public function getDisplayObject( name : String ) : DisplayObject {
			return reader.getDisplayObject( name );
		}
		
		public function getBitmap( name : String, w : int = 0, h : int = 0 ) : Bitmap {
			return reader.getBitmap( name, w, h );
		}
	
	}
}
