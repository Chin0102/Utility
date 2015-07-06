package cn.chinuy.net.file {
	import cn.chinuy.data.string.extension;
	import cn.chinuy.data.string.isNull;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	
	/**
	 * @author Chin
	 */
	public class FileBrowser extends EventDispatcher implements IEventDispatcher {
		private var _multi : Boolean;
		private var _fileBrowse : EventDispatcher;
		private var _files : Array;
		private var _fileFilters : Array;
		
		public function FileBrowser( multi : Boolean = false ) {
			init( multi );
		}
		
		public function init( multi : Boolean = false ) : void {
			_multi = multi;
			_files = [];
			if( _fileBrowse ) {
				_fileBrowse.removeEventListener( Event.SELECT, onSelectHandle );
			}
			if( _multi ) {
				_fileBrowse = new FileReferenceList();
			} else {
				_fileBrowse = new FileReference();
			}
			_fileBrowse.addEventListener( Event.SELECT, onSelectHandle );
		}
		
		public function addFileFilter( description : String, extsn : String ) : void {
			if( _fileFilters == null )
				_fileFilters = [];
			_fileFilters.push( new FileFilter( description, extsn ));
		}
		
		public function browse() : void {
			if( _multi ) {
				( _fileBrowse as FileReferenceList ).browse( _fileFilters );
			} else {
				( _fileBrowse as FileReference ).browse( _fileFilters );
			}
		}
		
		public function checkFileType( file : FileReference ) : Boolean {
			if( _fileFilters == null )
				return true;
			var ft : String = file.type;
			if( isNull( ft ))
				ft = file.name;
			ft = ft.split( " " ).join( "" );
			ft = ft.indexOf( "." ) == -1 ? ft.toLowerCase() : extension( ft );
			for( var i : int = 0; i < _fileFilters.length; i++ ) {
				var typeArr : Array = String( FileFilter( _fileFilters[ i ]).extension ).split( ";" );
				for( var j : int = 0; j < typeArr.length; j++ ) {
					var type : String = String( typeArr[ j ]).slice( 2 ).toLowerCase();
					if( type == ft )
						return true;
				}
			}
			return false;
		}
		
		public function get multi() : Boolean {
			return _multi;
		}
		
		public function get fileFilters() : Array {
			return _fileFilters;
		}
		
		public function get files() : Array {
			return _files;
		}
		
		private function onSelectHandle( e : Event ) : void {
			_files = _multi ? ( e.target as FileReferenceList ).fileList : [ e.target as FileReference ];
			var len : int = _files.length;
			for( var i : int = len - 1; i >= 0; i-- ) {
				if( !checkFileType( _files[ i ])) {
					_files.splice( i, 1 );
				}
			}
			if( _files.length > 0 )
				dispatchEvent( new FileEvent( FileEvent.Select, _files ));
		}
	}
}
