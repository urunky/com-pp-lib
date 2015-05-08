package com.pp.lib.astar
{
	public interface IAStarNode
	{
		function get gridX():int ;
		function get gridY():int ;
		
		function get viewX():int ;
		function get viewY():int ;
		
		function get f():int ;
		
		function get g():int ;
		function set g( value:int ):void ;
		
		function get h():int ;
		function set h( value:int ):void ;
		
		function get nbByKey():Object ;
		
		function get parent():IAStarNode ;
		function set parent( value:IAStarNode ):void ;
		
		function isWalkable():Boolean ;
		
		function findWalkableNeighborNodes( fromNode:IAStarNode, nodes:Array, depth:int ):void
	}
}