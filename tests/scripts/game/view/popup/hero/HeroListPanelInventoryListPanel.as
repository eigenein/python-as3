package game.view.popup.hero
{
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.hero.slot.HeroInventorySlotValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   import starling.display.Image;
   
   public class HeroListPanelInventoryListPanel extends ListItemRenderer
   {
       
      
      private var bg:Image;
      
      private var plus:Image;
      
      private var plus_yellow:Image;
      
      private var icon:Image;
      
      private var _vo:HeroInventorySlotValueObject;
      
      public function HeroListPanelInventoryListPanel()
      {
         super();
      }
      
      override public function dispose() : void
      {
         data = null;
         super.dispose();
      }
      
      public function get vo() : HeroInventorySlotValueObject
      {
         return _vo;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         bg = new Image(AssetStorage.rsx.popup_theme.getTexture("catalogGearEmptySlot"));
         addChild(bg);
         icon = new Image(AssetStorage.rsx.missing);
         addChild(icon);
         var _loc1_:* = bg.width - 2;
         icon.height = _loc1_;
         icon.width = _loc1_;
         _loc1_ = 1;
         icon.y = _loc1_;
         icon.x = _loc1_;
         plus = new Image(AssetStorage.rsx.popup_theme.getTexture("GreenPlusIcon"));
         addChild(plus);
         plus_yellow = new Image(AssetStorage.rsx.popup_theme.getTexture("YellowPlusIcon"));
         addChild(plus_yellow);
         _loc1_ = 2;
         plus.x = _loc1_;
         plus_yellow.x = _loc1_;
         _loc1_ = 3;
         plus.y = _loc1_;
         plus_yellow.y = _loc1_;
      }
      
      override protected function commitData() : void
      {
         var _loc1_:* = false;
         super.commitData();
         if(vo)
         {
            _loc1_ = vo.slotState == 2;
            if(_loc1_)
            {
               bg.texture = AssetStorage.rsx.popup_theme.getTexture("catalogGearEmptySlotFrame");
            }
            else
            {
               bg.texture = AssetStorage.rsx.popup_theme.getTexture("catalogGearEmptySlot");
            }
            icon.visible = _loc1_;
            if(icon.visible)
            {
               icon.texture = vo.icon;
            }
            plus.visible = vo.slotState == 1 || vo.slotState == 4;
            plus_yellow.visible = vo.slotState == 5;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:HeroInventorySlotValueObject = data as HeroInventorySlotValueObject;
         if(_loc2_)
         {
            _loc2_.signal_updateSlotState.remove(listener_slotStateUpdate);
         }
         _vo = param1 as HeroInventorySlotValueObject;
         if(_vo)
         {
            _vo.signal_updateSlotState.add(listener_slotStateUpdate);
         }
         .super.data = param1;
      }
      
      private function listener_slotFillable() : void
      {
         commitData();
      }
      
      private function listener_slotStateUpdate() : void
      {
         commitData();
      }
   }
}
