package game.mediator.gui.popup.titan
{
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.artifacts.PlayerTitanArtifactVO;
   import game.model.user.Player;
   import game.model.user.hero.watch.PlayerTitanWatcherEntry;
   
   public class PlayerTitanArtifactListValueObject extends PlayerTitanListValueObject
   {
       
      
      public function PlayerTitanArtifactListValueObject(param1:TitanDescription, param2:Player)
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
      
      public function get titanArtifactsList() : Vector.<PlayerTitanArtifactVO>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<PlayerTitanArtifactVO> = new Vector.<PlayerTitanArtifactVO>();
         if(titan)
         {
            _loc2_ = 0;
            while(_loc2_ < playerEntry.artifacts.list.length)
            {
               _loc1_.push(new PlayerTitanArtifactVO(player,playerEntry.artifacts.list[_loc2_],playerEntry));
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      override public function get redDotState() : Boolean
      {
         return _watch.artifactUpgradeAvaliable;
      }
      
      private function handler_updateActionAvailable(param1:PlayerTitanWatcherEntry) : void
      {
         signal_updateActionAvailable.dispatch();
      }
   }
}
