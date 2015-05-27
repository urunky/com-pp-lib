package com.pp.lib.astar
{
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class AStarGrid
	{
		private var _aStar:AStar ;
		private var _nodeByGrid:Object ;
		
		private var _minGridX:int ;
		private var _maxGridX:int ;
		private var _minGridY:int ;
		private var _maxGridY:int ;
		private var _gridToViewMat:Matrix ;
		private var _gridValidator:IGridValidator ;
		
		private var _nodes:Vector.<AStarNode> ;
		
		public function AStarGrid( minGridX:int, maxGridX:int, minGridY:int, maxGridY:int, gridToViewMat:Matrix, gridValidator:IGridValidator  )
		{
			_minGridX = minGridX ;
			_maxGridX = maxGridX ;
			
			_minGridY = minGridY ;
			_maxGridY = maxGridY ;
			
			_gridToViewMat = gridToViewMat ;
			_gridValidator = gridValidator ;
			init() ;
		}
		
		private function init():void
		{
			_aStar = new AStar ;
			makeDefaultAStarNodes() ;
			
			_nodes = new Vector.<AStarNode> ;
		}
		
		private function makeDefaultAStarNodes():void
		{
			var viewPoint:Point = new Point ;
			var gridPoint:Point = new Point ;
			var cnt:int = 0 ;
			for ( var i:int = _minGridX ; i < _maxGridX ; i++) 
			{
				for ( var j:int = _minGridY ; j < _maxGridY   ; j++ )
				{
					gridPoint.x = i ;
					gridPoint.y = j ;
					viewPoint = _gridToViewMat.transformPoint( gridPoint ) ;
					
					if ( !_gridValidator.isValid( gridPoint, viewPoint ) ) continue ;
					
					var node:AStarNode = new AStarNode( gridPoint.x, gridPoint.y, viewPoint.x, viewPoint.y ) ;
					_nodes[ _nodes.length ] = node ;
					_nodeByGrid[ node.gridKey ] = node ;
					//	if ( !isInViewPort( viewPoint.x, viewPoint.y ) ) continue ;
					linkNodes( node ) ;
				}
			}
		}
	
		private function linkNodes( node:AStarNode ):void
		{
			var lNode:AStarNode ;
			var tNode:AStarNode ;
			var ltNode:AStarNode ;
			var rtNode:AStarNode ;
			var rNode:AStarNode ;
			var lbNode:AStarNode ;
			var bNode:AStarNode ;
			var rbNode:AStarNode ;
			var gridX:int = node.gridX ;
			var gridY:int = node.gridY ;
			
			ltNode = findNode( gridX-1, gridY, false ) ;
			tNode = findNode( gridX-1, gridY-1, false ) ;
			rtNode = findNode( gridX, gridY-1, false ) ;
			
			lNode = findNode( gridX-1, gridY+1, false ) ;
			rNode = findNode( gridX+1, gridY-1, false ) ;
			
			lbNode = findNode( gridX, gridY+1, false )  ;
			bNode = findNode( gridX+1, gridY+1, false ) ;
			rbNode = findNode( gridX+1, gridY , false) ;
			
			if ( ltNode ) 
			{
				node.resetNeighbor( AStarNode.LEFT_TOP, ltNode ) ;
				ltNode.resetNeighbor( AStarNode.RIGHT_BOTTOM, node ) ;
			}
			if ( tNode is AStarNode )
			{
				node.resetNeighbor( AStarNode.TOP, tNode ) ;
				tNode.resetNeighbor( AStarNode.BOTTOM, node ) ;
			
			}
			if ( rtNode is AStarNode ) 
			{
				node.resetNeighbor( AStarNode.RIGHT_TOP, rtNode ) ;//nbByKey["rt"] = rtNode ;
				rtNode.resetNeighbor( AStarNode.LEFT_BOTTOM, node ) ;
			}
			if ( lNode is AStarNode )
			{
				node.resetNeighbor( AStarNode.LEFT, lNode ) ;
				lNode.resetNeighbor( AStarNode.RIGHT, node ) ;
			}
			if ( rNode is AStarNode ) 
			{
				node.resetNeighbor( AStarNode.RIGHT, rNode ) ;
				rNode.resetNeighbor( AStarNode.LEFT, node ) ;
			}
			if ( lbNode is AStarNode ) 
			{
				node.resetNeighbor( AStarNode.LEFT_BOTTOM, lbNode ) ;
				lbNode.resetNeighbor( AStarNode.RIGHT_TOP, node ) ;
			}
			if ( bNode is AStarNode ) 
			{
				node.resetNeighbor( AStarNode.BOTTOM, bNode ) ;
				bNode.resetNeighbor( AStarNode.TOP, node ) ;
			}
			if ( rbNode is AStarNode ) 
			{
				node.resetNeighbor( AStarNode.RIGHT_BOTTOM, rbNode ) ;
				rbNode.resetNeighbor( AStarNode.LEFT_TOP, node ) ;
			}
		}
		
		public function findNode( gridX:int, gridY:int, onlyWalkableNode:Boolean = true ):AStarNode
		{
			var node:AStarNode = _nodeByGrid[ String( gridX ) + "," + String( gridY ) ] ;
			if ( node )
			{
				if ( onlyWalkableNode )
				{
					if ( node.isWalkable() ) return node ;
					return null ;
				}
				return node ;
			}
			return null ;
		}
	}
}