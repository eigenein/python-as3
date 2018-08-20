package game.view.popup.mail
{
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   
   public class PlayerMailMultifarmPopup extends ClipBasedPopup
   {
       
      
      private var reward:Vector.<InventoryItem>;
      
      public function PlayerMailMultifarmPopup(param1:Vector.<InventoryItem>)
      {
         super(null);
         this.reward = param1;
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         var _loc3_:PlayerMailMultifarmPopupClip = AssetStorage.rsx.popup_theme.create_popup_mail_multifarm();
         addChild(_loc3_.graphics);
         width = _loc3_.bg.graphics.width;
         height = _loc3_.bg.graphics.height;
         var _loc1_:int = _loc3_.reward_items.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(reward.length > _loc2_)
            {
               _loc3_.reward_items[_loc2_].data = reward[_loc2_];
            }
            else
            {
               _loc3_.reward_items[_loc2_].graphics.visible = false;
            }
            _loc2_++;
         }
         _loc3_.button_farm_all.signal_click.add(close);
      }
   }
}
