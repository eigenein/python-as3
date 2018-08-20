package game.mechanics.clan_war.popup.log
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.log.ClanWarLogItem;
   import game.mechanics.clan_war.mediator.log.ClanWarLogValueObject;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ClanWarLogItemRenderer extends ListItemRenderer
   {
       
      
      private var ___data:ClanWarLogValueObject;
      
      private var clip_content:ClanWarLogItemContentClip;
      
      private var clip_header:ClanWarLogItemHeaderClip;
      
      private var clip_footer:ClanWarLogItemFooterClip;
      
      public function ClanWarLogItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(clip_content && !clip_content.graphics.parent)
         {
            clip_content.graphics.dispose();
         }
         if(clip_header && !clip_header.graphics.parent)
         {
            clip_header.graphics.dispose();
         }
         if(clip_footer && !clip_footer.graphics.parent)
         {
            clip_footer.graphics.dispose();
         }
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         var _loc1_:ClanWarLogValueObject = data as ClanWarLogValueObject;
         if(_loc1_)
         {
            ___data = _loc1_;
            removeChildren();
            if(_loc1_.type == 1)
            {
               setContent();
            }
            else if(_loc1_.type == 0)
            {
               setHeader();
            }
            else if(_loc1_.type == 2)
            {
               setFooter();
            }
         }
      }
      
      protected function setContent() : void
      {
         if(!clip_content)
         {
            clip_content = AssetStorage.rsx.clan_war_map.create(ClanWarLogItemContentClip,"clan_war_log_war_item");
            clip_content.tf_current.text = Translate.translate("UI_CLAN_WAR_LOG_CURRENT_WAR");
            clip_content.tf_attack_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_VICTORY");
            clip_content.tf_attack_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DEFEAT");
            clip_content.tf_draw.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DRAW");
            clip_content.button_select.label = Translate.translate("UI_DIALOG_GRAND_LOG_DETAILS");
            clip_content.button_select.signal_click.add(handler_select);
            clip_content.enemies.attacker_info.button_list.signal_click.add(handler_openMemberList_attacker);
            clip_content.enemies.defender_info.button_list.signal_click.add(handler_openMemberList_defender);
         }
         addChild(clip_content.graphics);
         var _loc2_:ClanWarLogItem = ___data.item;
         clip_content.enemies.attacker_info.setData(_loc2_.attacker);
         clip_content.enemies.defender_info.setData(_loc2_.defender);
         var _loc1_:Boolean = _loc2_.isCurrent;
         clip_content.tf_current.visible = _loc1_;
         clip_content.enemies.attacker_info.button_list.graphics.visible = _loc1_;
         clip_content.enemies.defender_info.button_list.graphics.visible = _loc1_;
         clip_content.tf_attack_victory.visible = _loc2_.isVictory;
         clip_content.tf_attack_defeat.visible = _loc2_.isDefeat;
         clip_content.tf_draw.visible = _loc2_.isDraw;
         clip_content.tf_date.text = _loc2_.dateString;
         clip_content.tf_day.text = _loc2_.dayString;
         height = clip_content.size.layoutGroup.height;
      }
      
      protected function setHeader() : void
      {
         if(!clip_header)
         {
            clip_header = AssetStorage.rsx.clan_war_map.create(ClanWarLogItemHeaderClip,"clan_war_log_war_item_header");
         }
         addChild(clip_header.graphics);
         clip_header.tf_label.text = Translate.translateArgs("UI_CLAN_WAR_LOG_LEAGUE_SEASON",___data.item.league.name,___data.item.seasonNum);
         height = clip_header.size.layoutGroup.height;
      }
      
      protected function setFooter() : void
      {
         if(!clip_footer)
         {
            clip_footer = AssetStorage.rsx.clan_war_map.create(ClanWarLogItemFooterClip,"clan_war_log_war_item_footer");
            clip_footer.tf_result.text = Translate.translate("UI_CLAN_WAR_LOG_LEAGUE_SEASON_RESULT");
         }
         addChild(clip_footer.graphics);
         clip_footer.tf_points.text = String(___data.seasonEnd.seasonPointsSum);
         var _loc1_:int = ___data.seasonEnd.position;
         clip_footer.tf_place.visible = _loc1_ > 0;
         clip_footer.tf_place.text = Translate.translateArgs("UI_CLAN_WAR_LOG_LEAGUE_SEASON_PLACE",_loc1_);
         clip_footer.setChild(clip_footer.tf_decider,___data.seasonEnd.hasDecider);
         if(___data.seasonEnd.hasDecider)
         {
            clip_footer.tf_decider.text = !!___data.seasonEnd.promotionDecider?Translate.translate("UI_CLAN_WAR_LOG_DECIDER"):Translate.translate("UI_CLAN_WAR_LOG_DECIDER_DOWN");
         }
         height = clip_footer.size.layoutGroup.height;
      }
      
      private function handler_select() : void
      {
         if(___data)
         {
            ___data.action_select();
         }
      }
      
      private function handler_openMemberList_attacker() : void
      {
         if(___data)
         {
            ___data.action_openMemberList_attacker();
         }
      }
      
      private function handler_openMemberList_defender() : void
      {
         if(___data)
         {
            ___data.action_openMemberList_defender();
         }
      }
   }
}
