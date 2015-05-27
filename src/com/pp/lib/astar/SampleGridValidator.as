package com.pp.lib.astar
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public class SampleGridValidator implements IGridValidator
	{
		private var _map:Sprite ;
		
		public function SampleGridValidator( map:Sprite )
		{
			_map = map ;
		}
		
		public function isValid( gridPoint:Point, viewPoint:Point ):Boolean
		{
			return viewPoint.x > 0 || viewPoint.x < _map.width * -1 || viewPoint.y < 0 || viewPoint.y > _map.height ;
		}
	}
}