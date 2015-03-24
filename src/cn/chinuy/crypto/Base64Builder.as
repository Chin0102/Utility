package cn.chinuy.crypto {
	
	public class Base64Builder {
		private var _d : Array;
		private var _e : String;
		private static const baseString : String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.-+|/";
		
		public function Base64Builder() {
			build();
		}
		
		public function build() : void {
			_e = RndStr( baseString ).substr( 0, 64 );
			_d = GetBase64DeArray( _e );
		}
		
		public function get e() : String {
			return _e;
		}
		
		public function get d() : Array {
			return _d;
		}
		
		private static function RndStr( str : String ) : String {
			var arr : Array = str.split( "" );
			arr.sort( function() : Boolean {
				return Boolean( int( Math.random() * 2 ));
			});
			return arr.join( "" );
		}
		
		private static function GetBase64DeArray( chrs : String ) : Array {
			var arr : Array = new Array( 128 );
			for( var j : int = 0; j < 128; j++ ) {
				arr[ j ] = -1;
			}
			var fillAry : Function = function( y : int ) : void {
				arr[ chrs.charCodeAt( y )] = y;
			};
			var i : int = 0, len : int = 255, c1 : int, c2 : int, c3 : int;
			while( i < len ) {
				c1 = ( i++ ) & 0xff;
				if( i == len ) {
					fillAry( c1 >>> 2 );
					fillAry(( c1 & 0x3 ) << 4 );
					break;
				}
				c2 = ( i++ ) & 0xff;
				if( i == len ) {
					fillAry( c1 >>> 2 );
					fillAry((( c1 & 0x3 ) << 4 ) | (( c2 & 0xF0 ) >>> 4 ));
					fillAry(( c2 & 0xF ) << 2 );
					break;
				}
				c3 = ( i++ ) & 0xff;
				fillAry( c1 >>> 2 );
				fillAry((( c1 & 0x3 ) << 4 ) | (( c2 & 0xF0 ) >>> 4 ));
				fillAry((( c2 & 0xF ) << 2 ) | (( c3 & 0xC0 ) >>> 6 ));
				fillAry( c3 & 0x3F );
			}
			return arr;
		}
	}
}
