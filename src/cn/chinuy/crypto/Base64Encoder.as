package cn.chinuy.crypto {
	
	public class Base64Encoder {
		//public static var e : String = "MBYD7FGH9JKLAmzP5RSr-VW1CZa20de64hiqElNnopjTstuvwx.OcXb3gQfk8IUy";
		public static var e : String = "X96lCvEZOtrSsAFmDK.gGayzch2/Uf4+3LMpVP5-wH7Wud|qbBken1ixIN8jT0QR";
		
		static public function encode( str : String ) : String {
			var c1 : Number, c2 : Number, c3 : Number;
			var len : Number = str.length;
			var i : Number = 0;
			var out : String = "";
			while( i < len ) {
				c1 = str.charCodeAt( i++ ) & 0xff;
				if( i == len ) {
					out += e.charAt( c1 >>> 2 );
					out += e.charAt(( c1 & 0x3 ) << 4 );
					out += "==";
					break;
				}
				c2 = str.charCodeAt( i++ ) & 0xff;
				if( i == len ) {
					out += e.charAt( c1 >>> 2 );
					out += e.charAt((( c1 & 0x3 ) << 4 ) | (( c2 & 0xF0 ) >>> 4 ));
					out += e.charAt(( c2 & 0xF ) << 2 );
					out += "=";
					break;
				}
				c3 = str.charCodeAt( i++ ) & 0xff;
				out += e.charAt( c1 >>> 2 );
				out += e.charAt((( c1 & 0x3 ) << 4 ) | (( c2 & 0xF0 ) >>> 4 ));
				out += e.charAt((( c2 & 0xF ) << 2 ) | (( c3 & 0xC0 ) >>> 6 ));
				out += e.charAt( c3 & 0x3F );
			}
			return out;
		}
	}
}
