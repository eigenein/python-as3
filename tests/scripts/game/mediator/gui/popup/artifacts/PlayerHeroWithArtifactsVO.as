package game.mediator.gui.popup.artifacts
{
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroArtifact;
   import game.model.user.hero.PlayerHeroEntry;
   
   public class PlayerHeroWithArtifactsVO extends PlayerHeroListValueObject
   {
       
      
      public function PlayerHeroWithArtifactsVO(param1:HeroDescription, param2:Player)
      {
         super(param1,param2);
         if(_playerEntry)
         {
            _playerEntry.signal_artifactEvolve.add(handler_artifactEvolve);
            _playerEntry.signal_artifactLevelUp.add(handler_artifactLevelUp);
         }
      }
      
      override public function dispose() : void
      {
         if(_playerEntry)
         {
            _playerEntry.signal_artifactEvolve.remove(handler_artifactEvolve);
            _playerEntry.signal_artifactLevelUp.remove(handler_artifactLevelUp);
         }
         super.dispose();
      }
      
      override public function get redDotState() : Boolean
      {
         return _watch.artifactUpgradeAvaliable;
      }
      
      private function handler_artifactEvolve(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_updateActionAvailable.dispatch();
      }
      
      private function handler_artifactLevelUp(param1:PlayerHeroEntry, param2:PlayerHeroArtifact) : void
      {
         signal_updateActionAvailable.dispatch();
      }
   }
}
