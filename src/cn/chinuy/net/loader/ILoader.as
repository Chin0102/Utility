package cn.chinuy.net.loader {
	import flash.events.IEventDispatcher;
	
	/**
	 * @author Chin
	 */
	public interface ILoader extends IEventDispatcher {
		function set url( u : String ) : void;
		
		function set method( m : String ) : void;
		
		function set param( d : Object ) : void;
		
		function load( timeout : Number = 60000 ) : void;
		
		function unload() : void;
		
		function get content() : *;
		
		function get error() : Boolean;
		
		function get valid() : Boolean;
		
		function get loading() : Boolean;
		
		function get requestTime() : Number;
	}
}
