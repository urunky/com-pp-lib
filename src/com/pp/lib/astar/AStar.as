package com.pp.lib.astar
{
	import flash.geom.Point;

	public class AStar
	{
		private var _nodes:Vector.<AStarNode> = null ;
		public function set nodes(value:Vector.<AStarNode>):void					{	_nodes = value;	}
		
		private var _opened:Vector.<AStarNode> ;
		private var _closed:Vector.<AStarNode> ;
		private var _visited:Vector.<AStarNode> ;
		
		
		public function AStar( nodes:Vector.<AStarNode >)
		{
			_nodes = nodes ;
			_opened = new Vector.<AStarNode> ; 
			_closed = new Vector.<AStarNode>  ; 
			_visited = new Vector.<AStarNode>  ; 
		}
		
		public function solve( startNode:AStarNode, goalNode:AStarNode, onlyWalkable:Boolean = true ):Array
		{
			if ( startNode == null || goalNode == null ) return null ;
			if ( startNode.gridX == goalNode.gridX && startNode.gridY == goalNode.gridY) return null ; 
			
			_opened.length = 0 ;
			_closed.length = 0 ;
			_visited.length = 0 ;
			
			var node:AStarNode = startNode;
			
			node.h = distEuclidian_2( startNode.viewX, startNode.viewY, goalNode.viewX, goalNode.viewY );
			node.parent = null ;
			_opened[ _opened.length ] = node ;
			
			var solved:Boolean = false;
			
			var node_2:AStarNode ;
			
			// Ok let's start
			while( !solved ) 
			{
				// This line can actually be removed
				//if (i++ > 2000) throw new Error("Overflow");
				
				// Sort open list by cost
				_opened.sort( sortByF ) ;
				if  ( _opened.length <= 0 ) break;
				
				node = _opened.shift();
				_closed[ _closed.length ] = node ;
				
				// Could it be true, are we there?
				if ( node.gridX == goalNode.gridX ) 
				{
					// We found a solution!
					if ( node.gridY == goalNode.gridY )
					{
						solved = true;
						break;
					}
				}
				for each ( node_2 in node.nbByKey )
				{
					if ( node_2.isWalkable()  || !onlyWalkable )
					{
						if ( _opened.indexOf( node_2 ) >= 0 || _closed.indexOf( node_2 ) >= 0 )
						{
							var f:int = node_2.g + node.g + node_2.h ;
							if ( f < node_2.f) 
							{
								node_2.parent = node;
								node_2.g = node.g;
							}
						}
						else
						{
							
							_opened[ _opened.length ] = node_2;
							node_2.parent = node;
							node_2.h = distEuclidian_2( node_2.viewX, node_2.viewY, goalNode.viewX, goalNode.viewY );
							node_2.g = node.g + distEuclidian_2( node_2.viewX, node_2.viewY, node.viewX, node.viewY ) ;
						}
					}
				}
			}
			
			// The loop was broken,
			// see if we found the solution
			
			if ( solved ) 
			{
				// We did! Format the data for use.
				var path:Array = [] ; ; 
				// Start at the end...
				path[ path.length ] = new Point( node.viewX, node.viewY )   ; //new IntPoint( node.row, node.col));
				// ...walk all the way to the start to record where we've been...
				//while (node.parent && node.parent != startNode) 
				var oldNode:AStarNode ;
				while ( node.parent )
				{
					oldNode = node ;
					node = node.parent;
					oldNode.parent = null ;
					path[ path.length ] = new Point( node.viewX, node.viewY ) ;
				}
				// ...and add our initial position.
				//	solution.push(new IntPoint(node.col, node.row));
				path.reverse();
				return path ;
			}
			else 
			{
				// No solution found... :(
				// This might be something else instead
				// (like an array with only the starting position)
				return null;
			}
		}
		
		private function distEuclidian_2(n1x:int, n1y:int, n2x:int, n2y:int):Number
		{
			return Math.sqrt( (n1x-n2x) * (n1x-n2x) + (n1y-n2y) *(n1y-n2y) ) ;
		}
		
		private function sortByF( node_1:AStarNode, node_2:AStarNode ):int
		{
			if ( node_1.f > node_2.f ) return 1 ;
			if ( node_1.f < node_2.f ) return -1 ;
			return 0 ;
		}
		
		
	}
}