package cn.chinuy.net.loader {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	 * @author Chin
	 */
	public class APILoader extends BaseLoader implements ILoader {
		private var _loader : URLLoader;
		
		override protected function newLoader() : void {
			_dispatcher = _loader = new URLLoader();
		}
		
		override protected function toLoad( request : URLRequest ) : void {
			_loader.load( request );
		}
		
		override protected function toUnload() : void {
			_loader.close();
		}
		
		override public function get content() : * {
			return _loader.data;
		}
	}
}
