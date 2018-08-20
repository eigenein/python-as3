package game.battle.controller
{
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   import battle.objects.BattleBody;
   import battle.proxy.IBattleBodyProxy;
   import engine.core.utils.VectorUtil;
   import game.assets.battle.BattlePlayerTeamIconDescription;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.hero.BattleInspectorLog;
   import game.battle.controller.position.BattleBodyEntry;
   import game.battle.controller.position.BattleBodyStateSystem;
   import game.data.reward.RewardData;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   
   public class BattleMediatorObjects
   {
       
      
      protected var _showBothTeamsPanels:Boolean;
      
      protected var _playerSideTeamDescription:BattleTeamDescription;
      
      protected var _attackerIconDescription:BattlePlayerTeamIconDescription;
      
      protected var _defenderIconDescription:BattlePlayerTeamIconDescription;
      
      protected var reward:BattleEnemyReward;
      
      protected var heroes:Vector.<BattleHero>;
      
      public const entities:BattleEntityMediators = new BattleEntityMediators();
      
      public const bodies:BattleBodyStateSystem = new BattleBodyStateSystem();
      
      public const animationWaitor:BattleAnimationWaitor = new BattleAnimationWaitor();
      
      public const inspector:BattleInspectorLog = new BattleInspectorLog();
      
      public function BattleMediatorObjects()
      {
         heroes = new Vector.<BattleHero>();
         super();
      }
      
      public function dispose() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            _loc1_.view.statusBar.cleanUpBattle();
         }
         bodies.clear();
      }
      
      public function cleanUpBattle() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            _loc1_.view.statusBar.cleanUpBattle();
         }
         bodies.clear();
         entities.clear();
      }
      
      public function endBattle() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            _loc1_.view.statusBar.fadeAway();
         }
      }
      
      public function unlink() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = heroes;
         for each(var _loc1_ in heroes)
         {
            _loc1_.unlink();
         }
      }
      
      public function set playerSideTeamDescription(param1:BattleTeamDescription) : void
      {
         _playerSideTeamDescription = param1;
      }
      
      public function set attackerIconDescription(param1:BattlePlayerTeamIconDescription) : void
      {
         _attackerIconDescription = param1;
      }
      
      public function set defenderIconDescription(param1:BattlePlayerTeamIconDescription) : void
      {
         _defenderIconDescription = param1;
      }
      
      public function set showBothTeamsPanels(param1:Boolean) : void
      {
         _showBothTeamsPanels = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = heroes;
         for each(var _loc2_ in heroes)
         {
            _loc2_.advanceTime(param1);
         }
      }
      
      public function getUnitEntryValueObject(param1:Hero) : UnitEntryValueObject
      {
         if(param1.team.direction > 0)
         {
            if(_attackerIconDescription)
            {
               return _attackerIconDescription.getHeroById(param1.desc.id);
            }
         }
         else if(_defenderIconDescription)
         {
            return _defenderIconDescription.getHeroById(param1.desc.id);
         }
         return null;
      }
      
      public function addHero(param1:BattleHero) : void
      {
         heroes.push(param1);
      }
      
      public function removeHero(param1:BattleHero) : void
      {
         VectorUtil.remove(heroes,param1);
      }
      
      public function getHeroByDescription(param1:BattleHeroDescription) : BattleHero
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function addBodyEntry(param1:BattleBodyEntry, param2:Boolean = false) : IBattleBodyProxy
      {
         return bodies.addEntry(param1,param2);
      }
      
      public function getBody(param1:BattleBody) : IBattleBodyProxy
      {
         return bodies.getBody(param1);
      }
      
      public function getPlayerHeroById(param1:int) : BattleHero
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getEnemyHeroById(param1:int) : BattleHero
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function getAllHeroes() : Vector.<BattleHero>
      {
         return heroes;
      }
      
      public function isHeroWithPanel(param1:Hero) : Boolean
      {
         if(_showBothTeamsPanels)
         {
            return true;
         }
         return param1.team.desc == _playerSideTeamDescription && param1.needGuiPanel;
      }
      
      public function isPlayerSideTeam(param1:Team) : Boolean
      {
         return param1.desc == _playerSideTeamDescription;
      }
      
      public function addEnemyReward(param1:*) : void
      {
         if(!reward)
         {
            reward = new BattleEnemyReward();
         }
         reward.addReward(param1);
      }
      
      public function getReward(param1:BattleHero) : RewardData
      {
         if(!reward)
         {
            return null;
         }
         if(param1.hero.team.desc != _playerSideTeamDescription)
         {
            return reward.getByHeroId(param1.hero.desc.id);
         }
         return null;
      }
      
      public function setHeroesHappy(param1:Boolean) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}
