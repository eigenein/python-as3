package ru.crazybit.socexp.view.core.text
{
   import feathers.text.BitmapFontTextFormat;
   import starling.text.BitmapFont;
   
   public class SpecialBitmapFontTextFormat extends BitmapFontTextFormat
   {
       
      
      private var _indent:uint;
      
      private var _colorAdd:uint;
      
      private var _outline:uint;
      
      private var _specialPriority:Boolean;
      
      public function SpecialBitmapFontTextFormat(param1:BitmapFont, param2:Number = 0, param3:uint = 16777215, param4:String = null, param5:uint = 0, param6:uint = 0)
      {
         if(param2 == 0 || param2 != param2)
         {
            param2 = param1.size;
         }
         if(param4 == null)
         {
            param4 = "left";
         }
         super(param1,param2,param3,param4);
         _indent = param5;
      }
      
      public function get indent() : uint
      {
         return _indent;
      }
      
      public function set indent(param1:uint) : void
      {
         _indent = param1;
      }
      
      public function get colorAdd() : uint
      {
         return _colorAdd;
      }
      
      public function set colorAdd(param1:uint) : void
      {
         _colorAdd = param1;
      }
      
      public function get outline() : uint
      {
         return _outline;
      }
      
      public function set outline(param1:uint) : void
      {
         _outline = param1;
      }
      
      public function get addPriority() : Boolean
      {
         return _specialPriority;
      }
      
      public function set addPriority(param1:Boolean) : void
      {
         _specialPriority = param1;
      }
   }
}
