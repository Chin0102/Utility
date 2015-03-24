package cn.chinuy.data.string {
	/**
	 * @author Chin
	 */
	public function toBoolean( vars : String, defaultVar : Boolean = false ) : Boolean {
		if( isNull( vars ))
			return defaultVar;
		vars = vars.toLowerCase();
		var isTrue : Boolean = vars == "true" || vars == "1";
		var isFalse : Boolean = vars == "false" || vars == "0";
		return ( isTrue || isFalse ) ? isTrue : defaultVar;
	}
}
