package game.model.user.hero.watch
{
   import game.data.storage.titan.TitanDescription;
   import game.model.user.hero.PlayerTitanEntry;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTitanWatcherEntry
   {
       
      
      var titan:TitanDescription;
      
      var playerEntry:PlayerTitanEntry;
      
      private var _summonable:Boolean;
      
      private var _evolvable:Boolean;
      
      private var _expIncreasable:Boolean;
      
      private var _promotable:Boolean;
      
      private var _artifactUpgradeAvaliable:Boolean;
      
      private var _spiritArtifactUpgradeAvaliable:Boolean;
      
      private var _signal_updateActionAvailable:Signal;
      
      private var _signal_updateExpIncreasable:Signal;
      
      private var _signal_updatePromotableStatus:Signal;
      
      private var _signal_updateEvolvableStatus:Signal;
      
      private var _signal_updateArtifactUpgradeAvaliable:Signal;
      
      private var _signal_updateSpiritArtifactUpgradeAvaliable:Signal;
      
      private var _invalidated:Boolean;
      
      public function PlayerTitanWatcherEntry(param1:TitanDescription)
      {
         super();
         this.titan = param1;
         _signal_updateActionAvailable = new Signal(PlayerTitanWatcherEntry);
         _signal_updateExpIncreasable = new Signal(PlayerTitanWatcherEntry);
         _signal_updatePromotableStatus = new Signal(PlayerTitanWatcherEntry);
         _signal_updateEvolvableStatus = new Signal(PlayerTitanWatcherEntry);
         _signal_updateArtifactUpgradeAvaliable = new Signal(PlayerTitanWatcherEntry);
         _signal_updateSpiritArtifactUpgradeAvaliable = new Signal(PlayerTitanWatcherEntry);
      }
      
      public function get summonable() : Boolean
      {
         return _summonable;
      }
      
      public function set summonable(param1:Boolean) : void
      {
         if(_summonable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _summonable = param1;
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get evolvable() : Boolean
      {
         return _evolvable;
      }
      
      public function set evolvable(param1:Boolean) : void
      {
         if(_evolvable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _evolvable = param1;
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
         _signal_updateEvolvableStatus.dispatch(this);
      }
      
      public function get expIncreasable() : Boolean
      {
         return _expIncreasable;
      }
      
      public function set expIncreasable(param1:Boolean) : void
      {
         if(_expIncreasable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _expIncreasable = param1;
         _signal_updateExpIncreasable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get promotable() : Boolean
      {
         return _promotable;
      }
      
      public function set promotable(param1:Boolean) : void
      {
         if(_promotable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _promotable = param1;
         _signal_updatePromotableStatus.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get artifactUpgradeAvaliable() : Boolean
      {
         return _artifactUpgradeAvaliable;
      }
      
      public function set artifactUpgradeAvaliable(param1:Boolean) : void
      {
         if(_artifactUpgradeAvaliable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _artifactUpgradeAvaliable = param1;
         _signal_updateArtifactUpgradeAvaliable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get spiritArtifactUpgradeAvaliable() : Boolean
      {
         return _spiritArtifactUpgradeAvaliable;
      }
      
      public function set spiritArtifactUpgradeAvaliable(param1:Boolean) : void
      {
         if(_spiritArtifactUpgradeAvaliable == param1)
         {
            return;
         }
         var _loc2_:Boolean = actionAvailable;
         _spiritArtifactUpgradeAvaliable = param1;
         _signal_updateSpiritArtifactUpgradeAvaliable.dispatch(this);
         if(actionAvailable != _loc2_)
         {
            _signal_updateActionAvailable.dispatch(this);
         }
      }
      
      public function get actionAvailable() : Boolean
      {
         return _evolvable || _promotable || _expIncreasable || artifactUpgradeAvaliable || spiritArtifactUpgradeAvaliable;
      }
      
      public function get signal_updateActionAvailable() : Signal
      {
         return _signal_updateActionAvailable;
      }
      
      public function get signal_updateExpIncreasable() : Signal
      {
         return _signal_updateExpIncreasable;
      }
      
      public function get signal_updatePromotableStatus() : Signal
      {
         return _signal_updatePromotableStatus;
      }
      
      public function get signal_updateEvolvableStatus() : Signal
      {
         return _signal_updateEvolvableStatus;
      }
      
      public function get signal_updateArtifactUpgradeAvaliable() : Signal
      {
         return _signal_updateArtifactUpgradeAvaliable;
      }
      
      public function get signal_updateSpiritArtifactUpgradeAvaliable() : Signal
      {
         return _signal_updateSpiritArtifactUpgradeAvaliable;
      }
      
      function get invalidated() : Boolean
      {
         return _invalidated;
      }
      
      public function print() : void
      {
      }
      
      function invalidate() : void
      {
         _invalidated = true;
      }
      
      function validate() : void
      {
         _invalidated = false;
      }
      
      function addPlayerEntry(param1:PlayerTitanEntry) : void
      {
         playerEntry = param1;
      }
   }
}
