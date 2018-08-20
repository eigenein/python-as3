package be.boulevart.video
{
   import be.boulevart.bitmapencoding.JPGEncoder;
   import be.boulevart.events.FLVRecorderEvent;
   import be.boulevart.threading.PseudoThread;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.utils.ByteArray;
   
   public class FLVRecorder extends EventDispatcher
   {
      
      private static var _instance:FLVRecorder;
      
      private static var _allowInstance:Boolean;
      
      public static const DEFAULT_NAME:String = "FLVRecorder";
       
      
      private var frameWidth:int;
      
      private var frameHeight:int;
      
      private var frameRate:Number;
      
      public var duration:Number;
      
      private var fileStream:ByteArray;
      
      private var file_temp:ByteArray;
      
      private const blockWidth:int = 32;
      
      private const blockHeight:int = 32;
      
      private var previousTagSize:uint = 0;
      
      private var iteration:int = 0;
      
      private var _isOpen:Boolean = false;
      
      private var _isRecording:Boolean = false;
      
      private var total:int = 0;
      
      private var curr:int = 0;
      
      private var startTime:Date = null;
      
      private var _enableCompression:Boolean = false;
      
      private var _codec:int = 3;
      
      private var _stage:Stage;
      
      public function FLVRecorder()
      {
         super();
         if(!FLVRecorder._allowInstance)
         {
            throw new Error("Error: Use FLVRecorder.getInstance() instead of the new keyword.");
         }
      }
      
      public static function getInstance(param1:Stage) : FLVRecorder
      {
         if(FLVRecorder._instance == null)
         {
            FLVRecorder._allowInstance = true;
            FLVRecorder._instance = new FLVRecorder();
            _instance._stage = param1;
            FLVRecorder._allowInstance = false;
         }
         return FLVRecorder._instance;
      }
      
      public function get file_flv() : ByteArray
      {
         return fileStream;
      }
      
      public function setTarget(param1:int, param2:int, param3:int, param4:Number = 0) : void
      {
         frameWidth = param1;
         frameHeight = param2;
         frameRate = param3 / 2;
         duration = param4;
      }
      
      private function writeFrame(param1:Object) : void
      {
         var _loc2_:* = null;
         if(isOpen)
         {
            _loc2_ = param1.bmp as BitmapData;
            curr = Number(curr) + 1;
            dispatchEvent(new FLVRecorderEvent(FLVRecorderEvent.PROGRESS,"",curr / total));
            fileStream.writeUnsignedInt(previousTagSize);
            flvTagVideo(_loc2_);
            _loc2_.dispose();
         }
      }
      
      public function clear() : void
      {
         try
         {
            if(isOpen)
            {
               _isOpen = false;
            }
            if(isRecording)
            {
               _isRecording = false;
               try
               {
                  file_temp.clear();
               }
               catch(e:Error)
               {
               }
            }
            file_temp = null;
            total = 0;
            curr = 0;
            duration = 0;
            startTime = null;
            System.gc();
            return;
         }
         catch(e:Error)
         {
            return;
         }
      }
      
      public function saveFrame(param1:BitmapData) : void
      {
         if(startTime == null)
         {
            startTime = new Date();
         }
         _isRecording = true;
         total = Number(total) + 1;
         writeFrames(param1);
      }
      
      private function writeFrames(param1:BitmapData) : void
      {
         var _loc2_:* = null;
         if(isRecording)
         {
            if(file_temp == null)
            {
               file_temp = new ByteArray();
            }
            _loc2_ = param1.getPixels(new Rectangle(0,0,frameWidth,frameHeight));
            file_temp.writeInt(_loc2_.length);
            file_temp.writeBytes(_loc2_);
         }
      }
      
      public function captureComponent(param1:DisplayObject) : void
      {
         var _loc2_:BitmapData = new BitmapData(param1.width,param1.height);
         _loc2_.draw(param1);
         saveSmoothedFrame(_loc2_);
      }
      
      public function saveSmoothedBitmapFrame(param1:Bitmap) : void
      {
         param1.smoothing = true;
         saveFrame(param1.bitmapData);
         param1 = null;
      }
      
      public function saveSmoothedFrame(param1:BitmapData) : void
      {
         var _loc2_:Bitmap = new Bitmap(param1);
         _loc2_.smoothing = true;
         saveFrame(_loc2_.bitmapData);
         _loc2_ = null;
      }
      
      public function stopRecording() : void
      {
         _isRecording = false;
         fileStream = new ByteArray();
         _isOpen = true;
         fileStream.writeBytes(header());
         fileStream.writeUnsignedInt(previousTagSize);
         fileStream.writeBytes(flvTagOnMetaData());
      }
      
      public function saveByteFrame(param1:ByteArray) : void
      {
         if(isRecording)
         {
            if(file_temp == null)
            {
               file_temp = new ByteArray();
            }
            file_temp.writeInt(param1.length);
            file_temp.writeBytes(param1);
         }
      }
      
      private function doStop() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:* = null;
         dispatchEvent(new FLVRecorderEvent(FLVRecorderEvent.FLV_START_CREATION));
         file_temp.position = 0;
         while(file_temp.bytesAvailable)
         {
            _loc1_ = file_temp.readInt();
            _loc2_ = new ByteArray();
            file_temp.readBytes(_loc2_);
            _loc3_ = new BitmapData(frameWidth,frameHeight);
            _loc3_.setPixels(new Rectangle(0,0,frameWidth,frameHeight),_loc2_);
            _loc2_ = null;
            new PseudoThread(_stage,writeFrame,{"bmp":_loc3_});
         }
      }
      
      private function header() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeByte(70);
         _loc1_.writeByte(76);
         _loc1_.writeByte(86);
         _loc1_.writeByte(1);
         _loc1_.writeByte(1);
         _loc1_.writeUnsignedInt(9);
         return _loc1_;
      }
      
      private function flvTagVideo(param1:BitmapData) : void
      {
         b = param1;
         if(_enableCompression)
         {
            var enc:JPGEncoder = new JPGEncoder();
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener("complete",function(param1:Event):*
            {
               var _loc4_:BitmapData = Bitmap(Object(param1.target).content).bitmapData;
               var _loc5_:ByteArray = new ByteArray();
               var _loc3_:ByteArray = videoData(_loc4_);
               iteration = Number(iteration) + 1;
               var _loc2_:uint = 1000 / frameRate * iteration;
               _loc5_.writeByte(9);
               writeUI24(_loc5_,_loc3_.length);
               writeUI24(_loc5_,_loc2_);
               _loc5_.writeByte(0);
               writeUI24(_loc5_,0);
               _loc5_.writeBytes(_loc3_);
               previousTagSize = _loc5_.length;
               fileStream.writeBytes(_loc5_);
               _loc4_.dispose();
               b.dispose();
               if(curr == total)
               {
                  dispatchEvent(new FLVRecorderEvent(FLVRecorderEvent.FLV_CREATED,"file_flv.url"));
                  clear();
               }
            });
            loader.loadBytes(enc.encode(b));
         }
         else
         {
            var tag:ByteArray = new ByteArray();
            var dat:ByteArray = videoData(b);
            iteration = Number(iteration) + 1;
            var timeStamp:uint = 1000 / frameRate * iteration;
            tag.writeByte(9);
            writeUI24(tag,dat.length);
            writeUI24(tag,timeStamp);
            tag.writeByte(0);
            writeUI24(tag,0);
            tag.writeBytes(dat);
            previousTagSize = tag.length;
            fileStream.writeBytes(tag);
            b.dispose();
            if(curr == total)
            {
               dispatchEvent(new FLVRecorderEvent(FLVRecorderEvent.FLV_CREATED,"file_flv.url"));
               clear();
            }
         }
      }
      
      private function videoData(param1:BitmapData) : ByteArray
      {
         var _loc9_:int = 0;
         var _loc11_:int = 0;
         var _loc14_:* = null;
         var _loc10_:* = 0;
         var _loc12_:int = 0;
         var _loc2_:* = 0;
         var _loc15_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:* = 0;
         var _loc8_:ByteArray = new ByteArray();
         _loc8_.writeByte(19);
         writeUI4_12(_loc8_,2 - 1,frameWidth);
         writeUI4_12(_loc8_,2 - 1,frameHeight);
         var _loc7_:int = frameHeight / 32;
         var _loc5_:int = frameHeight % 32;
         if(_loc5_ > 0)
         {
            _loc7_ = _loc7_ + 1;
         }
         var _loc16_:int = frameWidth / 32;
         var _loc13_:int = frameWidth % 32;
         if(_loc13_ > 0)
         {
            _loc16_ = _loc16_ + 1;
         }
         _loc9_ = 0;
         while(_loc9_ < _loc7_)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc16_)
            {
               _loc14_ = new ByteArray();
               _loc10_ = 32;
               if(_loc5_ > 0 && _loc9_ + 1 == _loc7_)
               {
                  _loc10_ = _loc5_;
               }
               _loc12_ = 0;
               while(_loc12_ < _loc10_)
               {
                  _loc2_ = 32;
                  if(_loc13_ > 0 && _loc11_ + 1 == _loc16_)
                  {
                     _loc2_ = _loc13_;
                  }
                  _loc15_ = 0;
                  while(_loc15_ < _loc2_)
                  {
                     _loc3_ = _loc11_ * 32 + _loc15_;
                     _loc4_ = frameHeight - (_loc9_ * 32 + _loc12_);
                     _loc6_ = uint(param1.getPixel(_loc3_,_loc4_));
                     _loc14_.writeByte(_loc6_ & 255);
                     _loc14_.writeByte(_loc6_ >> 8 & 255);
                     _loc14_.writeByte(_loc6_ >> 16);
                     _loc15_++;
                  }
                  _loc12_++;
               }
               _loc14_.compress();
               writeUI16(_loc8_,_loc14_.length);
               _loc8_.writeBytes(_loc14_);
               _loc11_++;
            }
            _loc9_++;
         }
         param1.dispose();
         return _loc8_;
      }
      
      private function flvTagOnMetaData() : ByteArray
      {
         var _loc2_:ByteArray = new ByteArray();
         var _loc1_:ByteArray = metaData();
         _loc2_.writeByte(18);
         writeUI24(_loc2_,_loc1_.length);
         writeUI24(_loc2_,0);
         _loc2_.writeByte(0);
         writeUI24(_loc2_,0);
         _loc2_.writeBytes(_loc1_);
         previousTagSize = _loc2_.length;
         return _loc2_;
      }
      
      private function metaData() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeByte(2);
         writeUI16(_loc1_,"onMetaData".length);
         _loc1_.writeUTFBytes("onMetaData");
         _loc1_.writeByte(8);
         _loc1_.writeUnsignedInt(7);
         if(duration > 0)
         {
            writeUI16(_loc1_,"duration".length);
            _loc1_.writeUTFBytes("duration");
            _loc1_.writeByte(0);
            _loc1_.writeDouble(duration);
         }
         writeUI16(_loc1_,"width".length);
         _loc1_.writeUTFBytes("width");
         _loc1_.writeByte(0);
         _loc1_.writeDouble(frameWidth);
         writeUI16(_loc1_,"height".length);
         _loc1_.writeUTFBytes("height");
         _loc1_.writeByte(0);
         _loc1_.writeDouble(frameHeight);
         writeUI16(_loc1_,"framerate".length);
         _loc1_.writeUTFBytes("framerate");
         _loc1_.writeByte(0);
         _loc1_.writeDouble(frameRate);
         writeUI16(_loc1_,"videocodecid".length);
         _loc1_.writeUTFBytes("videocodecid");
         _loc1_.writeByte(0);
         _loc1_.writeDouble(codec);
         writeUI16(_loc1_,"canSeekToEnd".length);
         _loc1_.writeUTFBytes("canSeekToEnd");
         _loc1_.writeByte(1);
         _loc1_.writeByte(1);
         var _loc2_:String = "Build with FLVRecorder by Joris Timmerman (BoulevArt nv), flv-writing algorithms from SimpleFLVWriter by ZeroPointNine";
         writeUI16(_loc1_,"metadatacreator".length);
         _loc1_.writeUTFBytes("metadatacreator");
         _loc1_.writeByte(2);
         writeUI16(_loc1_,_loc2_.length);
         _loc1_.writeUTFBytes(_loc2_);
         writeUI24(_loc1_,9);
         return _loc1_;
      }
      
      private function writeUI24(param1:*, param2:uint) : void
      {
         var _loc3_:* = param2 >> 16;
         var _loc5_:* = param2 >> 8 & 255;
         var _loc4_:* = param2 & 255;
         param1.writeByte(_loc3_);
         param1.writeByte(_loc5_);
         param1.writeByte(_loc4_);
      }
      
      private function writeUI16(param1:*, param2:uint) : void
      {
         param1.writeByte(param2 >> 8);
         param1.writeByte(param2 & 255);
      }
      
      private function writeUI4_12(param1:*, param2:uint, param3:uint) : void
      {
         var _loc4_:* = param2 << 4;
         var _loc5_:* = param3 >> 8;
         var _loc6_:int = _loc4_ + _loc5_;
         var _loc7_:* = param3 & 255;
         param1.writeByte(_loc6_);
         param1.writeByte(_loc7_);
      }
      
      public function get isOpen() : Boolean
      {
         return this._isOpen;
      }
      
      public function get enableCompression() : Boolean
      {
         return this._enableCompression;
      }
      
      public function set enableCompression(param1:Boolean) : void
      {
         this._enableCompression = param1;
      }
      
      public function get codec() : int
      {
         return this._codec;
      }
      
      public function set codec(param1:int) : void
      {
         this._codec = param1;
      }
      
      public function get isRecording() : Boolean
      {
         return this._isRecording;
      }
      
      override public function toString() : String
      {
         return "be.boulevart.video.FLVRecorder";
      }
   }
}
