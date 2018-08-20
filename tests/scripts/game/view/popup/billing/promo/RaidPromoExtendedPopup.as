package game.view.popup.billing.promo
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.billing.bundle.RaidPromoPopupMediator;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class RaidPromoExtendedPopup extends ClipBasedPopup
   {
       
      
      private var clip:RaidPromoExtendedPopupClip;
      
      private var mediator:RaidPromoPopupMediator;
      
      public function RaidPromoExtendedPopup(param1:RaidPromoPopupMediator)
      {
         super(param1);
         this.mediator = param1;
         stashParams.windowName = "raid_promo_extended_popup";
      }
      
      override protected function initialize() : void
      {
         var _loc3_:* = 0;
         var _loc2_:* = null;
         super.initialize();
         clip = AssetStorage.rsx.asset_bundle.create(RaidPromoExtendedPopupClip,"raid_promo_extended_popup");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_header.text = Translate.translate("UI_DIALOG_RAID_PROMO_EXTENDED_TITLE");
         clip.tf_label_desc.text = Translate.translateArgs("UI_DIALOG_RAID_PROMO_EXTENDED_TEXT",ColorUtils.hexToRGBFormat(15919178));
         clip.tf_raid.text = Translate.translate("UI_DIALOG_RAID_PROMO_EXTENDED_RAID");
         clip.tf_unlock_raids.text = Translate.translate("UI_DIALOG_RAID_PROMO_EXTENDED_UNLOCK_RAIDS");
         clip.tf_best_value.text = Translate.translate("UI_DIALOG_RAID_PROMO_EXTENDED_BEST_VALUE");
         clip.action_btn.label = Translate.translateArgs("UI_DIALOG_RAID_PROMO_EXTENDED_COST_TEXT",mediator.costString);
         clip.layout_group.removeChildren();
         var _loc1_:Vector.<InventoryItem> = mediator.rewardList;
         _loc3_ = uint(0);
         while(_loc3_ < int(Math.min(3,_loc1_.length)))
         {
            _loc2_ = AssetStorage.rsx.popup_theme.create(InventoryItemRenderer,"inventory_tile");
            _loc2_.setData(_loc1_[_loc3_]);
            clip.layout_group.addChild(_loc2_.graphics);
            _loc3_++;
         }
         clip.action_btn.signal_click.add(mediator.action_buy);
      }
   }
}
