package com.progrestar.framework.ares.io
{
   import by.blooddy.crypto.Base64;
   import com.progrestar.common.Logger;
   import com.progrestar.common.util.assert;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.core.ClipImage;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Frame;
   import com.progrestar.framework.ares.core.Item;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.core.State;
   import com.progrestar.framework.ares.extension.DataExtensionBase;
   import com.progrestar.framework.ares.extension.DataExtensionType;
   import com.progrestar.framework.ares.extension.Scale9DataExtension;
   import com.progrestar.framework.ares.extension.SoundDataExtension;
   import com.progrestar.framework.ares.extension.TextFieldDataExtension;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import org.osflash.signals.Signal;
   
   public class ResourceReader
   {
      
      public static const CAP_IMAGE:ClipImage = new ClipImage(2147483647);
      
      public static const USE_PNG_ENCODER:Boolean = true;
      
      private static const IDENTITY_MATRIX:Matrix = new Matrix();
      
      public static const UNDEFINED_INSTANCE_NAME:String = "@undefined@";
      
      private static const INSTANCE_NAME_TEST_READ:ByteArray = new ByteArray();
       
      
      public const resourceReady:Signal = new Signal(ClipAsset);
      
      public const resourceError:Signal = new Signal(String);
      
      public const links:Vector.<String> = new Vector.<String>(0);
      
      private var resource:ClipAsset;
      
      private var handlers:Array;
      
      private var waitingCounter:int = 0;
      
      private var lastChunk:IByteArrayReadOnly;
      
      private var lastChunkLength:int;
      
      private var lastHandler:Function;
      
      private var clipForNode:Dictionary;
      
      private var imageForFrame:Dictionary;
      
      private var checkSum:uint = 0;
      
      private var data:ByteArrayReadOnly;
      
      public function ResourceReader()
      {
         handlers = [];
         clipForNode = new Dictionary();
         imageForFrame = new Dictionary();
         super();
         handlers[2048] = readDate;
         handlers[2] = readCompressed;
         handlers[256] = readImage;
         handlers[1536] = readResolutions;
         handlers[2304] = readResourceResolution;
         handlers[1792] = readAreas;
         handlers[1280] = readNames;
         handlers[512] = readFrame;
         handlers[513] = readFrameWithFrame;
         handlers[1024] = readNode;
         handlers[4352] = readNode32;
         handlers[768] = readClip;
         handlers[4096] = readExtensions;
         SoundDataExtension.TYPE;
         Scale9DataExtension.TYPE;
      }
      
      private static function registerItem(param1:Object, param2:Item) : Item
      {
         var _loc3_:int = param2.id;
         if(param1.length <= _loc3_)
         {
            param1.length = _loc3_ + 1;
         }
         param1[_loc3_] = param2;
         return param2;
      }
      
      private static function isEquivalent(param1:Number, param2:Number, param3:Number = 1.0E-4) : Boolean
      {
         return param1 - param3 < param2 && param1 + param3 > param2;
      }
      
      public function clear() : void
      {
         if(data)
         {
            data.clear();
            data = null;
         }
         if(lastChunk)
         {
            (lastChunk as ByteArray).clear();
            lastChunk = null;
         }
         resource = null;
         clipForNode = null;
         imageForFrame = null;
      }
      
      private function finish() : void
      {
         validateAsset();
         resourceReady.dispatch(resource);
      }
      
      private function validateAsset() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = clipForNode;
         for(var _loc1_ in clipForNode)
         {
            _loc1_.clip = resource.clips[clipForNode[_loc1_]];
         }
         var _loc7_:int = 0;
         var _loc6_:* = imageForFrame;
         for(var _loc3_ in imageForFrame)
         {
            _loc2_ = imageForFrame[_loc3_];
            if(resource.images.length > _loc2_)
            {
               _loc3_.image = resource.images[_loc2_];
            }
            else
            {
               _loc3_.image = CAP_IMAGE;
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = resource.frames;
         for each(_loc3_ in resource.frames)
         {
            _loc3_.image.frames.push(_loc3_);
         }
         var _loc11_:int = 0;
         var _loc10_:* = clipForNode;
         for(_loc1_ in clipForNode)
         {
            assert(_loc1_.clip != null);
         }
      }
      
      private function readExtensions(param1:IByteArrayReadOnly) : void
      {
         var _loc7_:int = 0;
         var _loc3_:* = 0;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc10_:* = null;
         var _loc2_:* = null;
         var _loc6_:Dictionary = new Dictionary();
         var _loc9_:int = param1.readUnsignedShort();
         _loc7_ = 0;
         while(_loc7_ < _loc9_)
         {
            _loc3_ = uint(param1.readUnsignedShort());
            _loc4_ = param1.readUTF();
            _loc6_[_loc3_] = DataExtensionType.getTypeByName(_loc4_);
            if(!_loc6_[_loc3_])
            {
               trace("unknown extension chunk format " + _loc4_);
            }
            _loc7_++;
         }
         var _loc8_:int = param1.readUnsignedShort();
         _loc7_ = 0;
         while(_loc7_ < _loc8_)
         {
            _loc3_ = uint(param1.readUnsignedShort());
            _loc5_ = param1.readUnsignedInt();
            _loc10_ = _loc6_[_loc3_];
            if(_loc10_ != null)
            {
               _loc2_ = _loc10_.createInstance(resource);
               _loc2_.readChunk(param1);
            }
            else
            {
               param1.readUTFBytes(_loc5_);
            }
            _loc7_++;
         }
      }
      
      private function readDate(param1:IByteArrayReadOnly) : void
      {
         resource.date = param1.readDouble();
      }
      
      public function readImage(param1:IByteArrayReadOnly) : void
      {
         var _loc6_:int = 0;
         var _loc5_:int = param1.position;
         var _loc2_:ClipImage = new ClipImage(param1.readUnsignedShort());
         registerItem(resource.images,_loc2_);
         _loc2_.resource = resource;
         var _loc3_:int = param1.readUnsignedByte();
         var _loc4_:ByteArray = new ByteArray();
         param1.readBytes(_loc4_,0,lastChunkLength - 3);
         if(_loc3_ == 4)
         {
            _loc2_.atfData = _loc4_;
         }
         else
         {
            _loc2_.packSize = _loc4_.length;
            if(_loc3_ == 8)
            {
               _loc6_ = _loc4_.readInt();
               _loc4_ = Base64.decode(_loc4_.readUTFBytes(_loc6_));
            }
            if(_loc3_ != 9)
            {
               readImageData(_loc2_,_loc4_);
            }
         }
      }
      
      private function readImageData(param1:ClipImage, param2:ByteArray) : void
      {
         image = param1;
         imageData = param2;
         onLoaded = function(param1:Event):void
         {
            loader.contentLoaderInfo.removeEventListener("complete",onLoaded);
            var _loc2_:LoaderInfo = param1.currentTarget as LoaderInfo;
            setupImageData(_loc2_,image,imageData);
         };
         var loader:Loader = new Loader();
         var loaderContext:LoaderContext = new LoaderContext();
         loaderContext.imageDecodingPolicy = "onLoad";
         loader.contentLoaderInfo.addEventListener("complete",onLoaded);
         waitingCounter = Number(waitingCounter) + 1;
         loader.loadBytes(imageData,loaderContext);
      }
      
      private function setupImageData(param1:LoaderInfo, param2:ClipImage, param3:ByteArray) : void
      {
         var _loc4_:int = 0;
         _loc4_ = 2880;
         param3.clear();
         param3 = null;
         var _loc5_:Bitmap = Bitmap(param1.loader.content);
         if(_loc5_ != null && _loc5_.width > 0 && _loc5_.height > 0 && _loc5_.width <= 2880 && _loc5_.height <= 2880)
         {
            param2.bitmapData = new BitmapData(_loc5_.bitmapData.width,_loc5_.bitmapData.height,true,0);
            param2.bitmapData.copyPixels(_loc5_.bitmapData,_loc5_.bitmapData.rect,new Point());
         }
         else
         {
            param2.bitmapData = new BitmapData(100,100,false,4294902015);
            Logger.getLogger("AssetLoadError").error("bad bitmapData " + (!!resource?resource.name:"no resource") + ":" + param2.name);
         }
         param1.loader.unload();
         waitingCounter = Number(waitingCounter) - 1;
         if(waitingCounter == 0)
         {
            finish();
         }
      }
      
      private function readResolutions(param1:IByteArrayReadOnly) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = resource.clips;
         for each(var _loc2_ in resource.clips)
         {
            _loc2_.invertedResolution = param1.readShort() / 1000;
         }
      }
      
      private function readResourceResolution(param1:IByteArrayReadOnly) : void
      {
         resource.invertedResolution = param1.readShort() / 1000;
      }
      
      private function readAreas(param1:IByteArrayReadOnly) : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = resource.clips;
         for each(var _loc3_ in resource.clips)
         {
            _loc2_ = param1.readByte();
            if(_loc2_)
            {
               _loc3_.bounds = new Rectangle();
               _loc3_.bounds.x = param1.readShort();
               _loc3_.bounds.y = param1.readShort();
               _loc3_.bounds.width = param1.readShort();
               _loc3_.bounds.height = param1.readShort();
            }
            else
            {
               _loc3_.bounds = null;
            }
         }
      }
      
      private function readNames(param1:IByteArrayReadOnly) : void
      {
         resource.setName(param1.readUTF());
         var _loc4_:int = 0;
         var _loc3_:* = resource.images;
         for each(var _loc2_ in resource.images)
         {
            _loc2_.name = param1.readUTF();
         }
      }
      
      private function readFrame(param1:IByteArrayReadOnly) : void
      {
         var _loc2_:Frame = new Frame(param1.readUnsignedShort());
         registerItem(resource.frames,_loc2_);
         imageForFrame[_loc2_] = param1.readUnsignedShort();
         _loc2_.area = new Rectangle();
         _loc2_.area.x = param1.readShort();
         _loc2_.area.y = param1.readShort();
         _loc2_.area.width = param1.readShort();
         _loc2_.area.height = param1.readShort();
         if(resource.version == 538183465)
         {
            _loc2_.doubleOffsetX = param1.readFloat() * 2;
            _loc2_.doubleOffsetY = param1.readFloat() * 2;
         }
         else
         {
            _loc2_.doubleOffsetX = param1.readShort();
            _loc2_.doubleOffsetY = param1.readShort();
         }
         _loc2_.frame = null;
      }
      
      private function readFrameWithFrame(param1:IByteArrayReadOnly) : void
      {
         var _loc2_:Frame = new Frame(param1.readUnsignedShort());
         registerItem(resource.frames,_loc2_);
         imageForFrame[_loc2_] = param1.readUnsignedShort();
         _loc2_.area = new Rectangle();
         _loc2_.area.x = param1.readShort();
         _loc2_.area.y = param1.readShort();
         _loc2_.area.width = param1.readShort();
         _loc2_.area.height = param1.readShort();
         if(resource.version == 538183465)
         {
            _loc2_.doubleOffsetX = param1.readFloat() * 2;
            _loc2_.doubleOffsetY = param1.readFloat() * 2;
         }
         else
         {
            _loc2_.doubleOffsetX = param1.readShort();
            _loc2_.doubleOffsetY = param1.readShort();
         }
         _loc2_.frame = new Rectangle(param1.readShort(),param1.readShort(),param1.readShort(),param1.readShort());
      }
      
      private function readNode(param1:IByteArrayReadOnly) : void
      {
         var _loc2_:Node = new Node(param1.readUnsignedShort());
         readNodeBody(_loc2_,param1);
      }
      
      private function readNode32(param1:IByteArrayReadOnly) : void
      {
         var _loc2_:Node = new Node(param1.readUnsignedInt());
         readNodeBody(_loc2_,param1);
      }
      
      private function readNodeBody(param1:Node, param2:IByteArrayReadOnly) : void
      {
         var _loc6_:* = null;
         registerItem(resource.nodes,param1);
         clipForNode[param1] = param2.readUnsignedShort();
         param1.layer = param2.readUnsignedShort();
         var _loc9_:* = new State();
         param1.state = _loc9_;
         var _loc5_:* = _loc9_;
         var _loc4_:int = param2.readShort();
         var _loc7_:ByteArray = INSTANCE_NAME_TEST_READ;
         _loc7_.position = 0;
         _loc7_.writeShort(_loc4_);
         param2.readBytes(_loc7_,2,_loc4_);
         if(_loc7_.readByte() == 105 && _loc7_.readByte() == 110 && _loc7_.readByte() == 115 && _loc7_.readByte() == 116 && _loc7_.readByte() == 97 && _loc7_.readByte() == 110 && _loc7_.readByte() == 99 && _loc7_.readByte() == 101)
         {
            _loc5_.name = "@undefined@";
         }
         else
         {
            _loc7_.position = 0;
            _loc5_.name = _loc7_.readUTF();
         }
         var _loc3_:int = param2.readUnsignedByte();
         _loc5_.blendMode = ResourceBlendMode.fastMarkeToValue[_loc3_];
         _loc5_.colorMode = param2.readUnsignedByte();
         _loc5_.childIndex = param2.readUnsignedShort();
         if(_loc5_.colorMode == 1)
         {
            _loc5_.colorAlpha = param2.readFloat();
         }
         if(_loc5_.colorMode == 2)
         {
            _loc5_.colorMultiplier = param2.readUnsignedInt();
         }
         if(_loc5_.colorMode == 3)
         {
            _loc5_.colorMatrix = readColorMatrix(param2);
            if(!_loc5_.colorMatrix)
            {
               _loc5_.colorMode = 0;
            }
         }
         var _loc8_:int = param2.readUnsignedByte();
         if(32 == _loc8_)
         {
            _loc5_.matrix = IDENTITY_MATRIX;
         }
         else if(33 == _loc8_)
         {
            _loc6_ = new Matrix();
            _loc5_.matrix = _loc6_;
            _loc6_.a = param2.readFloat();
            _loc6_.b = param2.readFloat();
            _loc6_.c = param2.readFloat();
            _loc6_.d = param2.readFloat();
            _loc6_.tx = param2.readFloat();
            _loc6_.ty = param2.readFloat();
         }
      }
      
      private function readColorMatrix(param1:IByteArrayReadOnly) : Vector.<Number>
      {
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Boolean = false;
         var _loc2_:Vector.<Number> = new Vector.<Number>(20,true);
         if(resource.version < 538186016)
         {
            _loc5_ = [];
            _loc5_.length = 8;
            _loc3_ = 0;
            while(_loc3_ < 8)
            {
               _loc5_[_loc3_] = param1.readFloat();
               _loc3_++;
            }
            ResourceUtils.colorTransformArrayToColorMatrix(_loc2_,_loc5_);
         }
         else
         {
            _loc4_ = true;
            _loc3_ = 0;
            while(_loc3_ < 20)
            {
               _loc2_[_loc3_] = param1.readFloat();
               if(_loc3_ % 6 == 0)
               {
                  if(_loc2_[_loc3_] != 1)
                  {
                     _loc4_ = false;
                  }
               }
               else if(_loc2_[_loc3_] != 0)
               {
                  _loc4_ = false;
               }
               _loc3_++;
            }
            if(_loc4_)
            {
               return null;
            }
         }
         return _loc2_;
      }
      
      private function readCompressed(param1:IByteArrayReadOnly) : void
      {
         var _loc2_:ByteArrayReadOnly = new ByteArrayReadOnly();
         _loc2_.endian = "bigEndian";
         param1.readBytes(_loc2_,0,lastChunkLength);
         _loc2_.uncompress();
         _loc2_.position = 0;
         while(_loc2_.position < _loc2_.length)
         {
            readChunk(_loc2_);
         }
      }
      
      private function readClip(param1:IByteArrayReadOnly) : void
      {
         var _loc12_:* = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:* = null;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = -1;
         var _loc13_:Clip = new Clip(param1.readUnsignedShort());
         _loc13_.resource = resource;
         registerItem(resource.clips,_loc13_);
         _loc13_.className = param1.readUTF();
         var _loc14_:int = param1.readUnsignedByte();
         var _loc5_:int = param1.readUnsignedByte();
         var _loc4_:* = _loc5_ & 1;
         var _loc6_:* = _loc5_ & 2;
         var _loc15_:* = param1.readUnsignedShort();
         _loc13_.timeLine.length = _loc15_;
         var _loc3_:int = _loc15_;
         _loc13_.marker = _loc14_ == 1;
         if(_loc4_)
         {
            _loc12_ = param1.readUTF();
            _loc13_.data = JSON.parse(_loc12_);
         }
         else
         {
            _loc13_.data = null;
         }
         if(_loc6_)
         {
            _loc13_.linkSymbol = param1.readUTF();
            links.push(_loc13_.linkSymbol);
         }
         else
         {
            _loc13_.linkSymbol = null;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc3_)
         {
            _loc7_ = param1.readUnsignedByte();
            if(17 == _loc7_)
            {
               _loc13_.timeLine[_loc8_] = resource.frames[param1.readUnsignedShort()];
            }
            else if(18 == _loc7_)
            {
               _loc11_++;
               _loc2_ = new Container(_loc11_);
               _loc15_ = param1.readUnsignedShort();
               _loc2_.nodes.length = _loc15_;
               _loc9_ = _loc15_;
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  _loc2_.nodes[_loc10_] = resource.nodes[param1.readUnsignedShort()];
                  _loc10_++;
               }
               _loc13_.timeLine[_loc8_] = _loc2_;
            }
            else if(19 == _loc7_)
            {
               _loc11_++;
               _loc2_ = new Container(_loc11_);
               _loc15_ = param1.readUnsignedShort();
               _loc2_.nodes.length = _loc15_;
               _loc9_ = _loc15_;
               _loc10_ = 0;
               while(_loc10_ < _loc9_)
               {
                  _loc2_.nodes[_loc10_] = resource.nodes[param1.readUnsignedInt()];
                  _loc10_++;
               }
               _loc13_.timeLine[_loc8_] = _loc2_;
            }
            _loc8_++;
         }
      }
      
      public function readData(param1:ClipAsset, param2:ByteArray) : void
      {
         var _loc4_:* = 0;
         var _loc3_:Boolean = false;
         var _loc5_:* = 0;
         this.resource = param1;
         if(param1 == null)
         {
            error("null ClipAsset");
            return;
         }
         if(param2 == null)
         {
            error("null ByteArray");
            return;
         }
         param2.position = 0;
         data = new ByteArrayReadOnly();
         data.endian = "bigEndian";
         param2.readBytes(data);
         if("RE$X" == data.readUTF())
         {
            _loc4_ = uint(data.readUnsignedInt());
            assert(_loc4_ == 538183465 || _loc4_ == 538183984 || _loc4_ == 538185749 || _loc4_ == 538186016 || _loc4_ == 538247719 || _loc4_ == 538248455 || _loc4_ == 538248480 || _loc4_ == 538251539);
            param1.version = _loc4_;
            waitingCounter = Number(waitingCounter) + 1;
            while(data.position < data.length - 4)
            {
               _loc3_ = readChunk(data);
               if(!_loc3_)
               {
                  return;
               }
            }
            _loc5_ = uint(data.readUnsignedInt());
            if(_loc5_ != checkSum)
            {
               error("Invalid checksum (" + checkSum + " <> " + _loc5_ + ")");
               return;
            }
            waitingCounter = Number(waitingCounter) - 1;
            if(waitingCounter == 0)
            {
               finish();
            }
         }
         else
         {
            error("Invalid file header");
         }
      }
      
      private function warning(param1:String) : void
      {
      }
      
      private function error(param1:String) : void
      {
         trace("ResourceReader::error message=",param1);
         resourceError.dispatch(param1);
      }
      
      private function simulateError() : void
      {
         (lastChunk as ByteArray).position = 0;
      }
      
      private function readChunk(param1:IByteArrayReadOnly) : Boolean
      {
         if(!param1)
         {
            error("Null chunk");
            return false;
         }
         var _loc3_:int = param1.position + 6;
         var _loc4_:int = param1.length;
         if(_loc4_ < _loc3_)
         {
            error("Invalid chunk header");
            return false;
         }
         var _loc6_:uint = param1.readUnsignedShort();
         var _loc5_:uint = param1.readUnsignedInt();
         var _loc2_:Function = handlers[_loc6_];
         checkSum = checkSum + (_loc6_ + _loc5_);
         if(_loc4_ < _loc3_ + _loc5_)
         {
            error("Invalid chunk content: " + ResourceConst.getChunkName(_loc6_));
            (param1 as ByteArray).length = _loc3_ + _loc5_;
            return false;
         }
         lastChunk = param1;
         lastChunkLength = _loc5_;
         lastHandler = _loc2_;
         if(_loc2_ != null)
         {
            _loc2_(param1);
            if(_loc3_ + _loc5_ != param1.position)
            {
               error("Not all chunk is read " + ResourceConst.getChunkName(_loc6_));
               return false;
            }
         }
         else
         {
            warning("Unknown chunk type: " + ResourceConst.getChunkName(_loc6_));
         }
         return true;
      }
   }
}
