package com.progrestar.framework.ares.starling
{
   import com.progrestar.framework.ares.core.State;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.filters.ColorMatrixFilter;
   import starling.filters.FragmentFilter;
   
   public class StateFilterCache
   {
       
      
      private var tintOffsetRed:int = 0;
      
      private var tintOffsetGreen:int = 6;
      
      private var tintOffsetBlue:int = 12;
      
      private var tintOffsetAlpha:int = 18;
      
      private var filterPool:Vector.<ColorMatrixFilter>;
      
      private var tintMatrixSample:Vector.<Number>;
      
      private var filterCount:int = 0;
      
      public function StateFilterCache()
      {
         filterPool = new Vector.<ColorMatrixFilter>();
         tintMatrixSample = new <Number>[1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
         super();
      }
      
      public function setupImageColor(param1:DisplayObject, param2:Image, param3:State) : void
      {
         var _loc6_:* = undefined;
         var _loc5_:* = 16777215;
         if(param3.colorMode == 2)
         {
            _loc6_ = null;
            _loc5_ = uint(param3.colorMultiplier);
         }
         else if(param3.colorMode == 3)
         {
            _loc6_ = param3.colorMatrix;
         }
         if(param2.color != _loc5_)
         {
            param2.color = _loc5_;
         }
         var _loc4_:FragmentFilter = param1.filter;
         if(_loc4_)
         {
            if(_loc6_)
            {
               if(_loc4_ is ColorMatrixFilter)
               {
                  (_loc4_ as ColorMatrixFilter).matrix = _loc6_;
               }
               else
               {
                  _loc4_.dispose();
                  if(filterCount > 0)
                  {
                     filterCount = filterCount - 1;
                     _loc4_ = filterPool[filterCount - 1];
                     (_loc4_ as ColorMatrixFilter).matrix = _loc6_;
                     param1.filter = _loc4_;
                  }
                  else
                  {
                     param1.filter = new ColorMatrixFilter(_loc6_);
                  }
               }
            }
            else
            {
               if(_loc4_ is ColorMatrixFilter)
               {
                  filterCount = Number(filterCount) + 1;
                  filterPool[Number(filterCount)] = _loc4_ as ColorMatrixFilter;
               }
               else
               {
                  _loc4_.dispose();
               }
               param1.filter = null;
            }
         }
         else if(_loc6_)
         {
            if(filterCount > 0)
            {
               filterCount = filterCount - 1;
               _loc4_ = filterPool[filterCount - 1];
               (_loc4_ as ColorMatrixFilter).matrix = _loc6_;
               param1.filter = _loc4_;
            }
            else
            {
               param1.filter = new ColorMatrixFilter(_loc6_);
            }
         }
      }
      
      public function setupColor(param1:DisplayObject, param2:State) : void
      {
         var _loc4_:* = undefined;
         if(param2.colorMode == 2)
         {
            tintMatrixSample[tintOffsetRed] = (param2.colorMultiplier & 16711680) / 16711680;
            tintMatrixSample[tintOffsetGreen] = (param2.colorMultiplier & 65280) / 65280;
            tintMatrixSample[tintOffsetBlue] = (param2.colorMultiplier & 255) / 255;
            tintMatrixSample[tintOffsetAlpha] = (uint(param2.colorMultiplier & 4278190080)) / 4278190080;
            _loc4_ = tintMatrixSample;
         }
         else if(param2.colorMode == 3)
         {
            _loc4_ = param2.colorMatrix;
         }
         var _loc3_:FragmentFilter = param1.filter;
         if(_loc3_)
         {
            if(_loc4_)
            {
               if(_loc3_ is ColorMatrixFilter)
               {
                  (_loc3_ as ColorMatrixFilter).matrix = _loc4_;
               }
               else
               {
                  _loc3_.dispose();
                  if(filterCount > 0)
                  {
                     filterCount = filterCount - 1;
                     _loc3_ = filterPool[filterCount - 1];
                     (_loc3_ as ColorMatrixFilter).matrix = _loc4_;
                     param1.filter = _loc3_;
                  }
                  else
                  {
                     param1.filter = new ColorMatrixFilter(_loc4_);
                  }
               }
            }
            else
            {
               if(_loc3_ is ColorMatrixFilter)
               {
                  filterCount = Number(filterCount) + 1;
                  filterPool[Number(filterCount)] = _loc3_ as ColorMatrixFilter;
               }
               else
               {
                  _loc3_.dispose();
               }
               param1.filter = null;
            }
         }
         else if(_loc4_)
         {
            if(filterCount > 0)
            {
               filterCount = filterCount - 1;
               _loc3_ = filterPool[filterCount - 1];
               (_loc3_ as ColorMatrixFilter).matrix = _loc4_;
               param1.filter = _loc3_;
            }
            else
            {
               param1.filter = new ColorMatrixFilter(_loc4_);
            }
         }
      }
      
      public function disposeFilter(param1:FragmentFilter) : void
      {
         if(param1 is ColorMatrixFilter)
         {
            filterCount = Number(filterCount) + 1;
            filterPool[Number(filterCount)] = param1 as ColorMatrixFilter;
         }
         else
         {
            param1.dispose();
         }
      }
      
      public function clear() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < filterCount)
         {
            filterPool[_loc1_].dispose();
            _loc1_++;
         }
         filterPool.length = 0;
         filterCount = 0;
      }
   }
}
