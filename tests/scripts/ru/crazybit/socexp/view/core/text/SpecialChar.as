package ru.crazybit.socexp.view.core.text
{
   import flash.geom.Rectangle;
   
   public class SpecialChar
   {
       
      
      private var _id:uint;
      
      private var _rect:Rectangle;
      
      public function SpecialChar()
      {
         _rect = new Rectangle();
         super();
      }
      
      public static function createWithString(param1:String) : SpecialChar
      {
         var _loc5_:* = 0;
         var _loc2_:SpecialChar = null;
         var _loc3_:Array = [FormatChar.tryNewFormatChar,TextureChar.tryNewTextureChar];
         var _loc4_:int = _loc3_.length;
         _loc5_ = uint(0);
         while(_loc5_ < _loc4_ && !_loc2_)
         {
            _loc2_ = (_loc3_[_loc5_] as Function)(param1);
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get id() : uint
      {
         return _id;
      }
      
      public function set id(param1:uint) : void
      {
         _id = param1;
      }
      
      public function get rect() : Rectangle
      {
         return _rect;
      }
      
      public function set rect(param1:Rectangle) : void
      {
         _rect = param1;
      }
   }
}
