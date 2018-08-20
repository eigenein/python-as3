package game.mediator.gui.popup.battle
{
   import com.progrestar.common.lang.Translate;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.settings.SettingToggleButtonMediator;
   import game.model.user.settings.PlayerSettingsData;
   import game.view.popup.PopupBase;
   import game.view.popup.battle.BattlePausePopup;
   import idv.cjcat.signals.Signal;
   
   public class BattlePausePopupMediator extends PopupMediator
   {
       
      
      private var _isReplay:Boolean;
      
      private var _playSounds:SettingToggleButtonMediator;
      
      private var _playMusic:SettingToggleButtonMediator;
      
      public const signal_continue:Signal = new Signal();
      
      public const signal_retreat:Signal = new Signal();
      
      public function BattlePausePopupMediator(param1:PlayerSettingsData, param2:Boolean)
      {
         super(null);
         _playSounds = new SettingToggleButtonMediator(param1.playSounds);
         _playMusic = new SettingToggleButtonMediator(param1.playMusic);
         _isReplay = param2;
      }
      
      public function disposeFromPublic() : void
      {
         dispose();
         signal_continue.clear();
         signal_retreat.clear();
      }
      
      public function get playSounds() : SettingToggleButtonMediator
      {
         return _playSounds;
      }
      
      public function get playMusic() : SettingToggleButtonMediator
      {
         return _playMusic;
      }
      
      public function get isReplay() : Boolean
      {
         return _isReplay;
      }
      
      public function get retreatButtonLabel() : String
      {
         var _loc1_:* = null;
         if(isReplay)
         {
            _loc1_ = "UI_POPUP_BATTLE_SKIP";
            if(Translate.has(_loc1_))
            {
               return Translate.translate(_loc1_);
            }
         }
         return Translate.translate("UI_POPUP_BATTLE_RETREAT");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BattlePausePopup(this);
         return _popup;
      }
      
      public function action_continue() : void
      {
         signal_continue.dispatch();
      }
      
      public function action_retreat() : void
      {
         signal_retreat.dispatch();
      }
   }
}
