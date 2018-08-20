package game.model.user.clan
{
   import flash.utils.getTimer;
   import game.model.GameModel;
   
   public class ClanActivityUpdateManager
   {
      
      private static const UPDATE_TIMER:int = 5000;
       
      
      private var _invalid:Boolean = false;
      
      private var _lastUpdate:int;
      
      public function ClanActivityUpdateManager()
      {
         super();
         GameModel.instance.player.signal_update.stamina.add(handler_staminaUpdated);
      }
      
      public function requestUpdate() : void
      {
         var _loc1_:int = getTimer();
         if(_invalid || _loc1_ - _lastUpdate > 5000)
         {
            sendUpdateRequest();
            _lastUpdate = _loc1_;
            _invalid = false;
         }
      }
      
      public function runeWasUpgraded() : void
      {
         _invalid = true;
      }
      
      protected function sendUpdateRequest() : void
      {
         GameModel.instance.actionManager.clan.clanGetActivityStat();
      }
      
      private function handler_staminaUpdated() : void
      {
         _invalid = true;
      }
   }
}
