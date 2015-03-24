package cn.chinuy.data.string {
	/**
	 * @author Chin
	 */
	public function complement( input : *, outputSize : uint, useStr : String = "0" ) : String {
		var str : String = String( input );
		while( str.length < outputSize ) {
			str = useStr + str;
		}
		return str;
	}
}
