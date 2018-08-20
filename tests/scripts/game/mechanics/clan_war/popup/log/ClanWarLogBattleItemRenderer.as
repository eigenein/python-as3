package game.mechanics.clan_war.popup.log
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.mediator.log.ClanWarLogBattleCaptureValueObject;
   import game.mechanics.clan_war.mediator.log.ClanWarLogBattleFreeValueObject;
   import game.mechanics.clan_war.mediator.log.ClanWarLogBattleValueObject;
   import game.mechanics.clan_war.mediator.log.ClanWarLogBattleValueObjectBase;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class ClanWarLogBattleItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanWarLogBattleItemClip;
      
      private var __data:ClanWarLogBattleValueObjectBase;
      
      public function ClanWarLogBattleItemRenderer()
      {
         super();
      }
      
      public static function getHeight(param1:ClanWarLogBattleValueObjectBase) : Number
      {
         if(param1.wasEmpty)
         {
            return 72;
         }
         if(param1.fortificationIsCaptured)
         {
            return 50;
         }
         return 100;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(clip && !clip.graphics.parent)
         {
            TooltipHelper.removeTooltip(clip.button_replay.graphics);
            TooltipHelper.removeTooltip(clip.button_info.graphics);
            TooltipHelper.removeTooltip(clip.button_chat.graphics);
            clip.graphics.dispose();
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
      }
      
      override protected function commitData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ClanWarLogBattleValueObjectBase = data as ClanWarLogBattleValueObjectBase;
         if(_loc1_)
         {
            __data = _loc1_;
            if(!clip)
            {
               createClip();
            }
            height = getHeight(__data);
            clip.tf_date.text = __data.dateString;
            clip.tf_position.text = __data.position;
            clip.tf_position_index.text = Translate.translateArgs("UI_CLAN_WAR_LOG_POSITION_INDEX",__data.positionIndex);
            _loc2_ = __data.points;
            clip.tf_points.text = "+" + String(_loc2_);
            clip.layout_points.visible = _loc2_ > 0;
            clip.points_glow.graphics.visible = _loc2_ > 0;
            clip.tf_position.graphics.visible = !__data.fortificationIsCaptured;
            if(_loc1_.wasEmpty)
            {
               setupClaimFree(__data as ClanWarLogBattleFreeValueObject);
            }
            else if(_loc1_.fortificationIsCaptured)
            {
               setupCapture(__data as ClanWarLogBattleCaptureValueObject);
            }
            else
            {
               setupBattle(__data as ClanWarLogBattleValueObject);
            }
         }
      }
      
      protected function setupClaimFree(param1:ClanWarLogBattleFreeValueObject) : void
      {
         clip.playback.gotoAndStop(1);
         clip.toggleWasCapturedWithBattle(false);
         clip.tf_date.visible = true;
         clip.tf_position_index.graphics.visible = false;
         clip.bg.graphics.alpha = 0.3;
         var _loc5_:int = 16777215;
         var _loc3_:int = 16375461;
         var _loc2_:String = ColorUtils.hexToRGBFormat(_loc5_) + param1.slotsCapturedFree + ColorUtils.hexToRGBFormat(_loc3_);
         var _loc4_:String = ColorUtils.hexToRGBFormat(_loc5_) + param1.fortificationSlotsTotal + ColorUtils.hexToRGBFormat(_loc3_);
         clip.tf_free_captured.text = Translate.translateArgs("UI_CLAN_WAR_LOG_FREE_CAPTURED",_loc2_,_loc4_,param1.slotsCapturedFree);
      }
      
      protected function setupCapture(param1:ClanWarLogBattleCaptureValueObject) : void
      {
         clip.playback.gotoAndStop(2);
         clip.toggleWasCapturedWithBattle(false);
         clip.tf_date.visible = true;
         clip.tf_position_index.graphics.visible = false;
         clip.bg.graphics.alpha = 1;
         clip.tf_free_captured.text = Translate.translateArgs("UI_CLAN_WAR_VICTORY_TF_LABEL_POINTS_BUILDING",__data.position);
      }
      
      protected function setupBattle(param1:ClanWarLogBattleValueObject) : void
      {
         clip.playback.gotoAndStop(0);
         clip.toggleWasCapturedWithBattle(true);
         clip.tf_date.visible = true;
         clip.tf_position_index.graphics.visible = true;
         clip.bg.graphics.alpha = 1;
         clip.panel_attacker.setData(param1.attacker);
         clip.panel_defender.setData(param1.defender);
         clip.tf_victory.graphics.visible = param1.isVictory;
         clip.tf_defeat.graphics.visible = param1.isDefeat;
         clip.tf_draw.graphics.visible = param1.isDraw;
      }
      
      private function createClip() : void
      {
         clip = AssetStorage.rsx.clan_war_map.create(ClanWarLogBattleItemClip,"clan_war_log_war_battle_item");
         addChild(clip.graphics);
         clip.tf_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_VICTORY");
         clip.tf_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DEFEAT");
         clip.tf_draw.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DRAW");
         clip.button_info.label = "i";
         clip.button_chat.signal_click.add(handler_chat);
         clip.button_info.signal_click.add(handler_info);
         clip.button_replay.signal_click.add(handler_replay);
         TooltipHelper.addTooltip(clip.button_replay.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_CAMERA_TOOL_TIP")));
         TooltipHelper.addTooltip(clip.button_info.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_INFO_TOOL_TIP")));
         TooltipHelper.addTooltip(clip.button_chat.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_REPLAY_TOOL_TIP")));
         clip.playback.gotoAndStop(0);
      }
      
      private function handler_chat() : void
      {
         if(__data is ClanWarLogBattleValueObject)
         {
            (__data as ClanWarLogBattleValueObject).action_chat();
         }
      }
      
      private function handler_info() : void
      {
         if(__data is ClanWarLogBattleValueObject)
         {
            (__data as ClanWarLogBattleValueObject).action_info();
         }
      }
      
      private function handler_replay() : void
      {
         if(__data is ClanWarLogBattleValueObject)
         {
            (__data as ClanWarLogBattleValueObject).action_replay();
         }
      }
   }
}
