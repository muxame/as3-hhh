package binhpro {//binhpro.CircleTransition
	
	import gs.TweenLite;
	import gs.TweenMax;
	import flash.events.*;
	import flash.display.MovieClip;	
	/**
	 * ...
	 * @author binhdocco
	 */
	public class CircleTransition extends MovieClip {
		
		private var args: Object;
		private var mcs: Array;
		private var radiusX: Number;
		private var radiusY: Number;
		
		private var isPause: Boolean = false;
		private var theParent: MovieClip;
		private var initDone:Boolean = false;
		
		public function CircleTransition(args: Object) {
			this.args = args;
			
			mcs = this.args["mcs"];
			if ( mcs == null ) mcs = new Array();
			else {
				theParent = mcs[0].parent as MovieClip;	
			}
			radiusX = this.args.radiusX;
			radiusY = this.args.radiusY;
			
			this.buildCircle();
		}
		
		private function buildCircle() {
			
			var thisObj: CircleTransition = this;		
			var angle: Number =  2 * Math.PI / mcs.length ;
			var startAngle: Number = Math.PI / 2;
			
			for (var i:Number = 0; i < mcs.length; i++) {
				//trace("startAngle: " + startAngle);
				var mc: MovieClip = mcs[i];						
				mc.buttonMode = true;
				mc.angle = startAngle;			
				mc.index = i + 1;		
				mc.speed = 0;		
				setPosition(mc);
				startAngle += angle;
				
				if (this.args.rollOverFunction != undefined) {
					mc.addEventListener(MouseEvent.ROLL_OVER, onRollover);
					//mc.onRollOver = function() {
						//thisObj.args.rollOverFunction(this);
					//}
				}
				
				if (this.args.rollOutFunction != undefined) {
					mc.addEventListener(MouseEvent.ROLL_OUT, onRollout);
					//mc.onRollOut = function() {
						//thisObj.args.rollOutFunction(this);
					//}
				}
				
				if (this.args.clickFunction != undefined) {
					mc.addEventListener(MouseEvent.CLICK, onClick);
					//mc.onRelease = function() {
						//thisObj.args.clickFunction(this);
					//}
				}
			}	
			
			if (this.args.autoRotate == true) {
				for (i = 0; i < mcs.length; i++) {
					mc = mcs[i];	
					mc.addEventListener(Event.ENTER_FRAME, onEnterframe);
					//mc.onEnterFrame = function() {					
						//this.speed += thisObj.args.rotateSpeed;
						//thisObj.setPosition(this);					
					//}
				}
			}
			
			if (this.args.rotateByMouse == true) {
				(this.mcs[0].parent as MovieClip).addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
					//if (!thisObj.isPause) {
						
					//}
				//}
			}
			initDone = true;
		}
		
		public function onRollover(e: MouseEvent) {
			args.rollOverFunction(e.target);
		}
		public function onRollout(e: MouseEvent) {
			args.rollOutFunction(e.target);
		}
		public function onClick(e: MouseEvent) {
			args.clickFunction(e.currentTarget);
		}
		
		public function onEnterframe(e: Event) {
			if( initDone ) {
				e.target.speed += this.args.rotateSpeed;
				this.setPosition(e.target as MovieClip);	
			}			
		}
		
		public function onMouseMove(e: MouseEvent) {
			this.args.rotateSpeed = (e.currentTarget.mouseX - this.args.centerX) / this.args.mouseMoveSpeed;
		}
		
		public function setPosition(mc: MovieClip):void {
			mc.x = this.args.centerX + Math.cos(mc.angle + mc.speed) * radiusX;
			mc.y = this.args.centerY + Math.sin(mc.angle + mc.speed) * radiusY;
			
			//trace("mc.y: " + mc.angle);
			var scale: Number = (mc.y) / (radiusY + this.args.centerY);
			//make it far away
			if (this.args.isFarAway == true) {
				if( mc.y < this.args.centerY ) {
					scale -= (this.args.centerY - mc.y)/this.args.centerY;	
				} 
			}
			
			if (this.args.is3D == true) {
				if (!isPause) mc.scaleX = mc.scaleY = scale;
			}
			if (this.args.fadeAlpha == true) mc.alpha = scale;

			if( initDone ) {
				arrange();	
			}
		}
		
		public function pause():void {
			isPause = true;
			TweenMax.to(this.args, 0.3, { rotateSpeed: 0 } );
		}
		
		public function unPause():void {
			isPause = false;
			TweenLite.killTweensOf(this.args);
		}	

		function arrange():void {
			mcs.sortOn("y", Array.NUMERIC);
			var i:int = mcs.length;			
			while(i--){
				if (theParent.getChildIndex(mcs[i]) != i) {				
					theParent.setChildIndex(mcs[i], i);
				}
			}
		}
		
	}
}