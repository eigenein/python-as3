package game.util
{
   import feathers.controls.Label;
   import feathers.text.BitmapFontTextFormat;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import game.assets.storage.AssetStorage;
   
   public class FontUtils
   {
      
      private static var _textField:TextField;
      
      private static var _format:TextFormat;
       
      
      public function FontUtils()
      {
         super();
      }
      
      public static function getNativeTextFieldMetrics(param1:int) : TextLineMetrics
      {
         if(!_format)
         {
            _format = new TextFormat("_sans",18);
            _format.bold = true;
         }
         if(!_textField)
         {
            _textField = new TextField();
            _textField.defaultTextFormat = _format;
            _textField.text = "Test";
         }
         _format.size = param1;
         _textField.setTextFormat(_format);
         return _textField.getLineMetrics(0);
      }
      
      public static function getGameFontBaselineByLabel(param1:Label) : Number
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:Number = AssetStorage.font.templateSize;
         _loc3_ = param1.textRendererProperties.textFormat as TextFormat;
         if(_loc3_ != null)
         {
            _loc2_ = _loc3_.size as Number;
         }
         else
         {
            _loc4_ = param1.textRendererProperties as BitmapFontTextFormat;
            if(_loc4_ != null)
            {
               _loc2_ = _loc4_.size;
            }
         }
         return getGameFontBaselineBySize(_loc2_);
      }
      
      public static function getGameFontBaselineBySize(param1:Number) : Number
      {
         return AssetStorage.font.templateBaseline * param1 / AssetStorage.font.templateSize;
      }
   }
}
