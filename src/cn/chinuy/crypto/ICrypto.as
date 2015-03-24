package cn.chinuy.crypto {
	
	/**
	 * @author Chin
	 */
	public interface ICrypto {
		
		function decode( str : String ) : String;
		function encode( str : String ) : String;
	
	}
}
