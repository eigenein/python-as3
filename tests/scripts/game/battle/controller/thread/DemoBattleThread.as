package game.battle.controller.thread
{
   import battle.BattleConfig;
   import battle.Hero;
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   import battle.data.HeroState;
   import game.assets.battle.BattleAsset;
   import game.assets.battle.BattlegroundAsset;
   import game.battle.controller.entities.BattleHero;
   import game.battle.view.BattleScene;
   import game.view.gui.tutorial.Tutorial;
   
   public class DemoBattleThread extends SingleBattleThread
   {
       
      
      private var rawBattleParams:Object;
      
      public function DemoBattleThread(param1:BattleData, param2:BattlegroundAsset = null, param3:BattleConfig = null, param4:Object = null)
      {
         super(param1,param2,param3);
         this.rawBattleParams = param4;
         applyPreBattleParams(param1,param4);
         controller.progressInfo.signal_progress.add(Tutorial.events.triggerEvent_battleTiming);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         controller.progressInfo.signal_progress.remove(Tutorial.events.triggerEvent_battleTiming);
      }
      
      override protected function enterLocation(param1:BattleAsset) : void
      {
         super.enterLocation(param1);
         if(rawBattleParams != null)
         {
            applyRawBattleParams(param1.battleData,rawBattleParams);
         }
      }
      
      public function pauseAt(param1:Number = NaN) : void
      {
         if(currentBattle)
         {
            currentBattle.pauseAt(param1);
         }
      }
      
      private function applyPreBattleParams(param1:BattleData, param2:Object) : void
      {
         applyPreBattleTeamStateParams(param1.attackers,param2.teams[0]);
         applyPreBattleTeamStateParams(param1.defenders,param2.teams[1]);
      }
      
      private function applyPreBattleTeamStateParams(param1:BattleTeamDescription, param2:Object) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function applyRawBattleParams(param1:BattleData, param2:Object) : void
      {
         applyTeamStateParams(param1.attackers,param2.teams[0]);
         applyTeamStateParams(param1.defenders,param2.teams[1]);
         var _loc4_:BattleScene = Game.instance.screen.getBattleScreen().scene;
         var _loc3_:Number = _loc4_.cameraMotionTimeLeft;
         if(param2.skipTraveling)
         {
            currentBattle.advanceTime(_loc3_);
         }
         if(param2.advanceTime)
         {
            currentBattle.advanceTime(param2.advanceTime);
         }
      }
      
      private function applyTeamStateParams(param1:BattleTeamDescription, param2:Object) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc7_:* = param2.heroes;
         for each(var _loc3_ in param2.heroes)
         {
            _loc6_ = param1.getHeroById(_loc3_.id);
            _loc4_ = objects.getHeroByDescription(_loc6_);
            _loc5_ = _loc4_.hero;
            if(_loc3_.hasOwnProperty("xOffset"))
            {
               _loc5_.body.x = _loc5_.body.x + _loc3_.xOffset;
               _loc4_.view.position.x = _loc4_.view.position.x + _loc3_.xOffset;
            }
         }
      }
      
      private function applyTeamDescStateParams(param1:BattleTeamDescription, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param2.heroes;
         for each(var _loc3_ in param2.heroes)
         {
            _loc4_ = param1.getHeroById(_loc3_.id);
            if(_loc3_.hpPercent > 0)
            {
               _loc4_.state = new HeroState(_loc4_.stats.getFullHp() * _loc3_.hpPercent / 100);
            }
            if(_loc3_.energy > 0)
            {
               if(_loc4_.state)
               {
                  _loc4_.state.energy = _loc3_.energy;
               }
               else
               {
                  _loc4_.state = new HeroState(_loc4_.stats.getFullHp(),_loc3_.energy);
               }
            }
         }
      }
   }
}
