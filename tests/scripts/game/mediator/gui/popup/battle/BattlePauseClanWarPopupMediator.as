package game.mediator.gui.popup.battle
{
   import com.progrestar.common.lang.Translate;
   import engine.core.utils.property.StringProperty;
   import engine.core.utils.property.StringPropertyWriteable;
   import game.command.timer.GameTimer;
   import game.model.GameModel;
   import game.model.user.settings.PlayerSettingsData;
   import game.util.TimeFormatter;
   import game.view.popup.PopupBase;
   import game.view.popup.battle.BattlePauseClanWarPopup;
   
   public class BattlePauseClanWarPopupMediator extends BattlePausePopupMediator
   {
       
      
      private var endTime:int;
      
      private var _battleTimer:StringPropertyWriteable;
      
      public function BattlePauseClanWarPopupMediator(param1:PlayerSettingsData, param2:Boolean)
      {
         _battleTimer = new StringPropertyWriteable();
         super(param1,param2);
         endTime = GameModel.instance.player.clan.clanWarData.currentWar.currentBattle.endTime - 5;
         GameTimer.instance.oneSecTimer.add(handler_onSecTimer);
         handler_onSecTimer();
      }
      
      override public function disposeFromPublic() : void
      {
         super.disposeFromPublic();
         GameTimer.instance.oneSecTimer.remove(handler_onSecTimer);
      }
      
      public function get battleTimer() : StringProperty
      {
         return _battleTimer;
      }
      
      override public function get retreatButtonLabel() : String
      {
         return Translate.translate("UI_POPUP_BATTLE_SKIP");
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BattlePauseClanWarPopup(this);
         return new BattlePauseClanWarPopup(this);
      }
      
      private function handler_onSecTimer() : void
      {
         var _loc1_:int = endTime - GameTimer.instance.currentServerTime;
         if(_loc1_ < 0)
         {
            _loc1_ = 0;
            action_retreat();
            GameTimer.instance.oneSecTimer.remove(handler_onSecTimer);
         }
         _battleTimer.value = TimeFormatter.toMS(_loc1_);
      }
   }
}
