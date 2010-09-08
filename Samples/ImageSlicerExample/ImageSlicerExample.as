package {
	import com.arpitonline.effects.Blinds;
	import com.arpitonline.utils.ImageSlicer;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFieldType;
		
	public class ImageSlicerExample extends Sprite{
		
		private var loader:Loader;
		private var slicer:ImageSlicer;
		private var slice:Bitmap;
		
		private var slicerowsTF:TextField;
		private var slicecolsTF:TextField;
		
		private var selectedXSliceTF:TextField;
		private var selectedYSliceTF:TextField;
		
		public function ImageSlicerExample(){
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			loadImage('calvin.jpg');
		}
		
		private function loadImage(url:String):void{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete)
			addChild(loader);
			loader.load(new URLRequest(url));
			loader.x = 20;
			loader.y = 110;
		}
		
		private function onLoadComplete(event:Event):void{
			createSliceForm();
			createShowForm();
			
		}
		
		private function createSliceForm():void{
				var form:Sprite = new Sprite();
			
			var txt:TextField = new TextField();
			form.addChild(txt);
			txt.text = "Create Slices: ";
			txt.width = 70;
			
			var txt2:TextField = new TextField();
			form.addChild(txt2);
			txt2.type = TextFieldType.INPUT;
			txt2.text = "2";
			txt2.height = 20;
			txt2.width = 20;
			txt2.x = txt.x+txt.width;
			txt2.border = true;
			txt2.borderColor=0x333333;
			txt2.background = true;
			txt2.backgroundColor = 0xffffff;
			
			var txt3:TextField = new TextField();
			form.addChild(txt3);
			txt3.type = TextFieldType.INPUT;
			txt3.text = "2";
			txt3.height = 20;
			txt3.width = 20;
			txt3.border = true;
			txt3.borderColor=0x333333;
			txt3.background = true;
			txt3.backgroundColor = 0xffffff;
			txt3.x = txt2.x+txt2.width+10;
			
			var bttn:Sprite = new Sprite();
			bttn.graphics.beginFill(0xcccccc);
			bttn.graphics.drawRect(0,0,60,20);
			bttn.buttonMode = true;
			var label:TextField = new TextField();
			label.text = "Slice";
			label.x = 10;
			label.selectable = false;
			bttn.mouseChildren = false;
			bttn.addChild(label);
			bttn.x = txt3.x+txt3.width+10;
			bttn.useHandCursor=true;
			bttn.addEventListener(MouseEvent.CLICK, doSlices);
			
			form.addChild(bttn);
			addChild(form);
			form.x = 20;
			form.y = 20;
			
			slicerowsTF = txt2;
			slicecolsTF = txt3;
		}
		
		
		private function doSlices(event:MouseEvent):void{
			slicer = new ImageSlicer(loader, Number(slicerowsTF.text), Number(slicecolsTF.text));
		}
		
		private function createShowForm():void{
			
			var form:Sprite = new Sprite();
			
			var txt:TextField = new TextField();
			form.addChild(txt);
			txt.text = "Show Slice: ";
			txt.width = 70;
			
			var txt2:TextField = new TextField();
			form.addChild(txt2);
			txt2.type = TextFieldType.INPUT;
			txt2.text = "0";
			txt2.height = 20;
			txt2.width = 20;
			txt2.x = txt.x+txt.width;
			txt2.border = true;
			txt2.borderColor=0x333333;
			txt2.background = true;
			txt2.backgroundColor = 0xffffff;
			
			var txt3:TextField = new TextField();
			form.addChild(txt3);
			txt3.type = TextFieldType.INPUT;
			txt3.text = "0";
			txt3.height = 20;
			txt3.width = 20;
			txt3.border = true;
			txt3.borderColor=0x333333;
			txt3.background = true;
			txt3.backgroundColor = 0xffffff;
			txt3.x = txt2.x+txt2.width+10;
			
			var bttn:Sprite = new Sprite();
			bttn.graphics.beginFill(0xcccccc);
			bttn.graphics.drawRect(0,0,60,20);
			bttn.buttonMode = true;
			var label:TextField = new TextField();
			label.text = "Show";
			label.x = 10;
			label.selectable = false;
			bttn.mouseChildren = false;
			bttn.addChild(label);
			bttn.x = txt3.x+txt3.width+10;
			bttn.useHandCursor=true;
			bttn.addEventListener(MouseEvent.CLICK, showSlice);
			
			form.addChild(bttn);
			addChild(form);
			form.x = 20;
			form.y = 50;
			
			selectedXSliceTF = txt2;
			selectedYSliceTF = txt3;
		}
		
		private function showSlice(event:MouseEvent):void{
			if(!slicer){
				navigateToURL(new URLRequest('javascript:alert("Please use the Slice button first to slice the image")'));
				return;
			}
			if(slice){
				removeChild(slice);
				slice = null;
			}
			slice = new Bitmap(slicer.getSlice(Number(selectedXSliceTF.text),Number(selectedYSliceTF.text)));
			addChild(slice);
			slice.x = loader.x+loader.width+20;
			slice.y = loader.y;
		}
	}
}
