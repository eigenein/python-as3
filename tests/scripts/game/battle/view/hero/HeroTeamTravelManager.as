package game.battle.view.hero
{
   import battle.BattleConfig;
   import flash.geom.Point;
   import game.battle.controller.entities.BattleHero;
   import game.battle.view.location.TeamEnterBattleConfig;
   
   public class HeroTeamTravelManager
   {
       
      
      private var _isFirstBattle:Boolean;
      
      private var routesCount:int;
      
      private var _maxTravelTime:Number;
      
      private var routes:Vector.<TravelRoute>;
      
      private var locatedHeroes:Vector.<BattleHero>;
      
      private var enterBattleConfig:TeamEnterBattleConfig;
      
      public function HeroTeamTravelManager()
      {
         var _loc1_:int = 0;
         routes = new Vector.<TravelRoute>();
         locatedHeroes = new Vector.<BattleHero>();
         enterBattleConfig = new TeamEnterBattleConfig();
         super();
         _isFirstBattle = true;
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            routes.push(new TravelRoute());
            _loc1_++;
         }
      }
      
      public function get maxTravelTime() : Number
      {
         return _maxTravelTime;
      }
      
      public function get isFirstBattle() : Boolean
      {
         return _isFirstBattle;
      }
      
      public function initConfig(param1:BattleConfig) : void
      {
         enterBattleConfig.attackersDistanceToTravel = 3.125 * param1.defaultHeroSpeed;
         enterBattleConfig.defendersDistanceToTravel = 3.125 * param1.defaultHeroSpeed;
      }
      
      public function enterBattle(param1:Vector.<BattleHero>, param2:Point = null) : void
      {
         var _loc3_:* = null;
         if(_isFirstBattle)
         {
            _isFirstBattle = false;
            reset();
            locateNewHeroes(param1);
         }
         else
         {
            _loc3_ = new HeroTeamPlacer();
            relocateOldHeroes(param2);
            reset();
            locateNewHeroes(param1,_loc3_);
            locateOldHeroes(_loc3_);
            tryAnimateWinningHeroes(_loc3_);
         }
         sendHeroesToTargets(param1);
      }
      
      public function stopTravel() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function relocateOldHeroes(param1:Point) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function reset() : void
      {
         routesCount = 0;
         _maxTravelTime = 0;
      }
      
      protected function locateNewHeroes(param1:Vector.<BattleHero>, param2:HeroTeamPlacer = null) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function locateOldHeroes(param1:HeroTeamPlacer) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function tryAnimateWinningHeroes(param1:HeroTeamPlacer) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function sendHeroesToTargets(param1:Vector.<BattleHero>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function adjustNewHeroPosition(param1:BattleHero, param2:Point) : void
      {
         param1.view.position.y = param2.y;
         if(param1.hero.canWalk.isEnabled())
         {
            if(param1.hero.team.direction > 0)
            {
               param1.view.position.x = param2.x - enterBattleConfig.attackersDistanceToTravel;
            }
            else
            {
               param1.view.position.x = param2.x + enterBattleConfig.defendersDistanceToTravel;
            }
            param1.view.position.direction = param1.hero.getVisualDirection();
            param1.view.updatePosition();
         }
         else
         {
            param1.view.position.x = param2.x;
            param1.view.position.direction = param1.hero.team.direction;
            param1.view.updatePosition();
            param1.view.stopOnFirstFrame(AnimationIdent.RUN);
         }
      }
      
      protected function updateMaxTravelTime(param1:BattleHero, param2:TravelRoute) : void
      {
         param2.updateDuration(param1.view,param1.hero.speed.initialValue);
         if(param2.duration > _maxTravelTime)
         {
            _maxTravelTime = param2.duration;
         }
      }
   }
}
