package game.mediator.gui.popup.tower
{
   import battle.data.HeroState;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.data.storage.tower.TowerBattleDifficulty;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.StateBasedTeamGatherPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherHeroBlockReason;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.model.user.Player;
   import game.model.user.tower.PlayerTowerBattleEnemy;
   import game.view.popup.PopupBase;
   import game.view.popup.team.TowerTeamGatherPopup;
   
   public class TowerTeamGatherPopupMediator extends StateBasedTeamGatherPopupMediator
   {
       
      
      private var _enemy:PlayerTowerBattleEnemy;
      
      public function TowerTeamGatherPopupMediator(param1:Player, param2:PlayerTowerBattleEnemy)
      {
         super(param1,MechanicStorage.TOWER);
         _enemy = param2;
      }
      
      override public function get enemyTeam() : Vector.<UnitEntryValueObject>
      {
         return UnitUtils.heroEntryVectorToUnitEntryVector(_enemy.heroes);
      }
      
      override public function get enemyTeamPower() : int
      {
         return _enemy.power;
      }
      
      public function get enemyDifficulty() : TowerBattleDifficulty
      {
         return _enemy.difficulty;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerTeamGatherPopup(this);
         return _popup;
      }
      
      override protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         var _loc3_:* = null;
         var _loc2_:Vector.<TeamGatherPopupHeroValueObject> = player.tower.createHeroList(this,player);
         _loc2_.sort(_sortVoVect);
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc1_ in _loc2_)
         {
            _loc3_ = isHeroUnavailable(_loc1_);
            if(_loc3_)
            {
               _loc1_.setUnavailable(_loc3_);
            }
         }
         return _loc2_;
      }
      
      override protected function filterAvailableHeroes(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         if(!super.filterAvailableHeroes(param1,param2,param3))
         {
            return false;
         }
         var _loc4_:HeroState = player.tower.heroes.getHeroState(param1.id);
         if(_loc4_ && _loc4_.isDead)
         {
            return false;
         }
         return true;
      }
   }
}
