package cn.chinuy.utils {
	import flash.display.DisplayObjectContainer;
	import flash.events.ContextMenuEvent;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	
	/**
	 * @author Chin
	 */
	public class ContextMenuUtil {
		private var _cm : ContextMenu;
		
		public function ContextMenuUtil( target : DisplayObjectContainer, createNew : Boolean = false, hideDefalut : Boolean = false ) {
			
			if( createNew || target.contextMenu == null ) {
				create();
			} else {
				_cm = target.contextMenu as ContextMenu;
			}
			
			if( hideDefalut ) {
				hideBuiltIn();
			}
			target.contextMenu = _cm;
		}
		
		public function create() : void {
			_cm = new ContextMenu();
		}
		
		public function hideBuiltIn() : void {
			_cm.hideBuiltInItems();
		}
		
		public function addItem( caption : String, enabled : Boolean = true, callback : Function = null, separatorBefore : Boolean = false, visible : Boolean = true, unshift : Boolean = false ) : ContextMenuItem {
			var item : ContextMenuItem = new ContextMenuItem( caption, separatorBefore, enabled, visible );
			if( callback != null )
				item.addEventListener( ContextMenuEvent.MENU_ITEM_SELECT, function( e : ContextMenuEvent ) : void {
					callback();
				});
			if( unshift ) {
				_cm.customItems.unshift( item );
			} else {
				_cm.customItems.push( item );
			}
			return item;
		}
		
		public function getItem( index : uint ) : ContextMenuItem {
			return _cm.customItems[ index ];
		}
		
		public function getItemNum() : uint {
			return _cm.customItems.length;
		}
		
		public function removeAll() : void {
			while( getItemNum() > 0 ) {
				_cm.customItems.shift();
			}
		}
		
		public function removeItem( item : ContextMenuItem ) : void {
			var i : int = _cm.customItems.indexOf( item );
			if( i >= 0 ) {
				_cm.customItems.splice( i, 1 );
			}
		}
	}
}
