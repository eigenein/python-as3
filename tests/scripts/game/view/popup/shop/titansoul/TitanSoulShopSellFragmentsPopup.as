package game.view.popup.shop.titansoul
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopSellFragmentsPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.shop.soul.SoulShopSellFragmentsPopupClip;
   
   public class TitanSoulShopSellFragmentsPopup extends ClipBasedPopup
   {
       
      
      private var clip:SoulShopSellFragmentsPopupClip;
      
      private var mediator:TitanSoulShopSellFragmentsPopupMediator;
      
      public function TitanSoulShopSellFragmentsPopup(param1:TitanSoulShopSellFragmentsPopupMediator)
      {
         this.mediator = param1;
         super(param1);
      }
      
      override public function dispose() : void
      {
         mediator.signal_update.remove(handler_updateList);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(mediator.notEnoughCoins)
         {
            clip = AssetStorage.rsx.popup_theme.create_popup_soulshop_sell_fragments_not_enough();
         }
         else
         {
            clip = AssetStorage.rsx.popup_theme.create_popup_soulshop_sell_fragments();
         }
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_ok.initialize(Translate.translate("UI_DIALOG_SOULSHOP_SELL_FRAGMENTS_EXCHANGE"),mediator.action_sell);
         clip.tf_title.text = Translate.translate("UI_DIALOG_TITAN_SOULSHOP_SELL_FRAGMENTS_DESCRIPTION");
         clip.tf_reward_label.text = Translate.translate("UI_DIALOG_SPECIAL_SHOP_TF_LABEL_YOU_GET");
         if(clip.tf_not_enough)
         {
            clip.tf_not_enough.text = Translate.translate("UI_DIALOG_TITAN_SOULSHOP_NOT_ENOUGH_COINS");
         }
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.horizontalAlign = "center";
         _loc1_.verticalAlign = "middle";
         _loc1_.padding = 5;
         _loc1_.gap = 5;
         clip.list.list.layout = _loc1_;
         handler_updateList();
         mediator.signal_update.add(handler_updateList);
      }
      
      private function handler_updateList() : void
      {
         clip.list.list.dataProvider = new ListCollection(mediator.collection);
         var _loc1_:TiledRowsLayout = clip.list.list.layout as TiledRowsLayout;
         if(mediator.collection.length < 5)
         {
            _loc1_.requestedColumnCount = mediator.collection.length;
            clip.scrollbar.visible = false;
         }
         else
         {
            _loc1_.requestedColumnCount = 0;
            clip.scrollbar.visible = true;
         }
         clip.reward.data = mediator.reward;
      }
   }
}
