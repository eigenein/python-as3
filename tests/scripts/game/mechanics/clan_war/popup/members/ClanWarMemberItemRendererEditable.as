package game.mechanics.clan_war.popup.members
{
   import com.progrestar.common.lang.Translate;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mechanics.clan_war.mediator.ClanWarSlotState;
   import game.mechanics.clan_war.model.ClanWarMemberFullInfoValueObject;
   import game.mechanics.clan_war.popup.ClanWarSlotClip;
   import game.mechanics.clan_war.popup.plan.selectdefender.ClanWarDefenderTooltipView;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.GameModel;
   import game.util.TimeFormatter;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import idv.cjcat.signals.Signal;
   
   public class ClanWarMemberItemRendererEditable extends ListItemRenderer
   {
       
      
      private var memberData:ClanWarMemberFullInfoValueObject;
      
      private var clip:ClanWarMemberItemRendererEditableClip;
      
      private var timeOutTimer:Timer;
      
      protected var _signal_updateSelectedState:Signal;
      
      public function ClanWarMemberItemRendererEditable()
      {
         _signal_updateSelectedState = new Signal(ClanWarMemberFullInfoValueObject,Boolean);
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
            memberData.signal_warriorStateUpdated.remove(handler_warriorStateUpdated);
            TooltipHelper.removeTooltip(clip.layout_timeout);
         }
         super.dispose();
      }
      
      public function get signal_updateSelectedState() : Signal
      {
         return _signal_updateSelectedState;
      }
      
      override protected function commitData() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc3_:* = null;
         super.commitData();
         if(memberData)
         {
            memberData.signal_warriorStateUpdated.remove(handler_warriorStateUpdated);
            TooltipHelper.removeTooltip(clip.layout_timeout);
         }
         memberData = data as ClanWarMemberFullInfoValueObject;
         if(memberData)
         {
            TooltipHelper.addTooltip(clip.layout_timeout,new TooltipVO(TooltipTextView,Translate.translateArgs("UI_CLAN_WAR_MEMBERS_TIMEOUT",memberData.user.nickname)));
            updateTimeOut();
            memberData.signal_warriorStateUpdated.add(handler_warriorStateUpdated);
            clip.nickname_tf.text = memberData.user.nickname;
            clip.portrait.setData(memberData.user);
            clip.check_box.isSelected = memberData.warrior;
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
         clip = AssetStorage.rsx.popup_theme.create(ClanWarMemberItemRendererEditableClip,"clan_war_member_renderer_editable");
         addChild(clip.graphics);
         clip.check_box.signal_click.add(handler_checkBoxUpdateState);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
      
      private function updateTimeOut() : void
      {
         if(timeOutTimer)
         {
            clearTimer();
         }
         var _loc1_:int = GameModel.instance.player.clan.clan.clanWarEndSeasonTime - GameTimer.instance.currentServerTime;
         if(memberData && memberData.user.wasChampion && _loc1_ > 0)
         {
            if(!timeOutTimer)
            {
               timeOutTimer = new Timer(1000,_loc1_);
            }
            timeOutTimer.addEventListener("timer",onTimeOutTimerTick);
            timeOutTimer.addEventListener("timerComplete",onTimeOutTimerComplete);
            timeOutTimer.start();
            updateTimeOutText(_loc1_);
         }
         clip.layout_timeout.visible = timeOutTimer && timeOutTimer.running;
         clip.check_box.graphics.visible = !clip.layout_timeout.visible;
      }
      
      protected function onTimeOutTimerComplete(param1:TimerEvent) : void
      {
         clearTimer();
         clip.layout_timeout.visible = false;
         clip.check_box.graphics.visible = true;
      }
      
      protected function onTimeOutTimerTick(param1:TimerEvent) : void
      {
      }
      
      private function updateTimeOutText(param1:int) : void
      {
         clip.timeout_tf.text = timeLeftString(param1);
      }
      
      private function timeLeftString(param1:int) : String
      {
         if(param1 <= 0)
         {
            param1 = 0;
         }
         if(param1 > 86400)
         {
            return TimeFormatter.toDH(param1,"{d} {h} {m}"," ",true);
         }
         return TimeFormatter.toMS2(param1);
      }
      
      private function clearTimer() : void
      {
         timeOutTimer.reset();
         timeOutTimer.removeEventListener("timer",onTimeOutTimerTick);
         timeOutTimer.removeEventListener("timerComplete",onTimeOutTimerComplete);
      }
      
      private function handler_checkBoxUpdateState() : void
      {
         _signal_updateSelectedState.dispatch(data as ClanWarMemberFullInfoValueObject,clip.check_box.isSelected);
      }
      
      private function handler_warriorStateUpdated() : void
      {
         if(clip && memberData)
         {
            clip.check_box.isSelected = memberData.warrior;
         }
      }
   }
}
