package cn.chinuy.crypto {
	
	public class Base64 implements ICrypto {
		
		public function decode( str : String ) : String {
			return Base64Decoder.decode( str );
		}
		
		public function encode( str : String ) : String {
			return Base64Encoder.encode( str );
		}
	}
}
