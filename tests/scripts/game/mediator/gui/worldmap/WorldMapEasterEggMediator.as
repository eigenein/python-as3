package game.mediator.gui.worldmap
{
   import game.command.rpc.mission.CommandPirateTreasureFarm;
   import game.model.GameModel;
   import game.model.user.easteregg.PlayerEasterEggData;
   import game.view.gui.worldmap.WorldMapEasterEggRewardPopup;
   import idv.cjcat.signals.Signal;
   
   public class WorldMapEasterEggMediator
   {
       
      
      private var easterEggData:PlayerEasterEggData;
      
      private var _signal_update:Signal;
      
      public function WorldMapEasterEggMediator(param1:PlayerEasterEggData)
      {
         _signal_update = new Signal();
         super();
         this.easterEggData = param1;
      }
      
      public function dispose() : void
      {
         _signal_update.clear();
      }
      
      public function get isAvailable_pirateTreasure() : Boolean
      {
         return easterEggData.isAvailable_pirateTreasure;
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function action_farmTreasure() : void
      {
         var _loc1_:CommandPirateTreasureFarm = GameModel.instance.actionManager.pirateTreasure_farm();
         _loc1_.signal_complete.addOnce(handler_farmComplete);
      }
      
      private function handler_farmComplete(param1:CommandPirateTreasureFarm) : void
      {
         var _loc2_:WorldMapEasterEggRewardPopup = new WorldMapEasterEggRewardPopup(param1.reward.outputDisplay);
         _loc2_.open();
         _signal_update.dispatch();
      }
   }
}
