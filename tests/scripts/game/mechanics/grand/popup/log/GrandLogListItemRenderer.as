package game.mechanics.grand.popup.log
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.command.rpc.grand.GrandBattleResult;
   import game.command.timer.GameTimer;
   import game.mechanics.grand.mediator.log.GrandLogListEntryValueObject;
   import game.mediator.gui.popup.arena.ArenaLogEntryVOProxy;
   import game.util.TimeFormatter;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class GrandLogListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:GrandLogListItemRendererClip;
      
      public function GrandLogListItemRenderer()
      {
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
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create_renderer_grand_log();
         addChild(clip.graphics);
         clip.tf_defence_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_DEFENCE_VICTORY");
         clip.tf_defence_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_DEFENCE_DEFEAT");
         clip.tf_attack_victory.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_VICTORY");
         clip.tf_attack_defeat.text = Translate.translate("UI_POPUP_ARENA_LOG_ATTACK_DEFEAT");
         clip.button_select.initialize(Translate.translate("UI_DIALOG_GRAND_LOG_DETAILS"),handler_select);
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc3_:GrandLogListEntryValueObject = data as GrandLogListEntryValueObject;
         var _loc1_:GrandBattleResult = !!_loc3_?_loc3_.entry:null;
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
         var _loc4_:* = _loc1_.placeDirection > 0;
         clip.arrow_green.graphics.visible = _loc4_;
         clip.tf_place_up.visible = _loc4_;
         _loc4_ = _loc1_.placeDirection < 0;
         clip.arrow_red.graphics.visible = _loc4_;
         clip.tf_place_down.visible = _loc4_;
         _loc4_ = _loc1_.place.toString();
         clip.tf_place_down.text = _loc4_;
         clip.tf_place_up.text = _loc4_;
         var _loc2_:int = GameTimer.instance.currentServerTime;
         _loc2_ = _loc2_ - _loc1_.endTime;
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
      
      protected function handler_select() : void
      {
         var _loc1_:GrandLogListEntryValueObject = data as GrandLogListEntryValueObject;
         if(_loc1_)
         {
            _loc1_.action_select();
         }
      }
   }
}
