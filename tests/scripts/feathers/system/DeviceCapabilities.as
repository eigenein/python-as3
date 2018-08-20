package feathers.system
{
   import flash.display.Stage;
   import flash.system.Capabilities;
   
   public class DeviceCapabilities
   {
      
      public static var tabletScreenMinimumInches:Number = 5;
      
      public static var screenPixelWidth:Number = NaN;
      
      public static var screenPixelHeight:Number = NaN;
      
      public static var dpi:int = Capabilities.screenDPI;
       
      
      public function DeviceCapabilities()
      {
         super();
      }
      
      public static function isTablet(param1:Stage) : Boolean
      {
         var _loc2_:* = Number(screenPixelWidth);
         if(_loc2_ !== _loc2_)
         {
            _loc2_ = Number(param1.fullScreenWidth);
         }
         var _loc3_:Number = screenPixelHeight;
         if(_loc3_ !== _loc3_)
         {
            _loc3_ = param1.fullScreenHeight;
         }
         if(_loc2_ < _loc3_)
         {
            _loc2_ = _loc3_;
         }
         return _loc2_ / dpi >= tabletScreenMinimumInches;
      }
      
      public static function isPhone(param1:Stage) : Boolean
      {
         return !isTablet(param1);
      }
      
      public static function screenInchesX(param1:Stage) : Number
      {
         var _loc2_:Number = screenPixelWidth;
         if(_loc2_ !== _loc2_)
         {
            _loc2_ = param1.fullScreenWidth;
         }
         return _loc2_ / dpi;
      }
      
      public static function screenInchesY(param1:Stage) : Number
      {
         var _loc2_:Number = screenPixelHeight;
         if(_loc2_ !== _loc2_)
         {
            _loc2_ = param1.fullScreenHeight;
         }
         return _loc2_ / dpi;
      }
   }
}
