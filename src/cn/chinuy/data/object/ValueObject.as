package cn.chinuy.data.object {
	
	/**
	 * @author Chin
	 */
	public class ValueObject {
		
		private var _value : Object = {};
		
		public function set( key : String, value : * ) : void {
			_value[ key ] = value;
		}
		
		public function get( key : String ) : * {
			return _value[ key ];
		}
		
		public function getValue( key : String, defaultValue : * = null ) : * {
			if( has( key ))
				return get( key );
			return defaultValue;
		}
		
		public function copyFromObj( obj : Object ) : void {
			for( var i : String in obj )
				set( i, obj[ i ]);
		}
		
		public function has( key : String ) : Boolean {
			return _value[ key ] != null;
		}
		
		public function del( key : String ) : void {
			delete _value[ key ];
		}
	
	}
}
