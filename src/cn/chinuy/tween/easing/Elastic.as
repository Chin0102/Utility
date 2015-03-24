// ****************************************************************************
// Copyright (C) 2003-2005 Macromedia, Inc. All Rights Reserved.
// The following is Sample Code and is subject to all restrictions on
// such code as contained in the End User License Agreement accompanying
// this product.
// ****************************************************************************
package cn.chinuy.tween.easing {
	
	public class Elastic {
		public static function easeIn( t : Number, b : Number, c : Number, d : Number ) : Number {
			if( t == 0 )
				return b;
			if(( t /= d ) == 1 )
				return b + c;
			var p : Number = d * .3;
			var s : Number = p / 4;
			return -( c * Math.pow( 2, 10 * ( t -= 1 )) * Math.sin(( t * d - s ) * ( 2 * Math.PI ) / p )) + b;
		}
		
		public static function easeOut( t : Number, b : Number, c : Number, d : Number ) : Number {
			if( t == 0 )
				return b;
			if(( t /= d ) == 1 )
				return b + c;
			var p : Number = d * .3;
			var s : Number = p / 4;
			return ( c * Math.pow( 2, -10 * t ) * Math.sin(( t * d - s ) * ( 2 * Math.PI ) / p ) + c + b );
		}
		
		public static function easeInOut( t : Number, b : Number, c : Number, d : Number ) : Number {
			if( t == 0 )
				return b;
			if(( t /= d / 2 ) == 2 )
				return b + c;
			var p : Number = d * ( .3 * 1.5 );
			var s : Number = p / 4;
			if( t < 1 )
				return -.5 * ( c * Math.pow( 2, 10 * ( t -= 1 )) * Math.sin(( t * d - s ) * ( 2 * Math.PI ) / p )) + b;
			return c * Math.pow( 2, -10 * ( t -= 1 )) * Math.sin(( t * d - s ) * ( 2 * Math.PI ) / p ) * .5 + c + b;
		}
	}
}
