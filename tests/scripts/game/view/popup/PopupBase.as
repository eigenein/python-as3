package game.view.popup
{
   import avmplus.getQualifiedClassName;
   import feathers.controls.LayoutGroup;
   import feathers.core.PopUpManager;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalLayout;
   import game.mediator.gui.popup.GamePopupManager;
   import game.mediator.gui.popup.PopupStashEventParams;
   
   public class PopupBase extends LayoutGroup implements IEscClosable
   {
       
      
      public var stashParams:PopupStashEventParams;
      
      public var stashSourceClick:PopupStashEventParams;
      
      public function PopupBase()
      {
         super();
         stash_createParams();
      }
      
      public function open() : void
      {
         PopUpManager.addPopUp(this);
      }
      
      public function openDelayed(param1:int = 1000) : void
      {
         GamePopupManager.queuePopup(this,param1);
      }
      
      public function close() : void
      {
         PopUpManager.removePopUp(this,true);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         .super.clipContent = false;
      }
      
      protected function horizontal(param1:Number, ... rest) : LayoutGroup
      {
         var _loc5_:int = 0;
         var _loc3_:LayoutGroup = new LayoutGroup();
         var _loc6_:HorizontalLayout = new HorizontalLayout();
         _loc6_.gap = param1;
         _loc3_.layout = _loc6_;
         var _loc4_:int = rest.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_.addChild(rest[_loc5_]);
            _loc5_++;
         }
         return _loc3_;
      }
      
      protected function vertical(param1:Number, ... rest) : LayoutGroup
      {
         var _loc5_:int = 0;
         var _loc3_:LayoutGroup = new LayoutGroup();
         var _loc6_:VerticalLayout = new VerticalLayout();
         _loc6_.gap = param1;
         _loc3_.layout = _loc6_;
         var _loc4_:int = rest.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_.addChild(rest[_loc5_]);
            _loc5_++;
         }
         return _loc3_;
      }
      
      protected function hcenter(param1:LayoutGroup) : LayoutGroup
      {
         if(param1.layout is VerticalLayout)
         {
            (param1.layout as VerticalLayout).horizontalAlign = "center";
         }
         else
         {
            (param1.layout as HorizontalLayout).horizontalAlign = "center";
         }
         return param1;
      }
      
      protected function vcenter(param1:LayoutGroup) : LayoutGroup
      {
         if(param1.layout is VerticalLayout)
         {
            (param1.layout as VerticalLayout).verticalAlign = "middle";
         }
         else
         {
            (param1.layout as HorizontalLayout).verticalAlign = "middle";
         }
         return param1;
      }
      
      protected function stash_createParams() : void
      {
         var _loc1_:PopupStashEventParams = new PopupStashEventParams();
         _loc1_.actionType = "open";
         _loc1_.windowName = getQualifiedClassName(this);
         stashParams = _loc1_;
      }
   }
}
