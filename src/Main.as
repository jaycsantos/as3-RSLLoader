package
{
	import assets.CircleSprite;
	import assets.HexStarClip;
	import flash.display.Sprite
	import flash.events.Event;
	import jaycsantos.util.RSLLoader;
	
	
	public class Main extends Sprite 
	{
		
		public function Main():void 
		{
			if ( stage ) init( null );
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		private function init( e:Event ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			
			CONFIG::debug {
				RSLLoader.loadExternal( start, "rsl/visualAssets.swf" );
			}
			CONFIG::release {
				RSLLoader.loadEmbedded( start, new VisualAssets() );
			}
		}
		
		private function start():void
		{
			var circle:CircleSprite = new CircleSprite();
			circle.x = 100;
			circle.y = 100;
			addChild( circle );
			trace( circle );
			
			var star:HexStarClip = new HexStarClip();
			star.x = 250;
			star.y = 250;
			addChild( star );
		}
		
	}
	
}