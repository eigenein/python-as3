package game.view.popup.clan
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.clan.ClanActivityRewardPopupMediator;
   import game.view.popup.ClipBasedPopup;
   import game.view.popup.IEscClosable;
   import starling.events.Event;
   
   public class ClanActivityRewardPopup extends ClipBasedPopup implements IEscClosable
   {
       
      
      private var mediator:ClanActivityRewardPopupMediator;
      
      private var clip:ClanActivityRewardPopupClip;
      
      public function ClanActivityRewardPopup(param1:ClanActivityRewardPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         if(mediator.hasClan)
         {
            mediator.personalPoints.unsubscribe(handler_personalPoints);
            mediator.guildPoints.unsubscribe(handler_guildPoints);
            mediator.property_giftsRedMark.signal_update.remove(handler_redMarkUpdate);
         }
         removeEventListener("addedToStage",handler_addedToStage);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanActivityRewardPopupClip,"dialog_clan_rewards");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.tf_header.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_HEADER");
         clip.tf_label_personal_points.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_PERSONAL_POINTS");
         clip.tf_label_guild_points.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_GUILD_POINTS");
         clip.tf_footer.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_FOOTER");
         clip.tf__label_points.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF__LABEL_POINTS");
         clip.tf_label_item_exchange.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_ITEM_EXCHANGE");
         clip.tf_label_campaign.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_CAMPAIGN");
         clip.tf_label_reward.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_REWARD");
         clip.tf_label_get_points.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_GET_POINTS");
         clip.tf_label_forge.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_FORGE");
         clip.tf_label_points_per_quest.text = Translate.translate("UI_DIALOG_CLAN_REWARDS_TF_LABEL_POINTS_PER_QUEST");
         clip.button_forge.label = Translate.translate("UI_DIALOG_CLAN_REWARDS_LABEL_FORGE_GO");
         clip.button_item_exchange.label = Translate.translate("UI_DIALOG_CLAN_REWARDS_LABEL_EXCHANGE_GO");
         clip.button_campaign.label = Translate.translate("UI_DIALOG_CLAN_REWARDS_LABEL_CAMPAIGN_GO");
         clip.tf_points_per_quest.text = "+" + String(mediator.pointsPerQuest);
         clip.button_close.signal_click.add(close);
         clip.button_forge.signal_click.add(mediator.action_forge);
         clip.button_item_exchange.signal_click.add(mediator.action_itemExchange);
         clip.button_campaign.signal_click.add(mediator.action_campaign);
         var _loc1_:int = clip.clan_reward_renderer.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            clip.clan_reward_renderer[_loc2_].setData(mediator.rewardList[_loc2_],mediator.guildPoints.value >= mediator.rewardList[_loc2_].activityPoints);
            _loc2_++;
         }
         if(mediator.hasClan)
         {
            mediator.personalPoints.onValue(handler_personalPoints);
            mediator.guildPoints.onValue(handler_guildPoints);
            mediator.activityForRuneAvailable.onValue(handler_activityForRuneAvailable);
         }
         mediator.signal_resetTimeUpdate.add(handler_updateTime);
         updateResetTime();
         clip.button_gifts.signal_click.add(mediator.action_gifts);
         clip.button_gifts.label = Translate.translate("UI_DIALOG_CLAN_REWARDS_GIFTS_BUTTON");
         mediator.property_giftsRedMark.signal_update.add(handler_redMarkUpdate);
         handler_redMarkUpdate();
         clip.icon_new.graphics.touchable = false;
         addEventListener("addedToStage",handler_addedToStage);
         mediator.action_addedToStage();
      }
      
      private function updateResetTime() : void
      {
         clip.tf_reset.text = Translate.translateArgs("UI_DIALOG_CLAN_REWARDS_TF_RESET",mediator.timeLeft);
      }
      
      private function handler_updateTime() : void
      {
         updateResetTime();
      }
      
      private function handler_personalPoints(param1:int) : void
      {
         clip.tf_personal_points.text = String(param1);
      }
      
      private function handler_activityForRuneAvailable(param1:Boolean) : void
      {
         var _loc2_:* = !param1;
         clip.layout_forge_points.y = !!_loc2_?323:Number(318);
         clip.button_forge.graphics.visible = !_loc2_;
         clip.tf_label_points_per_quest.visible = _loc2_;
         clip.icon_forge_check.graphics.visible = _loc2_;
         var _loc3_:* = !!_loc2_?0.5:1;
         clip.icon_forge_check.graphics.alpha = _loc3_;
         _loc3_ = _loc3_;
         clip.tf_label_points_per_quest.alpha = _loc3_;
         _loc3_ = _loc3_;
         clip.layout_forge_points.alpha = _loc3_;
         clip.tf_label_forge.alpha = _loc3_;
      }
      
      private function handler_guildPoints(param1:int) : void
      {
         var _loc3_:int = 0;
         clip.tf_guild_points.text = String(param1);
         var _loc2_:int = clip.clan_reward_renderer.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            clip.clan_reward_renderer[_loc3_].setCheck(param1 >= mediator.rewardList[_loc3_].activityPoints);
            _loc3_++;
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         mediator.action_addedToStage();
      }
      
      private function handler_redMarkUpdate(param1:Boolean = false) : void
      {
         clip.icon_new.graphics.visible = mediator.property_giftsRedMark.value;
      }
   }
}
