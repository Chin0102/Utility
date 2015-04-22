package cn.chinuy.data.bitmap {
	import cn.chinuy.net.loader.BaseLoader;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	/**
	 * @author chin
	 */
	[Event( name = "verifyError", type = "flash.events.IOErrorEvent" )]
	public class BitmapCutter extends BaseLoader {
		
		private var w : int;
		private var h : int;
		protected var _loader : Loader;
		protected var _bitmap : Bitmap;
		protected var _data : Array;
		
		public function BitmapCutter() {
			super();
		}
		
		public function get loader() : Loader {
			return _loader;
		}
		
		public function get bitmap() : Bitmap {
			return _bitmap;
		}
		
		public function get data() : Array {
			return _data;
		}
		
		override protected function newLoader() : void {
			_loader = new Loader();
			_dispatcher = _loader.contentLoaderInfo;
		}
		
		public function init( w : int, h : int, imgURL : String ) : void {
			this.w = w;
			this.h = h;
			url = imgURL;
			load();
		}
		
		override protected function toLoad( request : URLRequest ) : void {
			_data = [];
			_loader.load( request );
		}
		
		override protected function toUnload() : void {
			_loader.close();
		}
		
		override protected function onGet( e : Event ) : Boolean {
			_bitmap = _loader.content as Bitmap;
			if( bitmap ) {
				var bw : int = bitmap.width;
				var bh : int = bitmap.height;
				if( bw % w == 0 && bh % h == 0 ) {
					var p : Point = new Point();
					var rect : Rectangle = new Rectangle( 0, 0, w, h );
					while( rect.y < bh ) {
						var sData : BitmapData = new BitmapData( w, h, false, 0 );
						sData.copyPixels( bitmap.bitmapData, rect, p );
						data.push( sData );
						rect.x += w;
						if( rect.x >= bw ) {
							rect.x = 0;
							rect.y += h;
						}
					}
					return true;
				}
				dispatchEvent( new IOErrorEvent( IOErrorEvent.VERIFY_ERROR, false, false, "位图尺寸不符合" ));
				return false;
			}
			dispatchEvent( new IOErrorEvent( IOErrorEvent.VERIFY_ERROR, false, false, "加载资源不是位图" ));
			return false;
		
		}
	
	}
}
