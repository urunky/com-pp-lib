package com.pp.lib.astar
{
	import flash.geom.Point;

	public interface IGridValidator
	{
		function isValid( gridPoint:Point, viewPoint:Point ):Boolean ;
	}
}