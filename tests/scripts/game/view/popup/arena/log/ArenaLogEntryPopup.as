package game.view.popup.arena.log
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.arena.ArenaLogEntryVOProxy;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.model.user.UserInfo;
   import game.view.popup.ClipBasedPopup;
   
   public class ArenaLogEntryPopup extends ClipBasedPopup
   {
       
      
      private var vo:ArenaLogEntryVOProxy;
      
      public function ArenaLogEntryPopup(param1:ArenaLogEntryVOProxy)
      {
         super(null);
         this.vo = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:ArenaLogEntryPopupClip = AssetStorage.rsx.popup_theme.create_dialog_arena_log_info();
         addChild(_loc1_.graphics);
         width = _loc1_.PopupBG_12_12_12_12_inst0.graphics.width;
         height = _loc1_.PopupBG_12_12_12_12_inst0.graphics.height;
         _loc1_.button_close.signal_click.add(close);
         _loc1_.tf_header.text = ArenaLogItemRenderer.getLabel(vo);
         setupPlayer(_loc1_.player_1,vo.attacker,vo.attackers);
         setupPlayer(_loc1_.player_2,vo.defender,vo.defenders);
         if(vo.isDefensiveBattle)
         {
            _loc1_.player_1.tf_label_nickname.text = Translate.translate("UI_POPUP_ARENA_LOG_ENEMY");
            _loc1_.player_2.tf_label_nickname.text = Translate.translate("UI_POPUP_ARENA_LOG_YOU");
         }
         else
         {
            _loc1_.player_2.tf_label_nickname.text = Translate.translate("UI_POPUP_ARENA_LOG_ENEMY");
            _loc1_.player_1.tf_label_nickname.text = Translate.translate("UI_POPUP_ARENA_LOG_YOU");
         }
      }
      
      private function setupPlayer(param1:ArenaLogEntryPopupTeam, param2:UserInfo, param3:Vector.<UnitEntryValueObject>) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = param1.panels.length;
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            if(param3.length > _loc5_)
            {
               param1.panels[_loc5_].data = param3[_loc5_];
            }
            else
            {
               param1.panels[_loc5_].data = null;
            }
            _loc5_++;
         }
      }
   }
}
