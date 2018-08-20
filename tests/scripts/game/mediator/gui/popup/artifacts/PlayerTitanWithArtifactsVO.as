package game.mediator.gui.popup.artifacts
{
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.titan.PlayerTitanListValueObject;
   import game.model.user.Player;
   import game.model.user.hero.watch.PlayerTitanWatcherEntry;
   
   public class PlayerTitanWithArtifactsVO extends PlayerTitanListValueObject
   {
       
      
      public function PlayerTitanWithArtifactsVO(param1:TitanDescription, param2:Player)
      {
         super(param1,param2);
         if(_watch)
         {
            _watch.signal_updateArtifactUpgradeAvaliable.add(handler_updateArtifactUpgradeAvaliable);
         }
      }
      
      override public function dispose() : void
      {
         if(_watch)
         {
            _watch.signal_updateArtifactUpgradeAvaliable.remove(handler_updateArtifactUpgradeAvaliable);
         }
         super.dispose();
      }
      
      override public function get redDotState() : Boolean
      {
         return _watch.artifactUpgradeAvaliable;
      }
      
      private function handler_updateArtifactUpgradeAvaliable(param1:PlayerTitanWatcherEntry) : void
      {
         signal_updateActionAvailable.dispatch();
      }
   }
}
