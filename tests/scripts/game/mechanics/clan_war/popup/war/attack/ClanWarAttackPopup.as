package game.mechanics.clan_war.popup.war.attack
{
   import com.progrestar.common.lang.Translate;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.clan_war.mediator.ClanWarAttackPopupMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.tooltip.TooltipTextView;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   
   public class ClanWarAttackPopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var clip:ClanWarAttackPopupClip;
      
      private var mediator:ClanWarAttackPopupMediator;
      
      public function ClanWarAttackPopup(param1:ClanWarAttackPopupMediator)
      {
         super(param1,AssetStorage.rsx.clan_war_map);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         mediator.tries_personal.signal_update.remove(handler_triesUpdate);
         mediator.points_sum.signal_update.remove(handler_updatePointsSum);
         if(clip)
         {
            TooltipHelper.removeTooltip(clip.vp_bg.graphics);
         }
         super.dispose();
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         super.onAssetLoaded(param1);
         clip = param1.create(ClanWarAttackPopupClip,"popup_building_selected_attack");
         addChild(clip.graphics);
         clip.tf_header.text = mediator.text_header;
         clip.tf_desc.text = mediator.text_desc;
         clip.tf_label_bonus.text = Translate.translate("UI_POPUP_BUILDING_SELECTED_ATTACK_TF_LABEL_BONUS");
         clip.list.itemRendererType = ClanWarAttackListItemRenderer;
         clip.list.addDataListener("ListItemRenderer.EVENT_SELECT",mediator.action_select);
         clip.list.dataProvider = mediator.defenderListData;
         clip.button_close.signal_click.add(close);
         clip.list.layout = new VerticalLayout();
         (clip.list.layout as VerticalLayout).gap = 10;
         var _loc3_:* = 10;
         (clip.list.layout as VerticalLayout).paddingBottom = _loc3_;
         (clip.list.layout as VerticalLayout).paddingTop = _loc3_;
         mediator.tries_personal.signal_update.add(handler_triesUpdate);
         handler_triesUpdate(0);
         clip.tf_points.text = "+" + mediator.victoryPoints;
         _loc3_ = false;
         clip.icon_VP.graphics.touchable = _loc3_;
         clip.tf_points.touchable = _loc3_;
         var _loc2_:TooltipVO = new TooltipVO(TooltipTextView,mediator.victoryPointsTooltip);
         TooltipHelper.addTooltip(clip.vp_bg.graphics,_loc2_);
         clip.tf_label_total_points.text = Translate.translate("UI_POPUP_BUILDING_SELECTED_ATTACK_TF_LABEL_TOTAL_POINTS");
         mediator.points_sum.signal_update.add(handler_updatePointsSum);
         handler_updatePointsSum(0);
         clip.tf_tries.height = NaN;
         if(mediator.isTierLocked)
         {
            clip.tf_tries.text = mediator.tierLockedMessage;
            clip.playback.gotoAndStop(1);
            clip.layout_victory_points_bonus.visible = false;
         }
         else
         {
            clip.layout_victory_points_bonus.visible = true;
            clip.playback.gotoAndStop(0);
         }
      }
      
      private function handler_triesUpdate(param1:int) : void
      {
         if(!mediator.isTierLocked)
         {
            clip.tf_tries.text = Translate.translateArgs("UI_CLAN_WAR_ATTACK_BLOCK_TF_TRIES",mediator.tries_personal.value);
            if(mediator.showClanTries)
            {
               clip.tf_tries.text = clip.tf_tries.text + ("\n" + Translate.translateArgs("UI_CLAN_WAR_ATTACK_BLOCK_TF_TRIES_CLAN",mediator.tries_clan.value));
            }
         }
      }
      
      private function handler_updatePointsSum(param1:int) : void
      {
         clip.tf_points_total.text = "+" + mediator.points_sum.value;
      }
   }
}
