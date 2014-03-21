package jaycsantos.util 
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.errors.IOError;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.Security;
	import flash.system.SecurityDomain;
	import flash.utils.ByteArray;
	
	
	public class RSLLoader
	{
		/**
		 * Loads external swf file as a shared library. Recommended for debug builds.
		 * 
		 * @param	onLoad optional function, called when all from list is loaded
		 * @param	...list files to load relative to output file of project
		 */
		public static function loadExternal( onLoad:Function=null, ...list ):void
		{
			Security.allowDomain('*');
			var loader:Loader;
			var context:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );
			
			for each ( var file:String in list ) {
				_list.push( loader = new Loader );
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _loaded, false, 0, true );
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, 0, true );
				loader.load( new URLRequest(file), context );
			}
			
			_onLoad = onLoad;
		}
		
		/**
		 * Loads embedded swf as a shared library. Recommended for release builds.
		 * 
		 * @param	onLoad optional function, called when all from list is loaded
		 * @param	...list instances of the embedded class
		 */
		public static function loadEmbedded( onLoad:Function=null, ...list ):void
		{
			Security.allowDomain('*');
			var loader:Loader;
			var contxt:LoaderContext = new LoaderContext( false, ApplicationDomain.currentDomain );
			
			for each ( var bytes:ByteArray in list ) {
				_list.push( loader = new Loader );
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, _loaded, false, 0, true );
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, _ioError, false, 0, true );
				loader.loadBytes( bytes, contxt );
			}
			
			_onLoad = onLoad;
		}
		
		
		private static var _list:Vector.<Loader> = new Vector.<Loader>;
		private static var _onLoad:Function;
		
		
		private static function _loaded( ev:Event ):void
		{
			var loaderInfo:LoaderInfo = ev.target as LoaderInfo;
			loaderInfo.loader.removeEventListener( Event.COMPLETE, _loaded );
			loaderInfo.loader.removeEventListener( IOErrorEvent.IO_ERROR, _ioError );
			
			var p:int = _list.indexOf( loaderInfo.loader );
			if ( p != -1 ) {
				_list.splice( p, 1 );
				//CONFIG::debug { trace( '4:[RSL] loaded', loaderInfo.url.substr(loaderInfo.url.lastIndexOf('/') + 1) ); }
			}
			
			if ( !_list.length && _onLoad != null ) _onLoad();
		}
		
		private static function _ioError( ev:IOErrorEvent ):void
		{
			//CONFIG::debug{ trace( '3:[RSL] ioError: ' + ev.toString() ); }
			throw new IOError( ev.toString(), ev.errorID );
		}
		
		
	}

}