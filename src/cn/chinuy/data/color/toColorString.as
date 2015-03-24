package cn.chinuy.data.color {
	/**
	 * @author Chin
	 */
	public function toColorString( color : int, prefix : String = "0x" ) : String {
		if( color >= 0 && color <= 0xFFFFFF ) {
			var str : String = color.toString( 16 ).toUpperCase();
			while( str.length < 6 ) {
				str = "0" + str;
			}
			return prefix + str;
		} else {
			return null;
		}
	}
}
