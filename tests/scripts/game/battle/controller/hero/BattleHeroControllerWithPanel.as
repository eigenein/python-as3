package game.battle.controller.hero
{
   import battle.Hero;
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.view.BattleGraphicsMethodProvider;
   import game.battle.view.hero.HeroView;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.GameModel;
   import game.model.user.hero.UnitEntry;
   import game.view.gui.tutorial.Tutorial;
   import idv.cjcat.signals.Signal;
   
   public class BattleHeroControllerWithPanel extends BattleHeroController
   {
       
      
      private var heroEntry:UnitEntryValueObject;
      
      private var _userActionAvailableDuration:Number = 0;
      
      public const onDead:Signal = new Signal();
      
      public const onUpdateHp:Signal = new Signal();
      
      public const onUpdateEnergy:Signal = new Signal();
      
      public const onUpdateUserActionAvailable:Signal = new Signal();
      
      private var _userActionAvailable:Boolean;
      
      public function BattleHeroControllerWithPanel(param1:Hero, param2:HeroView, param3:BattleGraphicsMethodProvider, param4:BattleMediatorObjects)
      {
         super(param1,param2,param3,param4);
         heroEntry = param4.getUnitEntryValueObject(param1);
         param3.attachHeroPanel(this);
      }
      
      public function get title() : String
      {
         return _hero.desc.name;
      }
      
      public function get hp() : Number
      {
         return _hero.getRelativeHealth();
      }
      
      public function get energy() : Number
      {
         return _hero.getRelativeEnergy();
      }
      
      public function get userActionAvailable() : Boolean
      {
         return _userActionAvailable;
      }
      
      public function get canGlow() : Boolean
      {
         return hero.skills.canCastManual.enabled || _hero.engine.complete;
      }
      
      override public function advanceTime(param1:Number) : void
      {
         super.advanceTime(param1);
         if(_userActionAvailable != hero.userActionAvailable())
         {
            _userActionAvailable = !_userActionAvailable;
            _userActionAvailableDuration = 0;
            onUpdateUserActionAvailable.dispatch();
         }
         if(_userActionAvailable)
         {
            Tutorial.events.triggerEvent_battle_userActionAvailable(_userActionAvailableDuration);
            _userActionAvailableDuration = _userActionAvailableDuration + param1;
         }
      }
      
      public function getHeroEntryValueObject() : UnitEntryValueObject
      {
         var _loc1_:* = null;
         if(heroEntry)
         {
            return heroEntry;
         }
         _loc1_ = UnitUtils.getPlayerUnitEntry(GameModel.instance.player,DataStorage.hero.getById(_hero.desc.heroId) as UnitDescription);
         if(!_loc1_)
         {
            _loc1_ = UnitUtils.createEntry({
               "star":1,
               "color":1,
               "id":_hero.desc.heroId
            });
         }
         heroEntry = UnitUtils.createEntryValueObject(_loc1_);
         return UnitUtils.createEntryValueObject(_loc1_);
      }
      
      override public function onHpModify(param1:Number) : void
      {
         onUpdateHp.dispatch();
         super.onHpModify(param1);
      }
      
      override public function onEnergyModify(param1:Number) : void
      {
         onUpdateEnergy.dispatch();
         super.onEnergyModify(param1);
      }
      
      override public function onDie() : void
      {
         super.onDie();
         onDead.dispatch();
      }
      
      override protected function onEnemyTeamEmpty() : void
      {
         if(hero.desc.state.isDead && !view.isDying)
         {
            onDead.dispatch();
         }
         super.onEnemyTeamEmpty();
      }
   }
}
