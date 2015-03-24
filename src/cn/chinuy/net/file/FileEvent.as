package cn.chinuy.net.file {
	import flash.events.Event;
	
	/**
	 * @author Chin
	 */
	public class FileEvent extends Event {
		public static const Select : String = "FileUploadEvent.Select";
		public static const Progress : String = "FileUploadEvent.Progress";
		public static const Complete : String = "FileUploadEvent.Complete";
		public static const DataReady : String = "FileUploadEvent.DataReady";
		public static const DataError : String = "FileUploadEvent.DataError";
		
		public static const Error : String = "FileUploadEvent.Error";
		private var _value : *;
		
		public function FileEvent( type : String, value : * = null ) {
			super( type );
			_value = value;
		}
		
		override public function clone() : Event {
			return new FileEvent( type, value );
		}
		
		public function get value() : * {
			return _value;
		}
	}
}
