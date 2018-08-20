package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanItemForActivityPopupMediator;
   import game.view.popup.ClipBasedPopup;
   
   public class ClanItemForActivityPopup extends ClipBasedPopup
   {
       
      
      private var mediator:ClanItemForActivityPopupMediator;
      
      private const clip:ClanItemForActivityPopupClip = AssetStorage.rsx.popup_theme.create_dialog_clan_item_for_activity();
      
      public function ClanItemForActivityPopup(param1:ClanItemForActivityPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         mediator.signal_progressUpdated.remove(handler_selectionUpdated);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         addChild(clip.graphics);
         clip.button_close.signal_click.add(mediator.close);
         clip.button_confirm.initialize(Translate.translate("UI_DIALOG_CLAN_ITEM_FOR_ACTIVITY_EXCHANGE"),mediator.action_confirm);
         clip.tf_label_header.text = Translate.translate("UI_DIALOG_CLAN_ITEM_FOR_ACTIVITY_HEADER");
         clip.tf_label_disclaimer.text = Translate.translate("UI_DIALOG_CLAN_ITEM_FOR_ACTIVITY_DISCLAIMER");
         clip.tf_label_cap.text = Translate.translate("UI_DIALOG_CLAN_ITEM_FOR_ACTIVITY_CAP");
         clip.inventory_item_list.list.dataProvider = mediator.inventoryItemListDataProvider;
         mediator.signal_progressUpdated.add(handler_selectionUpdated);
         handler_selectionUpdated();
      }
      
      private function handler_selectionUpdated() : void
      {
         var _loc1_:int = mediator.selectedValue;
         clip.tf_value_cap.text = mediator.todayAlready + "/" + mediator.dailyCap;
         if(_loc1_ > 0)
         {
            clip.tf_value.text = "+" + _loc1_ + (!!mediator.canIncrease?"":" " + Translate.translate("UI_DIALOG_RUNES_LEVEL_MAX"));
         }
         else if(mediator.canIncrease)
         {
            clip.tf_value.text = "0";
            clip.icon_activity.graphics.visible = true;
         }
         else
         {
            clip.tf_value.text = Translate.translate("UI_DIALOG_CLAN_ITEM_FOR_ACTIVITY_MAX");
            clip.icon_activity.graphics.visible = false;
         }
         clip.button_confirm.isEnabled = _loc1_ > 0;
         clip.button_confirm.graphics.alpha = _loc1_ > 0?1:0.5;
      }
   }
}
