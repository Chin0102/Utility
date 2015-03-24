package cn.chinuy.data.string {
	/**
	 * @author Chin
	 */
	public function toNumber( str : String, defaultVar : Number = NaN, checkNull : Boolean = false ) : Number {
		if( checkNull && isNull( str ))
			return defaultVar;
		var num : Number = Number( str );
		if( isNaN( num ) || str == "" ) {
			return defaultVar;
		}
		return num;
	}
}
