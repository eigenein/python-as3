package com.progrestar.framework.ares.core
{
   import com.progrestar.framework.ares.io.ResourceUtils;
   import flash.geom.Matrix;
   
   public class State
   {
       
      
      public var name:String;
      
      public var blendMode:String = "normal";
      
      public var matrix:Matrix;
      
      public var childIndex:int = -1;
      
      public var colorMode:uint = 0;
      
      public var colorAlpha:Number = 0;
      
      public var colorMultiplier:uint = 0;
      
      public var colorMatrix:Vector.<Number>;
      
      public var cacheHasAnimation:Boolean;
      
      public function State()
      {
         super();
      }
      
      public static function isEqual(param1:State, param2:State) : Boolean
      {
         if(param1 == param2)
         {
            return true;
         }
         if(param1.name != param2.name)
         {
            if(!(param1.name && param2.name && (param1.name.indexOf("instance") == 0 || param1.name == "@undefined@") && param2.name.indexOf("instance") == 0 || param2.name == "@undefined@"))
            {
               return false;
            }
         }
         if(param1.blendMode != param2.blendMode)
         {
            return false;
         }
         if(!ResourceUtils.isMatrixEqual(param1.matrix,param2.matrix))
         {
            return false;
         }
         if(param1.colorMode != param2.colorMode)
         {
            return false;
         }
         if(param1.childIndex != param2.childIndex)
         {
            return false;
         }
         if(param1.colorMode == 3)
         {
            if(!ResourceUtils.isColorMatrixEqual(param1.colorMatrix,param2.colorMatrix))
            {
               return false;
            }
         }
         if(param1.colorMode == 1)
         {
            if(param1.colorAlpha != param2.colorAlpha)
            {
               return false;
            }
         }
         if(param1.colorMode == 2)
         {
            if(param1.colorMultiplier != param2.colorMultiplier)
            {
               return false;
            }
         }
         return true;
      }
      
      public function copyFrom(param1:State) : void
      {
         name = param1.name;
         blendMode = param1.blendMode;
         matrix = param1.matrix;
         childIndex = param1.childIndex;
         colorMode = param1.colorMode;
         colorAlpha = param1.colorAlpha;
         colorMultiplier = param1.colorMultiplier;
         colorMatrix = param1.colorMatrix;
      }
   }
}
