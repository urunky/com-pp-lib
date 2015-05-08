package com.pp.lib.astar
{
	public class AStarNode implements IAStarNode
	{
		private var _g:int = 0;  
		public function get g():int											{	return _g;		}
		public function set g( val:int):void								{	_g = val;		}
		
		private var _h:int = 0;
		public function get h():int											{	return _h;		}
		public function set h( val:int):void								{	_h = val;		}
		
		private var _parent:IAStarNode ; 
		public function get parent():IAStarNode								{	return _parent;		}
		public function set parent( val:IAStarNode ):void					{	_parent = val;	}
		
		private var _nbByKey:Object ;
		public function get nbByKey():Object				{	return _nbByKey ;	}
		
		public function get f():int 						{	return _g + _h;		}
		
		private var _gridX:int ;
		public function get gridX():int						{	return _gridX ;	}
		
		private var _gridY:int ;
		public function get gridY():int						{	return _gridY ;	}
		
	//	private var _occupant:Object ;
	//	public function get occupant():Object					{	return _occupant;	}
	//	public function set occupant( value:Object ):void		{	_occupant = value;	}
		
		private var _gridKey:String ;
		public function get gridKey():String					{	return _gridKey;	}

		private var _viewX:int 
		public function get viewX():int	{	return _viewX;	}

		private var _viewY:int 
		public function get viewY():int	{	return _viewY;	}

		private var _walkable:Boolean ;
		public function get walkable():Boolean					{	return _walkable;	}
		public function set walkable(value:Boolean):void		{	_walkable = value;	}
/*
		private var _occupied:Boolean ;
		public function get occupied():Boolean					{	return _occupied;	}
		public function set occupied(value:Boolean):void		{	_occupied = value;	}*/

		public function AStarNode( gridX:int, gridY:int, viewX:int, viewY:int )
		{
			_gridX = gridX ;
			_gridY = gridY ;
			_gridKey = String( _gridX ) + "," + String( _gridY ) ;
			_viewX = viewX ;
			_viewY = viewY ;
			_nbByKey = {} ;
		//	_occupant = null ;
			_walkable = true ;
		//	_occupied = false ;
		}
		
		public function reset():void
		{
			_nbByKey["l"] = null ;
			_nbByKey["r"] = null ;
			_nbByKey["t"] = null ;
			_nbByKey["b"] = null ;
			_nbByKey["lt"] = null ;
			_nbByKey["rt"] = null ;
			_nbByKey["lb"] = null ;
			_nbByKey["rb"] = null ;
		}
		
		public function findWalkableNeighborNodeFrom( fromX:int, fromY:int ):IAStarNode
		{
			var arr:Array = [] ;
			var node:IAStarNode ;
			var dist:int ;
			var minDist:int = int.MAX_VALUE ;
			var minNode:IAStarNode = null ;
			var absX:int ;
			var absY:int ;
			for each ( node in nbByKey )
			{
				if ( node.isWalkable() ) 
				{
					if ( node.gridX == gridX && node.gridY < gridY ) continue ;
					absX = Math.abs( node.gridX - fromX );
					absY = Math.abs( node.gridY - fromY ) ;
					dist = absX * absX + absY * absY ;
					if ( dist < minDist )
					{
						minDist = dist ;
						minNode = node ;
					}
				}
			}
			return minNode ;
		}
		
		public function findWalkableNeighborNodes( fromNode:IAStarNode, nodes:Array, depth:int ):void
		{
			var arr:Array = [] ;
			
			for each ( var node:IAStarNode in nbByKey )
			{
				if ( nodes.indexOf( node ) < 0 )
				{
					if ( node.isWalkable() ) arr.push( node ) ;
				}
				
			}
			if ( arr.length > 0 ) 
			{
				var toNode:IAStarNode = arr[ int( Math.random() * arr.length ) ] ;
				nodes.push( toNode ) ;
				if ( nodes.length < depth ) toNode.findWalkableNeighborNodes( this, nodes, depth ) ;
			}
		}
		
		
		public function isWalkable():Boolean
		{
			return _walkable ;
		}
	}
}
