package game.view.popup.refillable
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.PopupList;
   import game.mediator.gui.popup.refillable.StaminaRefillPopupMediator;
   
   public class StaminaRefillPopup extends RefillPopupBase
   {
       
      
      private var _mediator:StaminaRefillPopupMediator;
      
      public function StaminaRefillPopup(param1:StaminaRefillPopupMediator)
      {
         super(param1);
         this._mediator = param1;
         stashParams.windowName = "refill_stamina";
         param1.signal_refillComplete.add(handler_purchaseMade);
      }
      
      override protected function createClip() : void
      {
         clip = AssetStorage.rsx.popup_theme.create(StaminaRefillPopupClip,"popup_energy_refill") as StaminaRefillPopupClip;
         addChild(clip.graphics);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:StaminaRefillPopupClip = clip as StaminaRefillPopupClip;
         _loc1_.use_energy_item_block.button_use.signal_click.add(_mediator.action_use);
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:StaminaRefillPopupClip = clip as StaminaRefillPopupClip;
         _loc1_.tf_energy.text = _mediator.refillAmount.toString() + "?";
         _loc1_.tf_label_buy.text = Translate.translate("U_POPUP_STAMINA_REFILL_BUY");
         _loc1_.use_energy_item_block.graphics.visible = Boolean(_mediator.staminaItem != null && _mediator.staminaItem.amount > 0);
         if(_loc1_.use_energy_item_block.graphics.visible)
         {
            _loc1_.use_energy_item_block.item.setData(_mediator.staminaItem);
            _loc1_.use_energy_item_block.tf_title.text = _mediator.staminaItem.name;
            _loc1_.use_energy_item_block.tf_energy.text = _mediator.staminaItemDesc.rewardAmount.toString();
            _loc1_.use_energy_item_block.button_use.label = Translate.translate("UI_DIALOG_INVENTORY_USE") + " " + 1;
            if(_loc1_.refill_block.graphics.visible)
            {
               _loc1_.use_energy_item_block.container.y = _loc1_.refill_block.graphics.y + _loc1_.refill_block.graphics.height + 20;
            }
            else
            {
               _loc1_.use_energy_item_block.container.y = _loc1_.button_buy.graphics.y + _loc1_.button_buy.graphics.height + 20;
            }
            _loc1_.bg.graphics.height = _loc1_.use_energy_item_block.graphics.y + _loc1_.use_energy_item_block.graphics.height + 20;
         }
         else if(_loc1_.refill_block.graphics.visible)
         {
            clip.bg.graphics.height = clip.refill_block.graphics.y + clip.refill_block.graphics.height + 20;
         }
         else
         {
            clip.bg.graphics.height = clip.button_buy.graphics.y + clip.button_buy.graphics.height + 22;
         }
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
      
      private function handler_purchaseMade() : void
      {
         if(!_mediator.refillPossibleToday)
         {
            close();
            PopupList.instance.message(Translate.translate("UI_POPUP_REFILL_IMPOSSIBLE"),"");
         }
         else
         {
            commitData();
         }
      }
   }
}
