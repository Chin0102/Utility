package cn.chinuy.data.string {
	/**
	 * @author Chin
	 */
	public function extension( path : String ) : String {
		path = path.split( "?" )[ 0 ];
		if( path.lastIndexOf( "." ) >= 0 ) {
			return path.substring( path.lastIndexOf( "." ) + 1, path.length ).toLowerCase();
		} else {
			return "";
		}
	}
}
