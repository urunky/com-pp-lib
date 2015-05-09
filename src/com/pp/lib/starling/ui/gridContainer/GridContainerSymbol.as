package com.pp.lib.starling.ui.gridContainer
{
	import com.pp.lib.starling.display.StageSprite;

	public class GridContainerSymbol extends StageSprite
	{
		private var _pw:int 
		public function get pw():int						{	return _pw;	}
		public function set pw(value:int):void		{	_pw = value;	}
		
		private var _ph:int 
		public function get ph():int						{	return _ph;	}
		public function set ph(value:int):void		{	_ph = value;	}

		private var _id:int ;
		public function get id():int						{	return _id ;	}
		public function get key():String					{	return String( _id ) ;		}
		
		public function get gridContainer():GridContainer	{	return parent.parent as GridContainer  ;		}
		
		public function get containerX():int					{	return gridContainer.x + x ;	}
		
		public function get containerY():int					{	return gridContainer.y + y ;	}
		
		public function get containerIdx():int
		{
			 if ( parent ) return parent.getChildIndex( this ) ;
			 return -1 ;
		}
		
		public function GridContainerSymbol( pw:int, ph:int )
		{
			super() ;
			_pw = pw ;
			_ph = ph ;
			_id = 0 ;
		}
		
		protected function show():void
		{
			
		}
		
		public function refresh():void
		{
			
		}
		
		public function clear():void
		{
			
		}
		
		public function toggleSelection():void
		{
			
		}
		
		public function showSelected( bool:Boolean ):void
		{
			
		}
		
		public function destroy():void
		{
			clear() ;
			removeFromParent( true ) ;
		}
	}
}