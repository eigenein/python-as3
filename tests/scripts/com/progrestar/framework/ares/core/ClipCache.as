package com.progrestar.framework.ares.core
{
   import com.progrestar.common.util.assert;
   import flash.utils.Dictionary;
   
   public class ClipCache
   {
      
      private static var containerLayers:Vector.<Dictionary> = new Vector.<Dictionary>(4096);
      
      private static var maxLayer:int = 0;
       
      
      public function ClipCache()
      {
         super();
      }
      
      public static function cacheClip(param1:Clip) : void
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:* = null;
         var _loc7_:* = null;
         _loc4_ = 0;
         while(_loc4_ < param1.timeLine.length)
         {
            _loc2_ = param1.timeLine[_loc4_] as Container;
            if(_loc2_ == null)
            {
               clear();
            }
            else
            {
               _loc5_ = _loc2_.nodes.length;
               _loc2_.firstFrameByNode = new Vector.<uint>(_loc5_,true);
               _loc6_ = 0;
               while(_loc6_ < _loc5_)
               {
                  _loc3_ = _loc2_.nodes[_loc6_];
                  assert(_loc3_ && _loc3_.clip);
                  if(_loc3_.layer > maxLayer)
                  {
                     maxLayer = _loc3_.layer;
                  }
                  _loc7_ = containerLayers[_loc3_.layer];
                  if(!_loc7_)
                  {
                     _loc7_ = new Dictionary();
                     containerLayers[_loc3_.layer] = new Dictionary();
                     _loc7_[_loc3_.clip.id] = _loc4_;
                     _loc2_.firstFrameByNode[_loc6_] = _loc4_;
                  }
                  else if(_loc7_[_loc3_.clip.id] === undefined)
                  {
                     var _loc8_:* = _loc4_;
                     _loc7_[_loc3_.clip.id] = _loc8_;
                     _loc2_.firstFrameByNode[_loc6_] = _loc8_;
                  }
                  else
                  {
                     _loc2_.firstFrameByNode[_loc6_] = _loc7_[_loc3_.clip.id];
                  }
                  _loc6_++;
               }
            }
            _loc4_++;
         }
         clear();
      }
      
      private static function clear() : void
      {
         while(maxLayer >= 0)
         {
            containerLayers[maxLayer] = null;
            maxLayer = Number(maxLayer) - 1;
         }
      }
   }
}
