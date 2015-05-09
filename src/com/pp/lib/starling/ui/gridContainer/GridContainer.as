package com.pp.lib.starling.ui.gridContainer
{
	import com.pp.lib.starling.display.Container;
	import com.pp.lib.starling.ui.Padding;
	
	import flash.geom.Point;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.utils.HAlign;
	import starling.utils.VAlign;
	
	public class GridContainer extends Container
	{
		public function get pw():int				
		{
			var val:int = 0 ;
			if ( _direction == HAlign.LEFT )
			{
				val = _padding.left + countDirection * _symbolWidth + ( countDirection - 1 ) * _hSpacing + _padding.right ;
			}
			else
			{
				val = _padding.left + _numDirection * _symbolWidth + ( _numDirection - 1 ) * _hSpacing + _padding.right ;
			}
			return val ;	
		}
		
		public function get ph():int				
		{
			var val:int = 0 ;
			if ( _direction == HAlign.LEFT  )
			{
				val = _padding.top + _numDirection * _symbolHeight + ( _numDirection - 1 ) * _vSpacing + _padding.bottom ;
			}
			else
			{
				val = _padding.top + countDirection * _symbolHeight + ( countDirection - 1 ) * _vSpacing + _padding.bottom ;
			}
			return val ;	
		}
		
		public function get countDirection():int
		{
			if ( _symbolContainer.numChildren == 0 ) return 1 ;
			return Math.ceil( _symbolContainer.numChildren / _numDirection ) ;
		}
		
		private var _hSpacing:int 
		public function get hSpacing():int						{	return _hSpacing;	}

		private var _vSpacing:int 
		public function get vSpacing():int						{	return _vSpacing;	}

		private var _direction:String 
		public function get direction():String					{	return _direction;	}

		private var _numDirection:int ;
		
		private var _symbolWidth:int ;
		public function get symbolWidth():int					{	return _symbolWidth;	}

		private var _symbolHeight:int ;
		public function get symbolHeight():int					{	return _symbolHeight;	}

		private var _topLeft:Point ;
		private var _bottomRight:Point ;
		
		private var _padding:Padding ;
		public function get padding():Padding					{	return _padding;	}

		private var _symbolByIdx:Array ;

		public function get hDistance():int					{	return _symbolWidth + _hSpacing ;	}
		public function get vDistance():int					{	return _symbolHeight + _vSpacing ;	}
		
		private var _symbolContainer:Sprite ;
		
		public function get symbolIdxLength():int				{	return _symbolByIdx.length }
		
		public function get symbolNum():int						{	return _symbolContainer.numChildren ;	}
		
		public function get allChildren():Array
		{
			var arr:Array = [] ;
			var len:int = _symbolContainer.numChildren ;
			for ( var i:int = 0 ; i < len ; i++ ) arr[ arr.length ] = _symbolContainer.getChildAt(i)  ;
			return arr ;
		}
		
		public function GridContainer( direction:String, symbolWidth:int, symbolHeight:int, 
									   numDirection:int, hSpacing:int = 0, vSpacing:int = 0, padding:Padding = null  )
		{
			super() ;
			_direction = direction ;
			_symbolWidth = symbolWidth ;
			_symbolHeight = symbolHeight ;
			_numDirection = numDirection ;
			_hSpacing = hSpacing ;
			_vSpacing = vSpacing ;
			_padding = padding ;
			if ( _padding == null ) _padding = new Padding ;
			init() ;
			
		}
		
		private function init():void
		{
			_symbolByIdx = [] ;
			
			_symbolContainer = new Sprite ;
			addChild( _symbolContainer ) ;
		}
		
		
	/*	
		public function getTouchedAncestorByClass( cls:Class ):DisplayObject
		{
			//return DisplayObjectHelper.findAncestorByClass( _touchManager.touch.target, cls, this ) ;
			return getAncestorByClass( _touchManager.touch.target, cls) ;
		}
	*/
		
		
		public function add( symbol:GridContainerSymbol, delay:Number = 0 ):void
		{
			var idx:int = symbolNum ; ;
			
			_symbolByIdx[ idx ] = symbol ;
			var vIdx:int ;
			var hIdx:int ;
		
			if ( _direction == HAlign.LEFT )
			{
				vIdx = idx % _numDirection ;
				hIdx = int( idx / _numDirection ) ;
			}
			else if ( _direction == VAlign.BOTTOM )
			{
				vIdx = int( idx / _numDirection ) * -1;
				hIdx = ( idx % _numDirection ) ;
			}
			else
			{
				vIdx = int( idx / _numDirection ) ;
				hIdx = ( idx % _numDirection ) ;
			}
			symbol.x = _padding.left + hIdx * hDistance ;
			symbol.y = _padding.top + vIdx * vDistance ;
			_symbolContainer.addChild( symbol as DisplayObject ) ;
			symbol.visible = false ;
			if ( delay > 0 )
			{
				var onDelay:Function = function():void
				{
					symbol.visible = true ;
				//	symbol.alpha = 0;
				//	TweenLite.to( symbol, 0.1, {"alpha":1 } ) ;
				}
				Starling.juggler.delayCall( onDelay, delay ) ;
			}
			else
			{
				symbol.visible = true ;
			}
			
		}
		
		
		public function refresh():void
		{
			var len:int = _symbolContainer.numChildren ;
			for (var i:int = 0; i < len; i++) 
			{
				( _symbolContainer.getChildAt(i) as GridContainerSymbol ).refresh() ;
			}
			
		}
	
		public function remove( removedSymbol:GridContainerSymbol ):void
		{
			var idx:int = _symbolByIdx.indexOf( removedSymbol ) ;//getChildIndex( symbol ) ;
			
		/*	if ( idx >= 0 )
			{
				var symbol:GridContainerSymbol ;
				var prevSymbol:GridContainerSymbol ;
				var delay:Number = 0 ;
				prevSymbol = removedSymbol ;
				var len:int = _symbolByIdx.length ;
				for (var i:int = idx + 1 ; i < len; i++) 
				{
					symbol = _symbolByIdx[ i ] as GridContainerSymbol ;
				//	TweenLite.to( symbol, 0.1, {"delay":delay, "x":prevSymbol.x } ) ;
					prevSymbol = symbol ;
					delay += 0.05 ;
				}
				_symbolByIdx.splice( idx, 1 ) ;
			}*/
			removedSymbol.destroy() ;
		}
		
	
	
		public function findSymbolByIdx( idx:int ):GridContainerSymbol
		{
			return _symbolByIdx[ idx ] as GridContainerSymbol ;
		}
		
		public function findIdxBySymbol( symbol:GridContainerSymbol ):int
		{
			return _symbolByIdx.indexOf( symbol ) ;
		}
			
		public function clear():void
		{
			var symbol:GridContainerSymbol ;
			while ( _symbolContainer.numChildren > 0 ) 
			{
				symbol = _symbolContainer.getChildAt( 0 ) as GridContainerSymbol ;
				symbol.destroy() ;
			}
		}
		
		override protected function removedFromStage():void
		{
			clear() ;
			super.removedFromStage() ;
		}
		
		public function moveFront( symbol:GridContainerSymbol ):void
		{
			_symbolContainer.setChildIndex( symbol as DisplayObject, _symbolContainer.numChildren - 1 ) ;
		}
	}
}