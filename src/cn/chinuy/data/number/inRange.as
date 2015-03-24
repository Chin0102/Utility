package cn.chinuy.data.number {
	/**
	 * @author Chin
	 */
	public function inRange( value : Number, max : Number = NaN, min : Number = 0 ) : Number {
		if( !isNaN( max ))
			value = Math.min( max, value );
		if( !isNaN( min ))
			value = Math.max( min, value );
		return value;
	}
}
