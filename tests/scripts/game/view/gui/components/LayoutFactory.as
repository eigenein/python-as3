package game.view.gui.components
{
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalLayout;
   import starling.display.DisplayObject;
   
   public class LayoutFactory
   {
       
      
      public function LayoutFactory()
      {
         super();
      }
      
      public static function vertical(param1:Number, param2:Number = Infinity) : LayoutGroup
      {
         var _loc3_:LayoutGroup = new LayoutGroup();
         var _loc4_:VerticalLayout = new VerticalLayout();
         _loc4_.gap = param1;
         if(param2 != Infinity)
         {
            _loc4_.padding = param2;
         }
         _loc3_.layout = _loc4_;
         return _loc3_;
      }
      
      public static function horizontal(param1:Number, param2:Number = Infinity) : LayoutGroup
      {
         var _loc3_:LayoutGroup = new LayoutGroup();
         var _loc4_:HorizontalLayout = new HorizontalLayout();
         _loc4_.gap = param1;
         if(param2 != Infinity)
         {
            _loc4_.padding = param2;
         }
         _loc3_.layout = _loc4_;
         return _loc3_;
      }
      
      public static function spacer(param1:Number, param2:Number) : LayoutGroup
      {
         var _loc3_:LayoutGroup = new LayoutGroup();
         _loc3_.width = param1;
         _loc3_.height = param2;
         return _loc3_;
      }
      
      public static function horizontal_verticalAligned(param1:Number, param2:String) : LayoutGroup
      {
         var _loc3_:LayoutGroup = new LayoutGroup();
         var _loc4_:HorizontalLayout = new HorizontalLayout();
         _loc4_.gap = param1;
         _loc4_.verticalAlign = param2;
         _loc3_.layout = _loc4_;
         return _loc3_;
      }
      
      public static function wrapInPaddingsLayout(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0) : void
      {
         var _loc6_:VerticalLayout = new VerticalLayout();
         _loc6_.paddingTop = param2;
         _loc6_.paddingRight = param3;
         _loc6_.paddingBottom = param4;
         _loc6_.paddingLeft = param5;
         var _loc7_:LayoutGroup = new LayoutGroup();
         _loc7_.layout = _loc6_;
         if(param1.parent)
         {
            param1.parent.addChildAt(_loc7_,param1.parent.getChildIndex(param1));
            _loc7_.addChild(param1);
         }
      }
   }
}
