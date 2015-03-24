package cn.chinuy.data.time {
	import cn.chinuy.data.string.complement;
	
	/**
	 * @author chin
	 */
	public class TimeFormat {
		
		private static var _srtFormat : TimeFormat;
		private static var _playerFormat : TimeFormat;
		
		public static function get PLAYER() : TimeFormat {
			if( _playerFormat == null ) {
				_playerFormat = new TimeFormat();
				_playerFormat.addAction( 60, 2, "" );
				_playerFormat.addAction( -1, 2, ":" );
			}
			return _playerFormat;
		}
		
		public static function get SRT() : TimeFormat {
			if( _srtFormat == null ) {
				_srtFormat = new TimeFormat();
				_srtFormat.addAction( 1000, 3, "" );
				_srtFormat.addAction( 60, 2, "," );
				_srtFormat.addAction( 60, 2, ":" );
				_srtFormat.addAction( -1, 2, ":" );
			}
			return _srtFormat;
		}
		
		private var formatAction : Array = [];
		
		public function addAction( num : Number, complement : uint, append : String, complementWith : String = "0" ) : void {
			formatAction.push({ num:num, complement:complement, append:append, complementWith:complementWith });
		}
		
		public function format( time : uint ) : String {
			var len : int = formatAction.length;
			var output : String = "";
			for( var i : int = 0; i < len; i++ ) {
				var obj : Object = formatAction[ i ];
				var num : Number;
				var an : Number = obj[ "num" ];
				if( an > 0 ) {
					num = time % an;
					time -= num;
					time /= obj[ "num" ];
				} else {
					num = time;
					time -= num;
				}
				output = complement( num, obj[ "complement" ], obj[ "complementWith" ]) + obj[ "append" ] + output;
			}
			return output;
		}
	
	}
}
