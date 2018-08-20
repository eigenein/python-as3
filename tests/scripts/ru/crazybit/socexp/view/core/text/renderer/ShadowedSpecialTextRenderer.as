package ru.crazybit.socexp.view.core.text.renderer
{
   import starling.core.RenderSupport;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.textures.Texture;
   
   public class ShadowedSpecialTextRenderer extends SpecialTextRenderer
   {
       
      
      private var _shadowColor:int = -1;
      
      private var _offsetX:int = 0;
      
      private var _offsetY:int = 2;
      
      private var _shadowAlpha:Number = 0.5;
      
      private var _helperCharImage:Image;
      
      private var _helperCharShadowImage:Image;
      
      private var _tmpOrigBatch:QuadBatch;
      
      private var _tmpShadowBatch:QuadBatch;
      
      public function ShadowedSpecialTextRenderer()
      {
         super();
      }
      
      public function get shadowColor() : int
      {
         return _shadowColor;
      }
      
      public function set shadowColor(param1:int) : void
      {
         _shadowColor = param1;
      }
      
      public function get offsetX() : int
      {
         return _offsetX;
      }
      
      public function set offsetX(param1:int) : void
      {
         _offsetX = param1;
      }
      
      public function get offsetY() : int
      {
         return _offsetY;
      }
      
      public function set offsetY(param1:int) : void
      {
         _offsetY = param1;
      }
      
      public function get shadowAlpha() : Number
      {
         return _shadowAlpha;
      }
      
      public function set shadowAlpha(param1:Number) : void
      {
         _shadowAlpha = param1;
      }
      
      override public function dispose() : void
      {
         if(_helperCharImage)
         {
            _helperCharImage.dispose();
         }
         if(_helperCharShadowImage)
         {
            _helperCharShadowImage.dispose();
         }
         super.dispose();
      }
      
      override protected function addTextureToBatch(param1:Texture, param2:Number, param3:Number, param4:Number, param5:RenderSupport = null, param6:Number = 1, param7:Boolean = false) : void
      {
         var _loc8_:* = null;
         if(!_helperCharImage)
         {
            _helperCharImage = new Image(param1);
         }
         if(!_helperCharShadowImage)
         {
            _helperCharShadowImage = new Image(param1);
         }
         _helperCharImage.texture = param1;
         _helperCharImage.color = !!param7?16777215:!!customTextFormat?customTextFormat.color:uint(currentTextFormat.color);
         _helperCharImage.readjustSize();
         var _loc9_:* = param4;
         _helperCharImage.scaleY = _loc9_;
         _helperCharImage.scaleX = _loc9_;
         _helperCharImage.x = param2;
         _helperCharImage.y = param3;
         _helperCharShadowImage.texture = param1;
         _helperCharShadowImage.readjustSize();
         _loc9_ = param4;
         _helperCharShadowImage.scaleY = _loc9_;
         _helperCharShadowImage.scaleX = _loc9_;
         _helperCharShadowImage.x = param2 + _offsetX;
         _helperCharShadowImage.y = param3 + _offsetY;
         if(_shadowColor != -1)
         {
            _helperCharShadowImage.color = _shadowColor;
         }
         _loc9_ = _smoothing;
         _helperCharShadowImage.smoothing = _loc9_;
         _helperCharImage.smoothing = _loc9_;
         if(param5)
         {
            param5.pushMatrix();
            param5.transformMatrix(_helperCharShadowImage);
            param5.batchQuad(_helperCharShadowImage,param6,_helperCharShadowImage.texture,_smoothing);
            param5.popMatrix();
            param5.pushMatrix();
            param5.transformMatrix(_helperCharImage);
            param5.batchQuad(_helperCharImage,param6,_helperCharImage.texture,_smoothing);
            param5.popMatrix();
         }
         else
         {
            _loc8_ = _hash[param1.root];
            if(_loc8_ == null || _loc8_.numQuads + 2 > 16383)
            {
               _loc8_ = getNewBatch(_loc8_);
               _hash[param1.root] = _loc8_;
            }
            _loc8_.addImage(_helperCharShadowImage,_shadowAlpha);
            _loc8_.addImage(_helperCharImage);
         }
      }
   }
}
