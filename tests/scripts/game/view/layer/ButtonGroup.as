package game.view.layer
{
   import feathers.controls.Button;
   import feathers.controls.LayoutGroup;
   import feathers.layout.VerticalLayout;
   import flash.utils.Dictionary;
   import game.view.gui.components.GameButton;
   import idv.cjcat.signals.Signal;
   import starling.display.DisplayObject;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class ButtonGroup extends LayoutGroup
   {
       
      
      private var group:LayoutGroup;
      
      public const buttonSignal:Signal = new Signal(String);
      
      private var actions:Dictionary;
      
      public function ButtonGroup(param1:Dictionary)
      {
         super();
         this.actions = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         group = new LayoutGroup();
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.verticalAlign = "middle";
         _loc1_.horizontalAlign = "center";
         _loc1_.gap = 10;
         _loc1_.padding = 20;
         group.layout = _loc1_;
         this.addChild(group);
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = actions;
         for(var _loc3_ in actions)
         {
            _loc2_.push(_loc3_);
         }
         _loc2_.sort(sort_keys);
         var _loc7_:int = 0;
         var _loc6_:* = _loc2_;
         for each(_loc3_ in _loc2_)
         {
            createButton(_loc3_);
         }
      }
      
      private function sort_keys(param1:String, param2:String) : int
      {
         if(param1 > param2)
         {
            return 1;
         }
         if(param1 < param2)
         {
            return -1;
         }
         return 0;
      }
      
      private function createButton(param1:String) : void
      {
         var _loc2_:GameButton = GameButton.staticButton(param1,null);
         _loc2_.name = param1;
         group.addChild(_loc2_);
         _loc2_.width = 250;
         _loc2_.height = 30;
         _loc2_.addEventListener("touch",onTouch);
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.target as DisplayObject,"began");
         var _loc3_:Button = param1.target as Button;
         if(_loc2_ && _loc3_)
         {
            buttonSignal.dispatch(_loc3_.name);
         }
      }
   }
}
