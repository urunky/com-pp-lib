// =================================================================================================
// Jul 6, 2014
// =================================================================================================

package com.pp.lib.starling.display
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
	public class Container extends StageSprite
	{
		public function Container( )
		{
			super();
		}
		
		public function setChildrenTouchable( value:Boolean ):void
		{
			var len:int = numChildren ;
			var dispObj:DisplayObject ;
			for (var i:int = 0; i < len; i++) 
			{
				dispObj = getChildAt(i) ;
				if ( dispObj is Container )
				{
					( dispObj as Container ).setChildrenTouchable( value ) ;
				}
				else
				{
					dispObj.touchable = value ;	
				}
			}
		}
		
		public function addResizedChild( dispObj:DisplayObject, scale:Number,  xRatio:Number= 0, yRatio:Number = 0 ):void
		{
			dispObj.scaleX = dispObj.scaleY = scale ;
			dispObj.x = Starling.current.viewPort.width * xRatio ;
			dispObj.y = Starling.current.viewPort.height * yRatio ; 
			addChild( dispObj ) ;
		}
		
	
		public function getChildrenByClass( cls:Class ):Array
		{
			if ( cls is Container ) return [] ;
			var arr:Array = [] ;
			var dispObj:DisplayObject ;
			var dispObjsInContainer:Array ;
			var maxIdx:int = numChildren - 1 ;
			for ( var i:int = maxIdx ; i > -1; i--) 
			{
				dispObj = getChildAt(i) ;
				if ( !dispObj ) continue ;
				if ( dispObj is Container )
				{
					dispObjsInContainer = ( dispObj as Container ).getChildrenByClass( cls ) ;
					arr = arr.concat( dispObjsInContainer ) ;
				}
				else
				{
					if ( dispObj is cls ) arr.push( dispObj ) ;
				}
				
			}
			return arr ;
		}
		
		public function getChildByClass( cls:Class, useRecursive:Boolean = true ):DisplayObject
		{
			if ( cls is Container ) return null ;
			var dispObj:DisplayObject ;
			var dispObjInContainer:DisplayObject ;
			var maxIdx:int = numChildren - 1 ;
			for ( var i:int = maxIdx ; i > -1; i--) 
			{
				dispObj = getChildAt( i ) ;
				if ( !dispObj ) continue ;
				if ( dispObj is Container )
				{
					if ( useRecursive )
					{
						dispObjInContainer = ( dispObj as Container ).getChildByClass( cls, useRecursive ) ;
						if ( dispObjInContainer ) return dispObjInContainer ;
					}
				}
				else
				{
					if ( dispObj is cls ) return dispObj ;
				}
				
			}
			return null ;
		}
	}
}