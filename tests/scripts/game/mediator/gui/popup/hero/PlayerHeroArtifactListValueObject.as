package game.mediator.gui.popup.hero
{
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.artifacts.PlayerHeroArtifactVO;
   import game.model.user.Player;
   import game.model.user.hero.watch.PlayerHeroWatcherEntry;
   
   public class PlayerHeroArtifactListValueObject extends PlayerHeroListValueObject
   {
       
      
      public function PlayerHeroArtifactListValueObject(param1:HeroDescription, param2:Player)
      {
         super(param1,param2);
         if(_watch)
         {
            _watch.signal_updateActionAvailable.add(handler_updateActionAvailable);
         }
      }
      
      override public function dispose() : void
      {
         if(_watch)
         {
            _watch.signal_updateActionAvailable.remove(handler_updateActionAvailable);
         }
         super.dispose();
      }
      
      public function get heroArtifactsList() : Vector.<PlayerHeroArtifactVO>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerHeroArtifactVO> = new Vector.<PlayerHeroArtifactVO>();
         if(hero)
         {
            _loc2_ = 0;
            while(_loc2_ < playerEntry.artifacts.list.length)
            {
               _loc1_.push(new PlayerHeroArtifactVO(player,playerEntry.artifacts.list[_loc2_],playerEntry));
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      override public function get redDotState() : Boolean
      {
         return _watch.artifactUpgradeAvaliable;
      }
      
      private function handler_updateActionAvailable(param1:PlayerHeroWatcherEntry) : void
      {
         signal_updateActionAvailable.dispatch();
      }
   }
}
