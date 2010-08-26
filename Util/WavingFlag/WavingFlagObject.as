package binhpro.wavingflageffect { // binhpro.wavingflageffect.WavingFlagObject 
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.BlendMode;
	import flash.display.GradientType;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author binhdocco

	 */
	public class WavingFlagObject extends MovieClip {
		
		// controls how fast flag will flap
        private static const WIND_RATE:Number = 10;
 
        private var _gradient:BitmapData;
        private var _flag:BitmapData;
        private var _perlinNoise:BitmapData;
        private var _perlinOffsets:Array;
        private var _perlinSeed:int;
		private var _loadedBitmap: Bitmap;
 
		
		public function WavingFlagObject() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			var bmd: BitmapData = new BitmapData(this.width, this.height, true, 0xFFFFFF);
			//var bounds: Rectangle = this.getBounds(this);
			//var matrix: Matrix = new Matrix();
			//matrix.translate( -bounds.x, - bounds.y);
			bmd.draw(this);
			
			this._loadedBitmap = new Bitmap(bmd);
			
			this.flag_bm.visible = false;
			
			makeFlag();		
			makeNoise();
			makeGradientOverlay();
			this.addEventListener(Event.ENTER_FRAME, onSpriteEnterFrame);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		private function onRemovedFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.removeEventListener(Event.ENTER_FRAME, onSpriteEnterFrame);
		}
		
		/**
          * Uses the loaded image of the flag, then uses the drawing API to create
          * a pole and cords to attach to the flag.
          */
		  private function makeFlag():void {
			   var stageWidth:Number = this.width;
			   var stageHeight:Number = this.height;

			   var bitmapData:BitmapData = _loadedBitmap.bitmapData;
			   var bitmapWidth:Number = bitmapData.width;
			   var bitmapHeight:Number = bitmapData.height;

			   // settings for the size and position of pole
			   var poleWidth:Number = 15;
			   var poleHeight:Number = 250;
			   var poleX:Number = 35;
			   var poleY:Number = stageHeight - poleHeight;

			   // draws a horizontal linera gradient for the pole
			   var matrix:Matrix = new Matrix();
			   matrix.createGradientBox(poleWidth, poleHeight);
			   var pole:Shape = new Shape();
			   pole.graphics.beginGradientFill(
					GradientType.LINEAR,
					[0x333333, 0x999999, 0xCCCCCC, 0xAAAAAA, 0x666666],
					[1, 1, 1, 1, 1],
					[0, 50, 160, 200, 255],
					matrix
			   );
			   pole.graphics.drawRect(0, 0, poleWidth, poleHeight);
			   pole.graphics.endFill();
			   pole.x = poleX;
			   pole.y = poleY;
			   addChild(pole);

			   // point at top left of flag
			   var point:Point = new Point(
					(stageWidth - bitmapWidth)/2,
					(stageHeight - bitmapHeight)/2
			   );

			   // draws two cords from pole to flag's left side
			   var cord:Shape = new Shape();
			   cord.graphics.lineStyle(2, 0x333333);
			   cord.graphics.moveTo(poleX, poleY+3);
			   cord.graphics.lineTo(point.x, point.y);
			   cord.graphics.moveTo(point.x, point.y + bitmapHeight);
			   cord.graphics.lineTo(poleX, poleY + bitmapHeight+20);

			   // draws cord shape into bitmap data with flag, so that all can be distorted
			   _flag = new BitmapData(stageWidth, stageHeight, true, 0x00000000);
			   _flag.draw(cord);
			   _flag.copyPixels(bitmapData, bitmapData.rect, point);
			   _loadedBitmap.bitmapData = _flag;
			   addChild(_loadedBitmap);			   
		  }

		  /**
		  * Creates the bitmap data that will be used to draw into the displacement
		  * map in order to limit the amount of distortion. This is accomplished by
		  * drawing a gradient of medium gray going from full opacity to none over the
		  * left side of the displacement map, preventing displacement on the left of the image.
		  */
		  private function makeGradientOverlay():void {
			   var width:Number = this.width;
			   var height:Number = this.height;
			   var matrix:Matrix = new Matrix();
			   matrix.createGradientBox(width, height);
			   var shape:Shape = new Shape();
			   shape.graphics.beginGradientFill(
					GradientType.LINEAR,
					[0x7F7F7F, 0x7F7F7F],
					[1, 0],
					[20, 80],
					matrix
			   );
			   shape.graphics.drawRect(0, 0, width, height);
			   shape.graphics.endFill();
			   // draw gradient shape into bitmap data for use later
			   _gradient = new BitmapData(width, height, true, 0x00000000);
			   _gradient.draw(shape);
		  }          
		  /**
		  * Initializes Perlin noise properties that will be used in flame animation.
		  */
		  private function makeNoise():void {
			   _perlinNoise = new BitmapData(this.width, this.height);
			   _perlinSeed = int(new Date());
			   // only one octave requires only one point
			   _perlinOffsets = [new Point()];
		  }

		  /**
		  * Applies the Perlin noise to the bitmap data, offsetting the octave displacement
		  * by the WIND_RATE each time this method is called.
		  */
		  private function applyNoise():void {
			   _perlinNoise.perlinNoise(
					200,
					200,
					1,
					_perlinSeed,
					false,
					true,
					BitmapDataChannel.RED,
					true,
					_perlinOffsets
			   );
			   // altering offset contributes to horizontal animation of flag
			   (_perlinOffsets[0] as Point).x -= WIND_RATE;
		  }

		  /**
		  * Redraws the flag with new distortion to create animated effect of flapping.
		  */
		  private function waveFlag():void {
			   // generate new Perlin noise
			   applyNoise();
			   var flag:BitmapData = _flag.clone();
			   // copy the gradient overlay to limit the displacement
			   _perlinNoise.copyPixels(
					_gradient,
					_gradient.rect,
					new Point(),
					_perlinNoise,
					new Point(),
					true
			   );
			   // displace original flag with new displacement map
			   var dmf: DisplacementMapFilter = new DisplacementMapFilter(
																		_perlinNoise, 
																		new Point(), 
																		BitmapDataChannel.RED, 
																		BitmapDataChannel.RED, 
																		40, 60);
			   flag.applyFilter (flag, 
								flag.rect, 
								new Point(), 
								dmf);
			   /*ImageUtil.applyFilter(
					flag,
					new DisplacementMapFilter(
						 _perlinNoise,
						 new Point(),
						 BitmapDataChannel.RED,
						 BitmapDataChannel.RED,
						 40,
						 60
					)
			   );*/
			   // copy the alpha channel from the noise into the flag
			   //ImageUtil.copyChannel(flag, _perlinNoise, BitmapDataChannel.ALPHA);
			   flag.copyChannel(flag, 
								flag.rect, 
								new Point(), 
								BitmapDataChannel.ALPHA, 
								BitmapDataChannel.ALPHA);
			   // overlay the displacement map for a lighting effect using darks and lights
			   flag.draw(
					_perlinNoise,
					null,
					new ColorTransform(1, 1, 1, 0), // alpha of the background
					BlendMode.HARDLIGHT
			   );
			   _loadedBitmap.bitmapData = flag;
			   
		  }

		  /**
		  * Handler for ENTER_FRAME event. Redraws flag.
		  *
		  * @param event Event dispatched by this sprite.
		  */
		  private function onSpriteEnterFrame(event:Event):void {
			   waveFlag();
		  }
		
	}

}