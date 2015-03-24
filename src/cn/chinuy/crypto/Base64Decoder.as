package cn.chinuy.crypto {
	
	public class Base64Decoder {
		// public static var d : Array = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 20, 50, -1, 28, 23, 27, 55, 32, 16, 31, 4, 60, 8, -1, -1, -1, -1, -1, -1, -1, 12, 1, 24, 3, 36, 5, 6, 7, 61, 9, 10, 11, 0, 38, 51, 15, 57, 17, 18, 43, 62, 21, 22, 53, 2, 25, -1, -1, -1, -1, -1, -1, 26, 54, 52, 29, 30, 58, 56, 33, 34, 42, 59, 37, 13, 39, 40, 41, 35, 19, 44, 45, 46, 47, 48, 49, 63, 14, -1, -1, -1, -1, -1];
		public static var d : Array = [ -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 31, -1, 39, 18, 27, 61, 53, 26, 32, 30, 38, 2, 42, 58, 1, -1, -1, -1, -1, -1, -1, -1, 13, 49, 4, 16, 6, 14, 20, 41, 56, -1, 17, 33, 34, 57, 8, 37, 62, 63, 11, 60, 28, 36, 43, 0, -1, 7, -1, -1, -1, -1, -1, -1, 21, 48, 24, 45, 51, 29, 19, 25, 54, 59, 50, 3, 15, 52, -1, 35, 47, 10, 12, 9, 44, 5, 40, 55, 22, 23, -1, 46, -1, -1, -1 ];
		
		static public function decode( str : String ) : String {
			var c1 : Number, c2 : Number, c3 : Number, c4 : Number;
			var len : Number = str.length;
			var i : Number = 0;
			var out : String = "";
			while( i < len ) {
				do {
					c1 = d[ str.charCodeAt( i++ ) & 0xff ];
				} while( i < len && c1 == -1 );
				if( c1 == -1 )
					break;
				do {
					c2 = d[ str.charCodeAt( i++ ) & 0xff ];
				} while( i < len && c2 == -1 );
				if( c2 == -1 )
					break;
				out += String.fromCharCode(( c1 << 2 ) | (( c2 & 0x30 ) >>> 4 ));
				do {
					c3 = str.charCodeAt( i++ ) & 0xff;
					if( c3 == 61 )
						return out;
					c3 = d[ c3 ];
				} while( i < len && c3 == -1 );
				if( c3 == -1 )
					break;
				out += String.fromCharCode((( c2 & 0xF ) << 4 ) | (( c3 & 0x3C ) >>> 2 ));
				do {
					c4 = str.charCodeAt( i++ ) & 0xff;
					if( c4 == 61 )
						return out;
					c4 = d[ c4 ];
				} while( i < len && c4 == -1 );
				if( c4 == -1 )
					break;
				out += String.fromCharCode((( c3 & 0x03 ) << 6 ) | c4 );
			}
			return out;
		}
	}
}
