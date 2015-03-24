package cn.chinuy.crypto {
	import com.hurlant.crypto.symmetric.DESKey;
	import com.hurlant.crypto.symmetric.ECBMode;
	import com.hurlant.crypto.symmetric.IPad;
	import com.hurlant.crypto.symmetric.PKCS5;
	import com.hurlant.util.Hex;
	
	import flash.utils.ByteArray;
	
	/**
	 * Chin
	 */
	public class DES {
		
		private var _key : String = "12345678";
		
		public function DES( key : String = "12345678" ) {
			this.key = key;
		}
		
		public function get key() : String {
			return _key;
		}
		
		public function set key( key : String ) : void {
			_key = key;
		}
		
		public function encrypt( content : ByteArray ) : void {
			var _keyBytes : ByteArray = Hex.toArray( Hex.fromString( key ));
			var des : DESKey = new DESKey( _keyBytes );
			var pad : IPad = new PKCS5;
			var ecb : ECBMode = new ECBMode( des, pad );
			pad.setBlockSize( ecb.getBlockSize());
			ecb.encrypt( content );
		}
		
		public function decrypt( content : ByteArray ) : void {
			var _keyBytes : ByteArray = Hex.toArray( Hex.fromString( key ));
			var des : DESKey = new DESKey( _keyBytes );
			var pad : IPad = new PKCS5;
			var ecb : ECBMode = new ECBMode( des, pad );
			pad.setBlockSize( ecb.getBlockSize());
			ecb.decrypt( content );
		}
		
		public function encode( txt : String = "" ) : String {
			var content : ByteArray = Hex.toArray( Hex.fromString( txt ));
			encrypt( content );
			return Hex.fromArray( content ).toUpperCase();
		}
		
		public function decode( txt : String = "" ) : String {
			var content : ByteArray = Hex.toArray( txt );
			decrypt( content );
			content.readMultiByte( content.bytesAvailable, 'UTF-8' );
			return Hex.toString( Hex.fromArray( content ));
		}
	}
}
