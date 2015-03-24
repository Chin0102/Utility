package cn.chinuy.data.object {
	/**
	 * @author Chin
	 */
	public function shallowCopy( source : Object ) : Object {
		var newObj : Object = {};
		if( source ) {
			for( var i : String in source ) {
				newObj[ i ] = source[ i ];
			}
		}
		return newObj;
	}
}
