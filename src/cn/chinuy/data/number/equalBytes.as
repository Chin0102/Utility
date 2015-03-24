package cn.chinuy.data.number {
	
	/**
	 * @author Chin
	 */
	public function equalBytes( b : Number, hexademical : Number = NaN ) : String {
		var k : Number = 1024;
		var m : Number = k * 1024;
		var g : Number = m * 1024;
		var dw : String = "";
		var n : Number;
		if( isNaN( hexademical )) {
			if( b == 0 ) {
				n = 0;
				dw = "KB";
			} else if( b >= g ) {
				n = b / g;
				dw = "GB";
			} else if( b >= m ) {
				n = b / m;
				dw = "MB";
			} else if( b >= k ) {
				n = b / k;
				dw = "KB";
			} else {
				n = b;
				dw = "B";
			}
		} else {
			switch( hexademical ) {
				case 1: //kb
					n = b / k;
					break;
				case 2: //mb
					n = b / m;
					break;
				case 3: //gb
					n = b / g;
					break;
				default:
					n = b;
			}
		}
		return String( Math.round( n * 100 ) / 100 ) + dw;
	}
}
