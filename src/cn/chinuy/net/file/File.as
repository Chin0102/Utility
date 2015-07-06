package cn.chinuy.net.file {
	import cn.chinuy.data.string.extension;
	import cn.chinuy.data.string.isNull;
	
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.FileReference;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	/**
	 * @author Chin
	 */
	public class File extends EventDispatcher implements IEventDispatcher {
		private var fileRef : FileReference;
		
		private var _status : int;
		
		private var timer : Timer;
		
		private var loaded : Number;
		
		private var startTime : Number;
		
		private var tempLoaded : Number;
		
		private var shortArray : ShortArray;
		
		public function File( fr : FileReference ) {
			init( fr );
		}
		
		public function init( fr : FileReference = null ) : void {
			_status = 0;
			if( timer == null ) {
				timer = new Timer( 1000 );
				timer.addEventListener( TimerEvent.TIMER, upadataProgress );
			}
			if( fr == null ) {
				if( fileRef == null )
					fileRef = new FileReference();
			} else {
				fileRef = fr;
			}
		}
		
		public function download( url : String, defaultFileName : String = null ) : void {
			if( fileRef == null )
				return;
			onBegin();
			fileRef.download( new URLRequest( url ), defaultFileName );
		}
		
		public function upload( url : String, getServerReturnValue : Boolean = false ) : void {
			if( fileRef == null )
				return;
			onBegin( getServerReturnValue );
			fileRef.upload( new URLRequest( url ));
		}
		
		public function load() : void {
			if( fileRef == null )
				return;
			onBegin();
			fileRef.load();
		}
		
		public function save( data : *, name : String ) : void {
			if( fileRef == null )
				return;
			onBegin();
			fileRef.save( data, name );
		}
		
		private function onBegin( getServerReturnValue : Boolean = false ) : void {
			addlistener( getServerReturnValue );
			_status = 1;
			shortArray = new ShortArray( 5 );
			loaded = 0;
			upadataProgress();
			timer.start();
		}
		
		public function cancel() : void {
			fileRef.cancel();
			onUploadError();
		}
		
		public function destroy() : void {
			timer.stop();
			timer.removeEventListener( TimerEvent.TIMER, upadataProgress );
			timer = null;
			removeListener();
			fileRef = null;
		}
		
		public function get file() : FileReference {
			return fileRef;
		}
		
		public function get size() : Number {
			return fileRef.size;
		}
		
		public function get name() : String {
			return fileRef.name;
		}
		
		public function get type() : String {
			var t : String = fileRef.type;
			if( isNull( t ))
				t = name;
			return extension( t );
		}
		
		/**0:等待上传  1:正在上传  2:上传完成 3:上传失败或被取消*/
		public function get status() : int {
			return _status;
		}
		
		// 上传完成
		private function onUploadComplete() : void {
			_status = 2;
			timer.stop();
			removeListener();
		}
		
		// 出现错误
		private function onUploadError() : void {
			_status = 3;
			timer.stop();
			removeListener();
		}
		
		protected function dispatch( type : String, value : * = null ) : void {
			dispatchEvent( new FileEvent( type, value ));
		}
		
		// 完成事件
		private function onComplete( e : Event ) : void {
			upadataProgress();
			onUploadComplete();
			dispatch( FileEvent.Complete, "1" );
		}
		
		private function onUploadCompleteData( e : DataEvent ) : void {
			upadataProgress();
			onUploadComplete();
			dispatch( FileEvent.Complete, e.data );
		}
		
		// Http错误
		private function onHTTPError( e : HTTPStatusEvent ) : void {
			onUploadError();
			dispatch( FileEvent.Error, e.status * -1 );
		}
		
		// IO错误
		private function onIOError( e : IOErrorEvent ) : void {
			onUploadError();
			dispatch( FileEvent.Error, -12 );
		}
		
		// Security安全错误
		private function onSecurityError( e : SecurityErrorEvent ) : void {
			onUploadError();
			dispatch( FileEvent.Error, -11 );
		}
		
		// 加载进度
		private function onProgress( e : ProgressEvent ) : void {
			loaded = e.bytesLoaded;
		}
		
		private function upadataProgress( e : TimerEvent = null ) : void {
			var progress : Number, speed : Number, averageSpeed : Number, remainingTime : Number;
			if( loaded == 0 ) {
				progress = averageSpeed = speed = 0;
				startTime = getTimer();
				remainingTime = NaN;
			} else {
				shortArray.push( loaded - tempLoaded );
				speed = int( shortArray.total / shortArray.length );
				var time : Number = getTimer() - startTime;
				averageSpeed = time == 0 ? 0 : loaded / ( time / 1000 );
				remainingTime = averageSpeed == 0 ? NaN : Math.ceil(( size - loaded ) / averageSpeed );
				progress = Math.floor( loaded / size * 100 );
			}
			tempLoaded = loaded;
			dispatch( FileEvent.Progress, { loaded:loaded, speed:speed, averageSpeed:averageSpeed, progress:progress, remainingTime:remainingTime });
		}
		
		private function addlistener( getServerReturnValue : Boolean ) : void {
			fileRef.addEventListener( ProgressEvent.PROGRESS, onProgress );
			if( getServerReturnValue ) {
				fileRef.addEventListener( DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData );
			} else {
				fileRef.addEventListener( Event.COMPLETE, onComplete );
			}
			fileRef.addEventListener( HTTPStatusEvent.HTTP_STATUS, onHTTPError );
			fileRef.addEventListener( IOErrorEvent.IO_ERROR, onIOError );
			fileRef.addEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
		}
		
		private function removeListener() : void {
			fileRef.removeEventListener( ProgressEvent.PROGRESS, onProgress );
			if( fileRef.hasEventListener( Event.COMPLETE ))
				fileRef.removeEventListener( Event.COMPLETE, onComplete );
			if( fileRef.hasEventListener( DataEvent.UPLOAD_COMPLETE_DATA ))
				fileRef.removeEventListener( DataEvent.UPLOAD_COMPLETE_DATA, onUploadCompleteData );
			fileRef.removeEventListener( HTTPStatusEvent.HTTP_STATUS, onHTTPError );
			fileRef.removeEventListener( IOErrorEvent.IO_ERROR, onIOError );
			fileRef.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, onSecurityError );
		}
	}
}

class ShortArray {
	private var _arr : Array;
	
	private var maxLength : Number;
	
	public function ShortArray( max : Number ) : void {
		maxLength = max;
		_arr = [];
	}
	
	public function push( v : Object ) : void {
		if( _arr.length >= maxLength ) {
			_arr.shift();
		}
		_arr.push( v );
	}
	
	public function get length() : Number {
		return _arr.length;
	}
	
	public function get total() : Number {
		var v : Number = 0;
		for( var i : Number = 0; i < _arr.length; i++ ) {
			var num : Number = Number( _arr[ i ]);
			if( !isNaN( num )) {
				v += num;
			}
		}
		return v;
	}
}
