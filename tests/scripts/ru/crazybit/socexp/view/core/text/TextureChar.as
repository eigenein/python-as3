package ru.crazybit.socexp.view.core.text
{
   import starling.textures.Texture;
   
   public class TextureChar extends SpecialChar
   {
       
      
      private var _texture:Texture;
      
      private var _scale:Number = 1;
      
      private var _dx:Number = 0;
      
      private var _dy:Number = 0;
      
      public function TextureChar(param1:Number, param2:Number, param3:Number)
      {
         super();
         _scale = param1;
         _dx = param2;
         _dy = param3;
      }
      
      public static function tryNewTextureChar(param1:String) : SpecialChar
      {
         var _loc5_:* = 0;
         var _loc2_:SpecialChar = null;
         var _loc3_:Array = [SpriteChar.tryNewSpriteChar,AtlasChar.tryNewAtlasCharacter];
         var _loc4_:uint = _loc3_.length;
         _loc5_ = uint(0);
         while(_loc5_ < _loc4_ && !_loc2_)
         {
            _loc2_ = (_loc3_[_loc5_] as Function)(param1);
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get textureFrameWidth() : int
      {
         if(texture)
         {
            if(texture.frame)
            {
               return texture.frame.width;
            }
            return texture.width;
         }
         return 1;
      }
      
      public function get textureFrameHeight() : int
      {
         if(texture)
         {
            if(texture.frame)
            {
               return texture.frame.height;
            }
            return texture.height;
         }
         return 1;
      }
      
      public function get texture() : Texture
      {
         return _texture;
      }
      
      public function set texture(param1:Texture) : void
      {
         _texture = param1;
      }
      
      public function get scale() : Number
      {
         return _scale;
      }
      
      public function get dx() : Number
      {
         return _dx;
      }
      
      public function get dy() : Number
      {
         return _dy;
      }
   }
}
