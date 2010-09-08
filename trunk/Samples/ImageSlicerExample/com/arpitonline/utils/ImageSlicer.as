/**

The MIT License

Copyright (c) 2007 Arpit Mathur

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

*/
package com.arpitonline.utils{
	
	import flash.display.DisplayObject;
	import de.polygonal.ds.Array2;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	
	public class ImageSlicer{
		
		private var matrixRows:Number;
		private var matrixCols:Number;
		
		private var bitmapDataArray:Array2;
		private var _tileWidth:Number;
		private var _tileHeight:Number;
		
		public function ImageSlicer(src:DisplayObject, matrixWidth:Number, matrixHeight:Number){
			this.matrixRows = matrixRows;
			this.matrixCols = matrixCols;
			bitmapDataArray = new Array2(matrixWidth,matrixHeight);
			_tileWidth = src.width/matrixWidth;
			_tileHeight = src.height/matrixHeight;
			for(var i:Number=0; i<matrixHeight; i++){
				for(var j:Number=0; j<matrixWidth; j++){
					var bitmapData:BitmapData = new BitmapData(_tileWidth, _tileHeight);
					var translateMatrix:Matrix = new Matrix();
					translateMatrix.translate(-_tileWidth*j, -_tileHeight*i);
					bitmapData.draw(src,translateMatrix);
					bitmapDataArray.set(j,i,bitmapData);
				}
			}
		}
		
		public function getSlice(x:Number, y:Number):BitmapData{
			return bitmapDataArray.get(x,y) as BitmapData;
		}
		
		public function get tileWidth():Number{
			return _tileWidth;
		}
		
		public function get tileHeight():Number{
			return _tileHeight;
		}
		
		
	}
}