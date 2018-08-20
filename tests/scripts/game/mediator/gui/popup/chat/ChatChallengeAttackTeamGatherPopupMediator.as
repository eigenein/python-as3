package game.mediator.gui.popup.chat
{
   import avmplus.getQualifiedClassName;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.mediator.gui.popup.team.SingleTeamGatherWithEnemyPopupMediator;
   import game.mediator.gui.popup.team.TeamGatherPopupHeroValueObject;
   import game.model.user.Player;
   import game.model.user.UserInfo;
   import game.model.user.arena.PlayerArenaEnemy;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanEntry;
   import game.stat.Stash;
   import game.view.gui.tutorial.Tutorial;
   
   public class ChatChallengeAttackTeamGatherPopupMediator extends SingleTeamGatherWithEnemyPopupMediator
   {
       
      
      private var _isTitanBattle:Boolean;
      
      private var _enemy:PlayerArenaEnemy;
      
      private var _enemyUser:UserInfo;
      
      public function ChatChallengeAttackTeamGatherPopupMediator(param1:Player, param2:Boolean, param3:PlayerArenaEnemy, param4:UserInfo)
      {
         this._isTitanBattle = param2;
         this._enemy = param3;
         this._enemyUser = param4;
         super(param1,MechanicStorage.CHAT);
      }
      
      override protected function dispose() : void
      {
         super.dispose();
      }
      
      override public function get enemyTeam() : Vector.<UnitEntryValueObject>
      {
         return _enemy.getTeam(0);
      }
      
      override public function get enemyTeamPower() : int
      {
         return _enemy.power;
      }
      
      public function get enemy() : PlayerArenaEnemy
      {
         return _enemy;
      }
      
      public function get enemyUser() : UserInfo
      {
         return _enemyUser;
      }
      
      public function get isTitanBattle() : Boolean
      {
         return _isTitanBattle;
      }
      
      override public function action_complete() : void
      {
         if(teamListDataProvider.length)
         {
            _signal_teamGatherComplete.dispatch(this);
            Tutorial.events.triggerEvent_teamSelectionCompleted();
            Stash.click("go",_popup.stashParams);
         }
      }
      
      override protected function filterAvailableHeroes(param1:UnitDescription, param2:int, param3:Vector.<UnitDescription>) : Boolean
      {
         if(!_isTitanBattle && player.heroes.getById(param1.id) || _isTitanBattle && player.titans.getById(param1.id))
         {
            return true;
         }
         trace(getQualifiedClassName(this),"У player нет в наличии героя с id " + param1.id + " но он выбран в качестве текущего члена команды " + activity.teamType);
         return false;
      }
      
      override protected function getDefaultTeam() : Vector.<UnitDescription>
      {
         return new Vector.<UnitDescription>();
      }
      
      override protected function createHeroList() : Vector.<TeamGatherPopupHeroValueObject>
      {
         var _loc1_:* = undefined;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = undefined;
         _loc2_ = 0;
         _loc5_ = 0;
         _loc6_ = null;
         var _loc3_:Vector.<TeamGatherPopupHeroValueObject> = new Vector.<TeamGatherPopupHeroValueObject>();
         if(!_isTitanBattle)
         {
            _loc1_ = player.heroes.getList();
            _loc2_ = _loc1_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_ = new TeamGatherPopupHeroValueObject(this,UnitUtils.createEntryValueObject(_loc1_[_loc5_]));
               _loc3_.push(_loc6_);
               _loc5_++;
            }
         }
         else
         {
            _loc4_ = player.titans.getList();
            _loc2_ = _loc4_.length;
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc6_ = new TeamGatherPopupHeroValueObject(this,UnitUtils.createEntryValueObject(_loc4_[_loc5_]));
               _loc3_.push(_loc6_);
               _loc5_++;
            }
         }
         _loc3_.sort(_sortVoVect);
         return _loc3_;
      }
   }
}
