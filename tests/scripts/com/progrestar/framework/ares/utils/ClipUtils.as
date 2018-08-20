package com.progrestar.framework.ares.utils
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.core.ClipImage;
   import com.progrestar.framework.ares.core.Container;
   import com.progrestar.framework.ares.core.Frame;
   import com.progrestar.framework.ares.core.IContent;
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.extension.SoundDataExtension;
   import com.progrestar.framework.ares.extension.sounds.ClipSound;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class ClipUtils
   {
      
      private static var bitmapsClip:Dictionary = new Dictionary();
       
      
      public function ClipUtils()
      {
         super();
      }
      
      public static function equalBitmaps(param1:BitmapData, param2:BitmapData) : Boolean
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1.width != param2.width)
         {
            return false;
         }
         if(param2.height != param2.height)
         {
            return false;
         }
         _loc7_ = 16;
         while(_loc7_ > 1)
         {
            _loc3_ = param1.width;
            _loc4_ = param1.height;
            _loc5_ = _loc3_ - 1;
            while(_loc5_ >= 0)
            {
               _loc6_ = _loc4_ - 1;
               while(_loc6_ >= 0)
               {
                  if(param1.getPixel32(_loc5_,_loc6_) != param2.getPixel32(_loc5_,_loc6_))
                  {
                     return false;
                  }
                  _loc6_ = _loc6_ - _loc7_;
               }
               _loc5_ = _loc5_ - _loc7_;
            }
            _loc7_ = _loc7_ / 2;
         }
         return true;
      }
      
      public static function getSoundByName(param1:ClipAsset, param2:String) : ClipSound
      {
         var _loc3_:SoundDataExtension = SoundDataExtension.fromAsset(param1);
         if(_loc3_)
         {
            return _loc3_.getSoundByName(param2);
         }
         return null;
      }
      
      public static function clipFromBitmap(param1:BitmapData, param2:Boolean) : Clip
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc7_:Clip = bitmapsClip[param1];
         if(_loc7_ == null)
         {
            if(param2)
            {
               var _loc10_:int = 0;
               var _loc9_:* = bitmapsClip;
               for(var _loc6_ in bitmapsClip)
               {
                  if(equalBitmaps(_loc6_,param1))
                  {
                     return bitmapsClip[_loc6_];
                  }
               }
            }
            _loc7_ = new Clip(0);
            bitmapsClip[param1] = new Clip(0);
            _loc5_ = new ClipAsset("generated");
            _loc4_ = new ClipImage(0);
            _loc8_ = new Frame(0);
            _loc4_.bitmapData = param1;
            _loc4_.frames.push(_loc8_);
            _loc4_.resource = _loc5_;
            _loc3_ = param1.rect.clone();
            _loc3_.inflate(-1,-1);
            _loc8_.image = _loc4_;
            _loc8_.area = _loc3_;
            _loc8_.frame = new Rectangle(0,0,_loc3_.width,_loc3_.height);
            _loc8_.doubleOffsetX = 0;
            _loc8_.doubleOffsetY = 0;
            _loc7_.timeLine.push(_loc8_);
         }
         return _loc7_;
      }
      
      public static function getMarkersNodes(param1:Clip, param2:Vector.<Node> = null) : Vector.<Node>
      {
         var _loc3_:* = null;
         if(param2 == null)
         {
            param2 = new Vector.<Node>(0);
         }
         else
         {
            param2.length = 0;
         }
         var _loc9_:int = 0;
         var _loc8_:* = param1.timeLine;
         for each(var _loc5_ in param1.timeLine)
         {
            _loc3_ = _loc5_ as Container;
            if(_loc3_ != null)
            {
               var _loc7_:int = 0;
               var _loc6_:* = _loc3_.nodes;
               for each(var _loc4_ in _loc3_.nodes)
               {
                  if(_loc4_.clip.marker)
                  {
                     if(param2.indexOf(_loc4_) == -1)
                     {
                        param2[param2.length] = _loc4_;
                     }
                  }
               }
               continue;
            }
         }
         return param2;
      }
      
      public static function getMarkersNodesRecursive(param1:Clip, param2:Vector.<Node> = null) : Vector.<Node>
      {
         if(param2 == null)
         {
            param2 = new Vector.<Node>(0);
         }
         _getMarkersNodesRecursive(param1,param2);
         return param2;
      }
      
      public static function _getMarkersNodesRecursive(param1:Clip, param2:Vector.<Node>) : void
      {
         var _loc3_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = param1.timeLine;
         for each(var _loc5_ in param1.timeLine)
         {
            _loc3_ = _loc5_ as Container;
            if(_loc3_ != null)
            {
               var _loc7_:int = 0;
               var _loc6_:* = _loc3_.nodes;
               for each(var _loc4_ in _loc3_.nodes)
               {
                  if(_loc4_.clip.marker)
                  {
                     if(param2.indexOf(_loc4_) == -1)
                     {
                        param2[param2.length] = _loc4_;
                     }
                  }
                  else
                  {
                     _getMarkersNodesRecursive(_loc4_.clip,param2);
                  }
               }
               continue;
            }
         }
      }
      
      public static function getMarkerTransform(param1:Clip, param2:String) : Matrix
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc10_:int = 0;
         var _loc9_:* = param1.timeLine;
         for each(var _loc6_ in param1.timeLine)
         {
            _loc3_ = _loc6_ as Container;
            if(_loc3_ != null)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _loc3_.nodes;
               for each(var _loc4_ in _loc3_.nodes)
               {
                  if(_loc4_.clip.marker && (_loc4_.clip.className == "marker_" + param2 || _loc4_.clip.className == "MARKER_" + param2))
                  {
                     return _loc4_.state.matrix;
                  }
                  _loc5_ = getMarkerTransform(_loc4_.clip,param2);
                  if(_loc5_)
                  {
                     _loc5_.concat(_loc4_.state.matrix);
                     return _loc5_;
                  }
               }
               continue;
            }
         }
         return null;
      }
      
      public static function getMarkersByName(param1:Clip, param2:String) : Vector.<Node>
      {
         var _loc4_:* = null;
         var _loc3_:Vector.<Node> = new Vector.<Node>(0);
         var _loc10_:int = 0;
         var _loc9_:* = param1.timeLine;
         for each(var _loc6_ in param1.timeLine)
         {
            _loc4_ = _loc6_ as Container;
            if(_loc4_ != null)
            {
               var _loc8_:int = 0;
               var _loc7_:* = _loc4_.nodes;
               for each(var _loc5_ in _loc4_.nodes)
               {
                  if(_loc5_.clip.marker && (_loc5_.clip.className == "marker_" + param2 || _loc5_.clip.className == "MARKER_" + param2))
                  {
                     if(_loc3_.indexOf(_loc5_) == -1)
                     {
                        _loc3_[_loc3_.length] = _loc5_;
                     }
                  }
               }
               continue;
            }
         }
         return _loc3_;
      }
      
      public static function findSubAnimation(param1:Clip) : Boolean
      {
         if(!param1)
         {
            return false;
         }
         if(param1.linkSymbol)
         {
            return true;
         }
         if(param1.timeLine.length > 1)
         {
            return true;
         }
         if(param1.timeLine.length == 0)
         {
            return false;
         }
         var _loc3_:Frame = param1.timeLine[0] as Frame;
         if(_loc3_)
         {
            return false;
         }
         var _loc2_:Container = param1.timeLine[0] as Container;
         if(_loc2_ == null)
         {
            return false;
         }
         if(_loc2_.nodes.length > 1)
         {
            return true;
         }
         if(_loc2_.nodes.length == 0)
         {
            return false;
         }
         return findSubAnimation(_loc2_.nodes[0].clip);
      }
      
      public static function firstFrame(param1:Clip) : Frame
      {
         var _loc3_:* = null;
         if(param1.timeLine.length == 0)
         {
            return null;
         }
         var _loc4_:Frame = param1.timeLine[0] as Frame;
         var _loc2_:Container = param1.timeLine[0] as Container;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.nodes[0] as Node;
            if(_loc3_ != null)
            {
               _loc4_ = _loc3_.clip.timeLine[0] as Frame;
            }
         }
         return _loc4_;
      }
      
      public static function firstFrameBlitted(param1:Clip) : DisplayObject
      {
         var _loc3_:* = null;
         var _loc7_:* = null;
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc5_:Sprite = new Sprite();
         var _loc8_:Frame = param1.timeLine[0] as Frame;
         var _loc2_:Container = param1.timeLine[0] as Container;
         if(_loc2_ != null)
         {
            _loc3_ = _loc2_.nodes[0] as Node;
            if(_loc3_ != null)
            {
               _loc8_ = _loc3_.clip.timeLine[0] as Frame;
            }
         }
         if(_loc8_ != null)
         {
            _loc7_ = new Matrix();
            _loc7_.translate(-_loc8_.area.x,-_loc8_.area.y);
            _loc4_ = new BitmapData(int(_loc8_.area.width),int(_loc8_.area.height),true,0);
            _loc4_.draw(_loc8_.image.bitmapData,_loc7_,null,null,null,true);
            _loc6_ = new Bitmap(_loc4_,"auto",true);
            _loc5_.addChild(_loc6_);
         }
         return _loc5_;
      }
      
      public static function doesClipHasNestedAnimation(param1:Clip) : Boolean
      {
         var _loc3_:* = undefined;
         var _loc4_:int = param1.timeLine.length;
         if(_loc4_ > 1)
         {
            return true;
         }
         if(_loc4_ == 1)
         {
            var _loc9_:int = 0;
            var _loc8_:* = param1.timeLine;
            for each(var _loc2_ in param1.timeLine)
            {
               if(_loc2_ is Container)
               {
                  _loc3_ = (_loc2_ as Container).nodes;
                  var _loc7_:int = 0;
                  var _loc6_:* = _loc3_;
                  for each(var _loc5_ in _loc3_)
                  {
                     if(_loc5_ != null && _loc5_.clip != null && doesClipHasNestedAnimation(_loc5_.clip))
                     {
                        return true;
                     }
                  }
                  continue;
               }
            }
         }
         return false;
      }
   }
}
