package cn.chinuy.data.number {
	/**
	 * @author Chin
	 */
	public function exact( i : Number, n : int ) : Number {
		n = Math.pow( 10, n );
		return Math.round( i * n ) / n;
	}
}
