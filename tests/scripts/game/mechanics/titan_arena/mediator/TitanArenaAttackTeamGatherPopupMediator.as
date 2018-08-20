package game.mechanics.titan_arena.mediator
{
   import avmplus.getQualifiedClassName;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.titan_arena.model.PlayerTitanArenaEnemy;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.SingleTeamGatherWithEnemyPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.model.user.Player;
   import game.model.user.hero.PlayerTitanEntry;
   
   public class TitanArenaAttackTeamGatherPopupMediator extends SingleTeamGatherWithEnemyPopupMediator
   {
       
      
      private var _enemy:PlayerTitanArenaEnemy;
      
      public function TitanArenaAttackTeamGatherPopupMediator(param1:PlayerTitanArenaEnemy, param2:Player)
      {
         this._enemy = param1;
         super(param2,MechanicStorage.TITAN_ARENA);
      }
      
      public function get enemy() : PlayerTitanArenaEnemy
      {
         return _enemy;
      }
      
      override public function get enemyTeamPower() : int
      {
         return _enemy.power;
      }
      
      override public function get enemyTeam() : Vector.<UnitEntryValueObject>
      {
         return _enemy.getTeam(0);
      }
      
      override protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc2_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         var _loc3_:Vector.<PlayerTitanEntry> = player.titans.getList();
         var _loc1_:int = _loc3_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc5_ = new TeamGatherPopupHeroValueObject(this,UnitUtils.createEntryValueObject(_loc3_[_loc4_]));
            _loc2_.push(_loc5_);
            _loc4_++;
         }
         _loc2_.sort(_sortVoVect);
         return _loc2_;
      }
      
      override protected function filterAvailableHeroes(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         if(player.titans.getById(param1.id))
         {
            return true;
         }
         trace(getQualifiedClassName(this),"У player нет в наличии ТИТАНА с id " + param1.id + " но он выбран в качестве текущего члена команды " + activity.teamType);
         return false;
      }
   }
}
