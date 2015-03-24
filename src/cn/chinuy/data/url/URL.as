package cn.chinuy.data.url {
	
	/**
	 * @author Chin
	 */
	public class URL extends RequestURL {
		
		public static const FILE : String = "file:///";
		public static const HTTP : String = "http://";
		
		private var _simpleUrl : String;
		private var _protocol : String;
		private var _domain : String;
		private var _fullDomain : String;
		private var _simpleDomain : String;
		private var _directory : String;
		private var _file : String;
		private var _extension : String;
		private var _folder : Array;
		
		public function URL( url : String ) {
			super( url );
		}
		
		override public function set value( url : String ) : void {
			super.value = url;
			_protocol = FILE;
			var web : Boolean = _pureUrl.indexOf( _protocol ) == -1;
			var num : Number = web ? _pureUrl.indexOf( "://" ) + 3 : 8;
			_protocol = _pureUrl.slice( 0, num );
			_simpleUrl = _pureUrl.slice( num );
			_folder = _simpleUrl.split( "/" );
			_domain = _simpleDomain = _folder[ 0 ];
			var tempArr : Array = _domain.split( "." );
			if( tempArr[ 0 ] == "www" ) {
				tempArr.shift();
				_simpleDomain = tempArr.join( "." );
			}
			_fullDomain = _protocol + _domain;
			_file = _folder[ _folder.length - 1 ];
			num = _file.lastIndexOf( "." );
			_extension = _file.slice( num + 1 );
			num = _pureUrl.lastIndexOf( "/" );
			_directory = _pureUrl.slice( 0, num );
		}
		
		/**
		 * 不带协议(http://)不带参数的URL
		 */
		public function get simpleUrl() : String {
			return _simpleUrl;
		}
		
		/**
		 * 协议
		 */
		public function get protocol() : String {
			return _protocol;
		}
		
		/**
		 * 域(格式 : www.bokecc.com  、 union.bokecc.com )
		 */
		public function get domain() : String {
			return _domain;
		}
		
		/**
		 * 域(格式 : http://www.bokecc.com )
		 */
		public function get fullDomain() : String {
			return _fullDomain;
		}
		
		/**
		 * 域(格式 : bokecc.com  、 union.bokecc.com )
		 */
		public function get simpleDomain() : String {
			return _simpleDomain;
		}
		
		/**
		 * 最深目录
		 */
		public function get directory() : String {
			return _directory;
		}
		
		/**
		 * 文件名
		 */
		public function get file() : String {
			return _file;
		}
		
		/**
		 * 文件扩展名
		 */
		public function get extension() : String {
			return _extension;
		}
		
		public function get folder() : Array {
			return _folder;
		}
	}
}
