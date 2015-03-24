package cn.chinuy.data.string {
	/**
	 * @author Chin
	 */
	public function toArray( param : String, s : String = "," ) : Array {
		if( param == "" || param == null ) {
			return null;
		}
		var paramArray : Array = param.split( s );
		for( var i : int; i < paramArray.length; i++ ) {
			var p : Number = toNumber( paramArray[ i ]);
			if( !isNaN( p )) {
				paramArray[ i ] = p;
			}
		}
		return paramArray;
	}
}
