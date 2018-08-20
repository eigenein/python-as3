package com.progrestar.framework.ares.starling
{
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.core.ClipAsset;
   import com.progrestar.framework.ares.core.ClipImage;
   import com.progrestar.framework.ares.core.Frame;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.textures.SubTexture;
   import starling.textures.Texture;
   import starling.textures.TextureMemoryManager;
   
   public class ClipAssetDataProvider
   {
      
      private static var tempRect:Rectangle = new Rectangle();
      
      private static var tempRect2:Rectangle = new Rectangle();
      
      private static var tempMatrix:Matrix = new Matrix();
       
      
      protected var clipAsset:ClipAsset;
      
      protected var classNameMap:Dictionary;
      
      protected var frames:Vector.<ClipFrame>;
      
      protected var textures:Vector.<Texture>;
      
      public function ClipAssetDataProvider(param1:ClipAsset, param2:Number)
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = textures;
         for each(var _loc1_ in textures)
         {
            _loc1_.dispose();
         }
         textures.length = 0;
      }
      
      public function get data() : ClipAsset
      {
         return clipAsset;
      }
      
      public function get name() : String
      {
         return clipAsset.name;
      }
      
      public function getClipByName(param1:String) : Clip
      {
         return classNameMap[param1.toLowerCase()];
      }
      
      public function getClipFrame(param1:int) : ClipFrame
      {
         return frames[param1];
      }
      
      private function createFrames(param1:Number) : void
      {
         var _loc4_:* = null;
         var _loc9_:* = null;
         var _loc2_:* = null;
         var _loc10_:* = null;
         var _loc5_:* = null;
         var _loc6_:ClipAsset = clipAsset;
         frames = new Vector.<ClipFrame>(_loc6_.frames.length,true);
         var _loc11_:* = 0;
         tempMatrix.ty = _loc11_;
         _loc11_ = _loc11_;
         tempMatrix.tx = _loc11_;
         _loc11_ = _loc11_;
         tempMatrix.c = _loc11_;
         tempMatrix.b = _loc11_;
         _loc11_ = param1;
         tempMatrix.d = _loc11_;
         tempMatrix.a = _loc11_;
         var _loc7_:* = 1;
         if(_loc6_.invertedResolution == _loc6_.invertedResolution)
         {
            _loc7_ = Number(1 / _loc6_.invertedResolution);
         }
         var _loc15_:int = 0;
         var _loc14_:* = _loc6_.images;
         for each(var _loc3_ in _loc6_.images)
         {
            _loc4_ = new BitmapData(Math.ceil(param1 * _loc3_.bitmapData.width),Math.ceil(param1 * _loc3_.bitmapData.height),true,0);
            _loc4_.draw(_loc3_.bitmapData,tempMatrix,null,null,null,true);
            _loc9_ = Texture.fromBitmapData(_loc4_,false,false,_loc7_ * param1);
            TextureMemoryManager.add(_loc9_,_loc3_.resource.name + " " + param1);
            textures.push(_loc9_);
            var _loc13_:int = 0;
            var _loc12_:* = _loc3_.frames;
            for each(var _loc8_ in _loc3_.frames)
            {
               _loc2_ = _loc8_.area;
               tempRect2.x = _loc2_.x / _loc7_;
               tempRect2.y = _loc2_.y / _loc7_;
               tempRect2.width = _loc2_.width / _loc7_;
               tempRect2.height = _loc2_.height / _loc7_;
               _loc2_ = tempRect2;
               _loc10_ = _loc8_.frame;
               if(_loc10_ != null)
               {
                  tempRect.x = _loc10_.x / _loc7_;
                  tempRect.y = _loc10_.y / _loc7_;
                  tempRect.width = _loc10_.width / _loc7_;
                  tempRect.height = _loc10_.height / _loc7_;
                  _loc10_ = tempRect;
               }
               _loc5_ = new SubTexture(_loc9_,_loc2_,false,_loc10_,false);
               if(_loc8_.frame)
               {
                  frames[_loc8_.id] = new ClipFrame(_loc5_,_loc8_.doubleOffsetX / _loc7_ - _loc10_.x * 2,_loc8_.doubleOffsetY / _loc7_ - _loc10_.y * 2);
               }
               else
               {
                  frames[_loc8_.id] = new ClipFrame(_loc5_,_loc8_.doubleOffsetX / _loc7_,_loc8_.doubleOffsetY / _loc7_);
               }
            }
         }
      }
   }
}
