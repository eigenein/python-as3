package game.mediator.gui.popup.player
{
   import game.data.storage.DataStorage;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   import game.view.popup.player.LevelUpPopup;
   
   public class LevelUpPopupMediator extends PopupMediator
   {
       
      
      private var teamLevel:PlayerTeamLevel;
      
      private var prevLevel:PlayerTeamLevel;
      
      public function LevelUpPopupMediator(param1:Player, param2:PlayerTeamLevel, param3:PlayerTeamLevel)
      {
         super(param1);
         this.prevLevel = param3;
         this.teamLevel = param2;
      }
      
      override public function close() : void
      {
         Stash.click("ok:" + teamLevel.level,_popup.stashParams);
         super.close();
      }
      
      public function get level() : int
      {
         return teamLevel.level;
      }
      
      public function get energyReward() : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc1_:int = 0;
         var _loc3_:int = teamLevel.level;
         _loc4_ = prevLevel.level + 1;
         while(_loc4_ <= _loc3_)
         {
            _loc2_ = DataStorage.level.getTeamLevelByLevel(_loc4_);
            _loc1_ = _loc1_ + _loc2_.levelUpRewardStamina;
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function get displayedMechanics() : Vector.<MechanicDescription>
      {
         var _loc1_:Vector.<MechanicDescription> = new Vector.<MechanicDescription>();
         _loc1_.push(MechanicStorage.TOWER);
         _loc1_.push(MechanicStorage.CLAN);
         _loc1_.push(MechanicStorage.ARENA);
         _loc1_.push(MechanicStorage.GRAND);
         _loc1_.push(MechanicStorage.BOSS);
         _loc1_.push(MechanicStorage.ZEPPELIN);
         _loc1_.push(MechanicStorage.TITAN_ARENA);
         _loc1_ = _loc1_.filter(filterMechanics);
         _loc1_.sort(sortMechanics);
         var _loc2_:uint = 2;
         if(_loc1_.length > _loc2_)
         {
            _loc1_.splice(_loc2_,_loc1_.length - _loc2_);
         }
         return _loc1_;
      }
      
      public function get stamina_prevLevel() : int
      {
         return prevLevel.maxStamina;
      }
      
      public function get stamina_now() : int
      {
         return teamLevel.maxStamina;
      }
      
      public function get heroLevel_prevLevel() : int
      {
         return prevLevel.maxHeroLevel;
      }
      
      public function get heroLevel_now() : int
      {
         return teamLevel.maxHeroLevel;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new LevelUpPopup(this);
         return _popup;
      }
      
      protected function filterMechanics(param1:MechanicDescription, param2:int, param3:Vector.<MechanicDescription>) : Boolean
      {
         if(param1.teamLevel >= level)
         {
            return true;
         }
         return false;
      }
      
      private function sortMechanics(param1:MechanicDescription, param2:MechanicDescription) : int
      {
         if(param1.teamLevel < param2.teamLevel)
         {
            return -1;
         }
         if(param1.teamLevel > param2.teamLevel)
         {
            return 1;
         }
         return 0;
      }
   }
}
