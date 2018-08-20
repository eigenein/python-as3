package game.mechanics.clan_war.popup.members
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mechanics.clan_war.model.ClanWarMemberFullInfoValueObject;
   import game.mechanics.clan_war.popup.ClanWarSlotClip;
   import game.mechanics.clan_war.popup.plan.selectdefender.ClanWarDefenderTooltipView;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class ActiveClanWarMemberItemRenderer extends ListItemRenderer
   {
       
      
      private var memberData:ClanWarMemberFullInfoValueObject;
      
      protected var clip:ActiveClanWarMemberItemRendererClip;
      
      public function ActiveClanWarMemberItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(clip)
         {
            TooltipHelper.removeTooltip(clip.layout_heroes);
            TooltipHelper.removeTooltip(clip.layout_titans);
         }
         if(memberData)
         {
            memberData.tries.unsubscribe(handler_tries);
         }
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         super.commitData();
         if(memberData)
         {
            memberData.tries.unsubscribe(handler_tries);
         }
         memberData = data as ClanWarMemberFullInfoValueObject;
         if(memberData)
         {
            clip.nickname_tf.text = memberData.user.nickname;
            memberData.tries.onValue(handler_tries);
            clip.portrait.setData(memberData.user);
            TooltipHelper.removeTooltip(clip.layout_heroes);
            TooltipHelper.removeTooltip(clip.layout_titans);
            clip.layout_heroes.removeChildren();
            clip.layout_titans.removeChildren();
            _loc1_ = AssetStorage.rsx.clan_war_map.create(ClanWarSlotClip,"hero_square");
            clip.layout_heroes.addChild(_loc1_.graphics);
            clip.layout_heroes.addChild(clip.heroes_tf);
            clip.layout_heroes.addChild(clip.heroes_power_icon.graphics);
            clip.layout_heroes.addChild(clip.heroes_power_tf);
            _loc3_ = AssetStorage.rsx.clan_war_map.create(ClanWarSlotClip,"titan_square");
            clip.layout_titans.addChild(_loc3_.graphics);
            clip.layout_titans.addChild(clip.titans_tf);
            clip.layout_titans.addChild(clip.titans_power_icon.graphics);
            clip.layout_titans.addChild(clip.titans_power_tf);
            if(memberData.defenderHeroes && memberData.defenderHeroes.team && memberData.defenderHeroes.team.length > 0)
            {
               clip.heroes_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_HEROES");
               clip.heroes_power_tf.text = memberData.defenderHeroes.teamPower.toString();
               _loc1_.setState(ClanWarSlotState.READY);
               _loc2_ = new TooltipVO(ClanWarDefenderTooltipView,memberData.defenderHeroes,"TooltipVO.HINT_BEHAVIOR_MOVING");
               TooltipHelper.addTooltip(clip.layout_heroes,_loc2_);
            }
            else
            {
               clip.heroes_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_HEROES");
               clip.heroes_power_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_NO_COMMAND");
               clip.layout_heroes.removeChild(clip.heroes_power_icon.graphics);
               _loc1_.setState(ClanWarSlotState.EMPTY);
               _loc2_ = new TooltipVO(TooltipTextView,Translate.translate("UI_CLAN_WAR_MEMBERS_EMPTY_SLOT"));
               TooltipHelper.addTooltip(clip.layout_heroes,_loc2_);
            }
            if(memberData.defenderTitans && memberData.defenderTitans.team && memberData.defenderTitans.team.length > 0)
            {
               clip.titans_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_TITANS");
               clip.titans_power_tf.text = memberData.defenderTitans.teamPower.toString();
               _loc3_.setState(ClanWarSlotState.READY);
               _loc2_ = new TooltipVO(ClanWarDefenderTooltipView,memberData.defenderTitans,"TooltipVO.HINT_BEHAVIOR_MOVING");
               TooltipHelper.addTooltip(clip.layout_titans,_loc2_);
            }
            else
            {
               clip.titans_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_TITANS");
               clip.titans_power_tf.text = Translate.translate("UI_CLAN_WAR_MEMBERS_NO_COMMAND");
               clip.layout_titans.removeChild(clip.titans_power_icon.graphics);
               _loc3_.setState(ClanWarSlotState.EMPTY);
               _loc2_ = new TooltipVO(TooltipTextView,Translate.translate("UI_CLAN_WAR_MEMBERS_EMPTY_SLOT"));
               TooltipHelper.addTooltip(clip.layout_titans,_loc2_);
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ActiveClanWarMemberItemRendererClip,"active_clan_war_member_renderer");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
      
      private function handler_tries(param1:int) : void
      {
         if(memberData == null || clip == null)
         {
            return;
         }
         clip.attempts_tf.text = param1 + "/" + memberData.triesMax;
      }
   }
}
