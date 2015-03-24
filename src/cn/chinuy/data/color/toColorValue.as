package cn.chinuy.data.color {
	/**
	 * @author Chin
	 */
	public function toColorValue( colorStr : String ) : int {
		if( colorStr != null ) {
			if( colorStr.indexOf( "#" ) == 0 ) {
				return int( "0x" + colorStr.slice( 1, 7 ));
			} else if( colorStr.indexOf( "0x" ) == 0 ) {
				return int( colorStr.slice( 0, 8 ));
			}
		}
		return -1;
	}
}
