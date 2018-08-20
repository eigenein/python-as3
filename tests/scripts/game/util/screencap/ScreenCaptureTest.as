package game.util.screencap
{
   import be.boulevart.events.FLVRecorderEvent;
   import be.boulevart.video.FLVRecorder;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.net.FileReference;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import idv.cjcat.signals.Signal;
   import starling.core.Starling;
   
   public class ScreenCaptureTest
   {
      
      public static var instance:ScreenCaptureTest;
       
      
      private var FPS:int = 20;
      
      private var FPS_default:int;
      
      private var myEncoder:FLVRecorder;
      
      private var frameIndex:Number = 0;
      
      private var durationInFrames:Number = 0;
      
      private var parent:Sprite;
      
      public var signal_encodeComplete:Signal;
      
      private var bTemp:BitmapData;
      
      private var bTempResized:BitmapData;
      
      private var b:BitmapData;
      
      private var ba:ByteArray;
      
      private var timer:Timer;
      
      private var s:Sprite;
      
      private var renderScale_factor:Number;
      
      private var renderScale_matrix:Matrix;
      
      private var progress_tf:TextField;
      
      public function ScreenCaptureTest(param1:int, param2:Sprite, param3:String)
      {
         signal_encodeComplete = new Signal();
         ba = new ByteArray();
         progress_tf = new TextField();
         super();
         this.durationInFrames = param1;
         instance = this;
         this.parent = param2;
         bTemp = new BitmapData(param2.stage.stageWidth,param2.stage.stageHeight,false);
         renderScale_factor = 0.5;
         bTempResized = new BitmapData(bTemp.width * renderScale_factor,bTemp.height * renderScale_factor,false);
         myEncoder = FLVRecorder.getInstance(param2.stage);
         myEncoder.setTarget(bTempResized.width,bTempResized.height,FPS,param1 / FPS);
         myEncoder.addEventListener(FLVRecorderEvent.PROGRESS,handler_flvProgress);
         myEncoder.addEventListener(FLVRecorderEvent.FLV_CREATED,handler_flvCreated);
         myEncoder.enableCompression = true;
         b = new BitmapData(param2.stage.stageWidth,param2.stage.stageHeight,false);
         s = new Sprite();
         s.addChild(progress_tf);
         param2.addChild(s);
         renderScale_matrix = new Matrix();
         renderScale_matrix.scale(renderScale_factor,renderScale_factor);
      }
      
      public function start() : void
      {
         timer = new Timer(500);
         timer.start();
         parent.addEventListener("enterFrame",onFrame);
         FPS_default = Starling.current.nativeStage.frameRate;
         Starling.current.nativeStage.frameRate = FPS;
         s.graphics.beginFill(16711680,1);
         s.graphics.drawCircle(30,30,30);
         progress_tf.text = "rec";
      }
      
      public function stop() : void
      {
         myEncoder.duration = durationInFrames / FPS;
         parent.removeEventListener("enterFrame",onFrame);
         myEncoder.stopRecording();
         s.graphics.clear();
         Starling.current.stop(true);
      }
      
      public function save() : void
      {
         var _loc1_:FileReference = new FileReference();
         var _loc2_:ByteArray = myEncoder.file_flv;
         _loc1_.save(_loc2_,"video" + new Date().getTime() + ".flv");
      }
      
      private function handler_SCT() : void
      {
         s.graphics.clear();
         s.graphics.beginFill(0,1);
         s.graphics.drawRect(0,0,500,300);
         progress_tf.text = "save";
         signal_encodeComplete.dispatch();
      }
      
      private function onFrame(param1:Event) : void
      {
         Starling.current.stage.drawToBitmapData(bTemp);
         bTempResized.draw(bTemp,renderScale_matrix);
         myEncoder.saveFrame(bTempResized);
         durationInFrames = Number(durationInFrames) + 1;
      }
      
      protected function handler_flvProgress(param1:FLVRecorderEvent) : void
      {
         progress_tf.text = (Number(param1.progress * 100)).toFixed(2);
      }
      
      protected function handler_flvCreated(param1:Event) : void
      {
         s.addEventListener("click",handler_save);
         Starling.current.nativeStage.frameRate = FPS_default;
         handler_SCT();
      }
      
      protected function handler_save(param1:MouseEvent) : void
      {
         save();
      }
   }
}
