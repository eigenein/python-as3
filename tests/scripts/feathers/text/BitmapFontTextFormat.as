package feathers.text
{
   import starling.text.BitmapFont;
   import starling.text.TextField;
   
   public class BitmapFontTextFormat
   {
       
      
      public var font:BitmapFont;
      
      public var color:uint;
      
      public var size:Number;
      
      public var letterSpacing:Number = 0;
      
      [Inspectable(type="String",enumeration="left,center,right")]
      public var align:String = "left";
      
      public var isKerningEnabled:Boolean = true;
      
      public function BitmapFontTextFormat(param1:Object, param2:Number = -1, param3:uint = 16777215, param4:String = null)
      {
         super();
         if(param2 == -1)
         {
            param2 = NaN;
         }
         if(param4 == null)
         {
            param4 = "left";
         }
         if(param1 is String)
         {
            param1 = TextField.getBitmapFont(param1 as String);
         }
         if(!(param1 is BitmapFont))
         {
            throw new ArgumentError("BitmapFontTextFormat font must be a BitmapFont instance or a String representing the name of a registered bitmap font.");
         }
         this.font = param1 as BitmapFont;
         this.size = param2;
         this.color = param3;
         this.align = param4;
      }
      
      public function get fontName() : String
      {
         return !!this.font?this.font.name:null;
      }
   }
}
