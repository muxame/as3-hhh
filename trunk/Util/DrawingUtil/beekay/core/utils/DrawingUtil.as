/**
 *
 * DrawingUtil class
 *
 * Copyright (c) 2009 Ben Kanizay
 * This software is released under the MIT License
 *
 */
 
 package beekay.core.utils {
	import flash.display.LineScaleMode;
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;

	/**
	 * @author ben.kanizay
	 */
	public class DrawingUtil {
		
		
		/*
		 * Returns a rectangular sprite.
		 * 
		 * @param width:Number  the width of the rectangle
		 * @param height:Number  the height of the rectangle
		 * @param fill:Object (optional) - An object containing fill properties - default is a solid 0x00FFFF fill and alpha of 1
		 * @param stroke:Object (optional) - An object containing stroke properties - default is no stroke
		 * @param ellipse:int (optional) the size of the rounded corners - default is 0
		 * 
		 * @return Sprite
		 * 
		 */
		
		public static function drawRectSprite(width:Number, height:Number, fill:Object=null, stroke:Object=null, ellipse:int=0):Sprite {

			var sprite:Sprite = new Sprite();
			var graphics:Graphics = sprite.graphics;
			
			// check if we're drawing a stroke
			if (stroke != null) {
				var strokeObj:Object = getStroke(stroke);
				graphics.lineStyle(strokeObj.weight, strokeObj.colour, strokeObj.alpha, strokeObj.pixelHinting, strokeObj.scaleMode);
			}

			// determine the fill type and properties
			if (fill != null && fill.colour != null && fill.colour is Array && fill.colour.length > 1) {
				// gradient
				var gradProps:Object = getGradient(fill);
				var gradMatrix:Matrix = new Matrix();
				gradMatrix.createGradientBox(width, height, gradProps.rotation, 0, 0);
				graphics.beginGradientFill(gradProps.type, gradProps.colours, gradProps.alphas, gradProps.ratios, gradMatrix, gradProps.Spread);
			}
			else {
				// solid
				var fillProps:Object = getSolid(fill);
				graphics.beginFill(fillProps.colour, fillProps.alpha);
			}

			// rounded corners or not?
			if (ellipse > 0) {
				graphics.drawRoundRect(0, 0, width, height, ellipse);
			}
			else {
				graphics.drawRect(0, 0, width, height);
			}

			graphics.endFill();
			return sprite;
		}




		/*
		 * Returns a circular sprite.
		 * 
		 * @param radius:int  the radius of the circle
		 * @param fill:Object (optional) - An object containing fill properties
		 * @param stroke:Object (optional) - An object containing stroke properties
		 * 
		 * @return Sprite
		 * 
		 */
		
		public static function drawCircSprite(radius:int, fill:Object=null, stroke:Object=null):Sprite {
			var sprite:Sprite = new Sprite();
			var graphics:Graphics = sprite.graphics;
			
			// check if we're drawing a stroke
			if (stroke != null) {
				var strokeObj:Object = getStroke(stroke);
				graphics.lineStyle(strokeObj.weight, strokeObj.colour, strokeObj.alpha, strokeObj.pixelHinting, strokeObj.scaleMode);
			}

			// determine the fill type and properties
			if (fill != null && fill.colour != null && fill.colour is Array && fill.colour.length > 1) {
				// gradient
				var gradProps:Object = getGradient(fill);
				var gradMatrix:Matrix = new Matrix();
				gradMatrix.createGradientBox(radius, radius, gradProps.rotation, 0, 0);
				graphics.beginGradientFill(gradProps.type, gradProps.colours, gradProps.alphas, gradProps.ratios, gradMatrix, gradProps.Spread);
			}
			else {
				// solid
				var fillProps:Object = getSolid(fill);
				graphics.beginFill(fillProps.colour, fillProps.alpha);
			}
			
			graphics.drawCircle(0, 0, radius);
			graphics.endFill();
			return sprite;
		}
		
		
		/*
		 * Returns a simple triangle shaped Sprite with equal sides.
		 * 
		 * @param base:int  the length of the triangle base (the other sides will be the same)
		 * @param fill:Object (optional) - An object containing fill properties
		 * @param stroke:Object (optional) - An object containing stroke properties
		 * 
		 * @return Sprite
		 * 
		 */
		
		public static function drawTriSprite(base:int, fill:Object=null, stroke:Object=null) : Sprite {
			var height:Number = Math.sqrt((base*base)-((base/2)*(base/2)));
			var sprite:Sprite = new Sprite();
			var graphics:Graphics = sprite.graphics;

			// check if we're drawing a stroke
			if (stroke != null) {
				var strokeObj:Object = getStroke(stroke);
				graphics.lineStyle(strokeObj.weight, strokeObj.colour, strokeObj.alpha, strokeObj.pixelHinting, strokeObj.scaleMode);
			}

			// determine the fill type and properties
			if (fill != null && fill.colour != null && fill.colour is Array && fill.colour.length > 1) {
				// gradient
				var gradProps:Object = getGradient(fill);
				var gradMatrix:Matrix = new Matrix();
				gradMatrix.createGradientBox(base, height, gradProps.rotation, 0, 0);
				graphics.beginGradientFill(gradProps.type, gradProps.colours, gradProps.alphas, gradProps.ratios, gradMatrix, gradProps.Spread);
			}
			else {
				// solid
				var fillProps:Object = getSolid(fill);
				graphics.beginFill(fillProps.colour, fillProps.alpha);
			}

			graphics.moveTo(0, height);
			graphics.lineTo(base/2, 0);
			graphics.lineTo(base, height);
			graphics.lineTo(0, height);
			graphics.endFill();

			return sprite;
		}



////////////////////////////////////////////////////////////////
//		HELPER METHODS
////////////////////////////////////////////////////////////////		
		

		/*
		 * Creates the stroke properties, using defaults for any null values
		 */
		private static function getStroke(props:Object) : Object {
			var stroke:Object = {};

			var strokeWeight:Number = (props.weight != null) ? props.weight : 1;
			var strokeColour:uint = (props.colour != null) ? props.colour : 0x000000;
			var pixelHinting:Boolean = (props.pixelHinting != null) ? props.pixelHinting : true;
			var scaleMode:String = (props.scaleMode != null) ? props.scaleMode : LineScaleMode.NONE;
			var strokeAlpha:Number = (props.alpha != null) ? props.alpha : 1;

			stroke.weight = strokeWeight;
			stroke.colour = strokeColour;
			stroke.pixelHinting = pixelHinting;
			stroke.scaleMode = scaleMode;
			stroke.alpha = strokeAlpha;

			return stroke;
		}
		

		/*
		 * Creates the gradient fill properties, using defaults for any null values
		 */
		private static function getGradient(fill:Object) : Object {
			var gradient:Object = {};
			
			var gradColours:Array = [parseInt(fill.colour[0]), parseInt(fill.colour[1])];
			var gradAlphas:Array = (fill.alpha is Array) ? (fill.alpha.length > 1) ? [fill.alpha[0], fill.alpha[1]] : [fill.alpha[0], fill.alpha[0]] : (fill.alpha != null) ? [fill.alpha, fill.alpha] : [1, 1];
			var gradType:String = (fill.gradientType != null) ? fill.gradientType : GradientType.LINEAR;
			var gradSpread:String = (fill.spreadMethod != null) ? fill.spreadMethod : SpreadMethod.PAD;
			var gradRatios:Array = (fill.ratios is Array && fill.ratios.length > 1) ? [fill.ratios[0], fill.ratios[1]] : [0, 255];
			var gradRotation:Number = (fill.rotation != null) ? fill.rotation : 0;
			
			gradient.colours = gradColours;
			gradient.alphas = gradAlphas;
			gradient.type = gradType;
			gradient.spread = gradSpread;
			gradient.ratios = gradRatios;
			gradient.rotation = gradRotation;
			
			return gradient;
		}
		

		/*
		 * Creates the solid fill properties, using defaults for any null values
		 */
		private static function getSolid(fill:Object) : Object {
			var solid:Object = {};
			
			var fillAlpha:Number = (fill.alpha == null) ? 1 : (fill.alpha is Array) ? fill.alpha[0] : fill.alpha;
			var fillColour:uint = (fill.colour != null) ? (fill.colour is Array) ? parseInt(fill.colour[0]) : parseInt(fill.colour) : 0x00FFFF;
			
			solid.alpha = fillAlpha;
			solid.colour = fillColour;
			
			return solid;
		}
		
	}
}
