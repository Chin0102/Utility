package cn.chinuy.data.string {
	/**
	 * @author Chin
	 */
	public function as2_escape( str : String ) : String {
		var escapeConstStr : Object = { "-":"%2D", "_":"%5F", ".":"%2E", "!":"%21", "~":"%7E", "*":"%2A", "'":"%27", "(":"%28", ")":"%29" };
		str = encodeURIComponent( str );
		var newStr : String = "";
		var len : int = str.length;
		for( var i : int; i < len; i++ ) {
			var char : String = str.charAt( i );
			var escapeChar : String = escapeConstStr[ char ];
			newStr += escapeChar == null ? char : escapeChar;
		}
		return newStr;
	}
}
