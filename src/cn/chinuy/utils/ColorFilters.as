package cn.chinuy.utils {
	import flash.filters.ColorMatrixFilter;
	
	/**
	 * Chin
	 */
	public class ColorFilters {
		
		private static const INIT : Array = [ 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0 ];
		
		private var brightnessFilter : ColorMatrixFilter;
		private var contrastFilter : ColorMatrixFilter;
		private var _brightness : Number = 0;
		private var _contrast : Number = 0;
		private var _filters : Array = [];
		
		public function ColorFilters( brightness : Number = 0, contrast : Number = 0 ) {
			if( brightness != 0 ) {
				this.brightness = brightness;
			}
			if( contrast != 0 ) {
				this.contrast = contrast;
			}
		}
		
		public function get brightness() : Number {
			return _brightness;
		}
		
		public function get contrast() : Number {
			return _contrast;
		}
		
		public function set brightness( v : Number ) : void {
			_brightness = v;
			brightnessFilter = new ColorMatrixFilter( concat([ 1, 0, 0, 0, v, 0, 1, 0, 0, v, 0, 0, 1, 0, v, 0, 0, 0, 1, 0 ]));
			update();
		}
		
		public function set contrast( c : Number ) : void {
			_contrast = c;
			var v : Number = c / 75 + 1;
			contrastFilter = new ColorMatrixFilter( concat([ v, 0, 0, 0, 128 * ( 1 - v ), 0, v, 0, 0, 128 * ( 1 - v ), 0, 0, v, 0, 128 * ( 1 - v ), 0, 0, 0, 1, 0 ]));
			update();
		}
		
		public function get value() : Array {
			return _filters;
		}
		
		private function update() : void {
			_filters = [];
			if( brightnessFilter )
				_filters.push( brightnessFilter );
			if( contrastFilter )
				_filters.push( contrastFilter );
		}
		
		private function concat( param : Array ) : Array {
			var i : Number = 0;
			var arr : Array = [];
			var a : Number = 0;
			var b : Number = 0;
			while( b < 4 ) {
				i = 0;
				while( i < 5 ) {
					arr[ a + i ] = param[ a ] * INIT[ i ] + param[( a + 1 )] * INIT[ i + 5 ] + param[ a + 2 ] * INIT[ i + 10 ] + param[ a + 3 ] * INIT[ i + 15 ] + ( i == 4 ? ( param[ a + 4 ]) : ( 0 ));
					i++;
				}
				a += 5;
				b++;
			}
			return arr;
		}
	}
}
