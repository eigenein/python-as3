package game.view.popup.ny.notenoughcoin
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.data.storage.rule.ny2018tree.NY2018TreeDecorateAction;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   
   public class NotEnoughNYGiftCoinPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:NotEnoughNYGiftCoinPopupMediator;
      
      private var clip:NotEnoughNYGiftCoinPopupClip;
      
      public function NotEnoughNYGiftCoinPopup(param1:NotEnoughNYGiftCoinPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         param1.signal_nyTreeCoinUpdate.add(handler_nyTreeCoinUpdate);
      }
      
      override public function dispose() : void
      {
         mediator.signal_nyTreeCoinUpdate.remove(handler_nyTreeCoinUpdate);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.ny_gifts.create(NotEnoughNYGiftCoinPopupClip,"dialog_not_enough_ny_gift_coin");
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_title.text = Translate.translate("UI_POPUP_MESSAGE_NOTENOUGH_COIN_" + mediator.nyGiftCoin.id);
         clip.decorate_renderer_1.setData(mediator.decorateActions[0]);
         clip.decorate_renderer_1.multiplier = mediator.decorateMultiplierNYTreeCoin;
         clip.decorate_renderer_2.setData(mediator.decorateActions[1]);
         clip.decorate_renderer_3.setData(mediator.decorateActions[2]);
         clip.decorate_renderer_1.signal_decorate.add(handler_decorate);
         clip.decorate_renderer_2.signal_decorate.add(handler_decorate);
         clip.decorate_renderer_3.signal_decorate.add(handler_firewoks);
      }
      
      private function updateDecorateRenderers() : void
      {
         clip.decorate_renderer_1.multiplier = mediator.decorateMultiplierNYTreeCoin;
      }
      
      private function handler_nyTreeCoinUpdate() : void
      {
         updateDecorateRenderers();
      }
      
      private function handler_decorate(param1:NY2018TreeDecorateAction, param2:int) : void
      {
         mediator.action_decorateNYTree(param1,param2);
      }
      
      private function handler_firewoks(param1:NY2018TreeDecorateAction, param2:int) : void
      {
         mediator.action_fireworks();
      }
   }
}
