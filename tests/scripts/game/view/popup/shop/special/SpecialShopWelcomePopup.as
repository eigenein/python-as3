package game.view.popup.shop.special
{
   import engine.core.clipgui.ClipSprite;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.model.user.shop.SpecialShopMerchant;
   import game.view.popup.ClipBasedPopup;
   
   public class SpecialShopWelcomePopup extends ClipBasedPopup
   {
       
      
      public function SpecialShopWelcomePopup(param1:PopupMediator)
      {
         super(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc2_:SpecialShopWelcomePopupClip = AssetStorage.rsx.popup_theme.create(SpecialShopWelcomePopupClip,"dialog_special_shop_welcome");
         addChild(_loc2_.graphics);
         width = _loc2_.girl_container.width;
         height = _loc2_.button_promote.graphics.y + _loc2_.button_promote.graphics.height;
         _loc2_.girl_container.clipContent = true;
         var _loc1_:ClipSprite = AssetStorage.rsx.asset_bundle.create(ClipSprite,"vendor_girl");
         _loc2_.vendor_container.container.addChild(_loc1_.graphics);
         _loc2_.button_promote.signal_click.add(handler_click);
      }
      
      private function handler_click() : void
      {
         var _loc2_:* = null;
         close();
         var _loc1_:SpecialShopMerchant = GameModel.instance.player.specialShop.model.getAvailableMerchant();
         if(_loc1_ != null)
         {
            _loc2_ = new SpecialShopPopupMediator(_loc1_);
            _loc2_.open();
         }
      }
   }
}
