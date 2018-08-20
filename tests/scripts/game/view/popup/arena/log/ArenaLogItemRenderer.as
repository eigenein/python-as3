package game.view.popup.arena.log
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.timer.GameTimer;
   import game.mediator.gui.popup.arena.ArenaLogEntryVOProxy;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.util.TimeFormatter;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.gui.components.tooltip.TooltipTextView;
   import idv.cjcat.signals.Signal;
   
   public class ArenaLogItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:ArenaLogItemRendererClip;
      
      private var _signal_select:Signal;
      
      private var _signal_info:Signal;
      
      private var _signal_chat:Signal;
      
      public function ArenaLogItemRenderer()
      {
         _signal_select = new Signal(ArenaLogEntryVOProxy);
         _signal_info = new Signal(ArenaLogEntryVOProxy);
         _signal_chat = new Signal(ArenaLogEntryVOProxy);
         super();
      }
      
      public static function getLabel(param1:ArenaLogEntryVOProxy) : String
      {
         if(param1.isDefensiveBattle && param1.win)
         {
            return Translate.translate("UI_POPUP_ARENA_LOG_DEFENCE_VICTORY");
         }
         if(param1.isDefensiveBattle && !param1.win)
         {
            return Translate.translate("UI_POPUP_ARENA_LOG_DEFENCE_DEFEAT");
         }
         if(!param1.isDefensiveBattle && param1.win)
         {
            return Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_VICTORY");
         }
         if(param1.isDefensiveBattle && !param1.win)
         {
            return Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DEFEAT");
         }
         return "";
      }
      
      public function get signal_select() : Signal
      {
         return _signal_select;
      }
      
      public function get signal_info() : Signal
      {
         return _signal_info;
      }
      
      public function get signal_chat() : Signal
      {
         return _signal_chat;
      }
      
      override public function dispose() : void
      {
         TooltipHelper.removeTooltip(clip.btn_camera.graphics);
         TooltipHelper.removeTooltip(clip.btn_info.graphics);
         TooltipHelper.removeTooltip(clip.btn_chat.graphics);
         super.dispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_renderer_arena_log();
         addChild(clip.graphics);
         clip.tf_defence_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_DEFENCE_VICTORY");
         clip.tf_defence_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_DEFENCE_DEFEAT");
         clip.tf_attack_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_VICTORY");
         clip.tf_attack_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DEFEAT");
         clip.btn_info.label = "i";
         clip.btn_camera.signal_click.add(handler_clickReplay);
         clip.btn_info.signal_click.add(handler_clickInfo);
         clip.btn_chat.signal_click.add(handler_clickChat);
         TooltipHelper.addTooltip(clip.btn_camera.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_CAMERA_TOOL_TIP")));
         TooltipHelper.addTooltip(clip.btn_info.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_INFO_TOOL_TIP")));
         TooltipHelper.addTooltip(clip.btn_chat.graphics,new TooltipVO(TooltipTextView,Translate.translate("UI_DIALOG_ARENA_REPLAY_TOOL_TIP")));
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:ArenaLogEntryVOProxy = data as ArenaLogEntryVOProxy;
         if(_loc1_ && _loc1_.displayedUser)
         {
            clip.tf_nickname.text = _loc1_.displayedUser.nickname;
            clip.portrait.setData(_loc1_.displayedUser);
         }
         else
         {
            clip.portrait.setData(null);
            clip.tf_nickname.text = "?";
         }
         if(!_loc1_)
         {
            return;
         }
         clip.tf_defence_victory.visible = _loc1_.isDefensiveBattle && _loc1_.win;
         clip.tf_defence_defeat.visible = _loc1_.isDefensiveBattle && !_loc1_.win;
         clip.tf_attack_victory.visible = !_loc1_.isDefensiveBattle && _loc1_.win;
         clip.tf_attack_defeat.visible = !_loc1_.isDefensiveBattle && !_loc1_.win;
         var _loc3_:* = _loc1_.placeDirection > 0 && _loc1_.place != 0;
         clip.arrow_green.graphics.visible = _loc3_;
         clip.tf_place_up.visible = _loc3_;
         _loc3_ = _loc1_.placeDirection < 0 && _loc1_.place != 0;
         clip.arrow_red.graphics.visible = _loc3_;
         clip.tf_place_down.visible = _loc3_;
         _loc3_ = _loc1_.place != 0?String(_loc1_.place):"";
         clip.tf_place_down.text = _loc3_;
         clip.tf_place_up.text = _loc3_;
         var _loc2_:int = GameTimer.instance.currentServerTime;
         _loc2_ = _loc2_ - _loc1_.source.endTime;
         if(_loc2_ > 86400)
         {
            clip.tf_date.text = Translate.translateArgs("UI_POPUP_ARENA_LOG_TIME_AGO",TimeFormatter.toDH(_loc2_,"{d} {h}"," ",true));
         }
         else
         {
            clip.tf_date.text = Translate.translateArgs("UI_POPUP_ARENA_LOG_TIME_AGO",TimeFormatter.toMS2(_loc2_));
         }
         if(_loc1_.displayedUser)
         {
            clip.clan_icon.setData(_loc1_.displayedUser.clanInfo);
         }
         else
         {
            clip.clan_icon.setData(null);
         }
      }
      
      private function handler_clickReplay() : void
      {
         signal_select.dispatch(data as ArenaLogEntryVOProxy);
      }
      
      private function handler_clickInfo() : void
      {
         signal_info.dispatch(data as ArenaLogEntryVOProxy);
      }
      
      private function handler_clickChat() : void
      {
         signal_chat.dispatch(data as ArenaLogEntryVOProxy);
      }
   }
}
