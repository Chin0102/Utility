package cn.chinuy.utils {
	
	/**
	 * @author Chin
	 */
	public class Zoom {
		
		public static const Allways : int = 0;
		public static const Narrow : int = 1;
		
		private var ow : Number;
		private var oh : Number;
		private var _xyscale : Number;
		private var _zscale : Number = 1;
		private var m : int;
		
		public function Zoom( w : Number, h : Number, zoomMode : int = 0 ) {
			setWH( w, h );
			scale = w / h;
			mode = zoomMode;
		}
		
		public function setWH( w : Number, h : Number ) : void {
			ow = w;
			oh = h;
		}
		
		public function set mode( zoomMode : int ) : void {
			m = zoomMode;
		}
		
		public function get scale() : Number {
			return _xyscale;
		}
		
		public function set scale( value : Number ) : void {
			_xyscale = value;
		}
		
		public function get zscale() : Number {
			return _zscale;
		}
		
		public function set zscale( value : Number ) : void {
			if( value >= 0 && value <= 1 ) {
				_zscale = value;
			}
		}
		
		public function getXYWH( rw : Number, rh : Number ) : Array {
			var x_offset : Number = 0;
			var y_offset : Number = 0;
			if( zscale < 1 ) {
				var orw : Number = rw;
				var orh : Number = rh;
				rw *= zscale;
				rh *= zscale;
				x_offset = ( orw - rw ) / 2;
				y_offset = ( orh - rh ) / 2;
			}
			var x : Number, y : Number, w : Number = ow, h : Number = oh;
			var c : Boolean = true;
			if( m == Narrow )
				c = rw < ow || rh < oh;
			if( c ) {
				if( _xyscale == 0 ) {
					w = rw;
					h = rh;
				} else if( rw / rh > _xyscale ) {
					w = rh * _xyscale;
					h = rh;
				} else {
					w = rw;
					h = rw / _xyscale;
				}
			}
			x = x_offset + ( rw - w ) / 2;
			y = y_offset + ( rh - h ) / 2;
			return [ x, y, w, h ];
		}
	}
}
