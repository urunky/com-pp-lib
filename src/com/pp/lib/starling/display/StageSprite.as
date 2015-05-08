package com.pp.lib.starling.display
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class StageSprite extends Sprite
	{
		public function StageSprite()
		{
			super();
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage ) ;
		}
		
		private function onAddedToStage( e:Event ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage ) ;
			addEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromoStage ) ;
			addedToStage() ;
		}
		
		private function onRemovedFromoStage( e:Event ):void
		{
			addEventListener( Event.ADDED_TO_STAGE, onAddedToStage ) ;
			removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromoStage ) ;
			removedFromStage() ;
		}
		
		protected function addedToStage():void
		{
			
		}
		
		protected function removedFromStage():void
		{
			
		}
		
		public function getAncestorByClass( childDispObj:DisplayObject, cls:Class ):DisplayObject
		{
			var p:DisplayObject = childDispObj.parent ;//e.data.parent as DisplayObject ;
			while ( p != this ) 
			{
				if ( p == Starling.current.root ) return null ;
				if ( p is cls ) return p ;
				p = p.parent ;
			}
			return null ;
		}
	}
}