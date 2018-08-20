package battle
{
   import battle.data.BattleHeroDescription;
   import battle.data.BattleTeamDescription;
   import battle.data.HeroState;
   import battle.data.InputEventDescription;
   import battle.logic.MovementManager;
   import battle.logic.MovingBody;
   import battle.objects.BattleBody;
   import battle.signals.SignalNotifier;
   import battle.skills.Context;
   import flash.Boot;
   import haxe.ds.ObjectMap;
   
   public class Objects
   {
       
      
      public var teams:Vector.<Team>;
      
      public var onTeamEmpty:SignalNotifier;
      
      public var objects:Vector.<BattleBody>;
      
      public var movement:MovementManager;
      
      public var heroesByBody:ObjectMap;
      
      public function Objects(param1:MovementManager = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         onTeamEmpty = new SignalNotifier(null,"Objects.onTeamEmpty");
         movement = param1;
         teams = new Vector.<Team>();
         objects = new Vector.<BattleBody>();
         heroesByBody = new ObjectMap();
      }
      
      public function registerHero(param1:Hero) : void
      {
         heroesByBody[param1.body] = param1;
         movement.add(param1.body);
      }
      
      public function onTeamEmptyListener() : void
      {
         var _loc1_:int = teams.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            if(int(teams[_loc1_].heroes.length) == 0)
            {
               endBattle(teams[_loc1_]);
               return;
            }
         }
      }
      
      public function initTeams(param1:BattleEngine) : void
      {
         var _loc4_:* = null as Team;
         var _loc5_:* = null as Vector.<InputEventDescription>;
         var _loc2_:Vector.<Team> = teams;
         var _loc3_:int = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            _loc4_ = _loc2_[_loc3_];
            _loc4_.initializeHeroesPositions(param1.config);
         }
         _loc2_ = teams;
         _loc3_ = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            _loc4_ = _loc2_[_loc3_];
            _loc4_.applyInitialBehavior();
            _loc5_ = _loc4_.desc.input;
            if(_loc5_ != null && int(_loc5_.length) != 0)
            {
               param1.input = new InputEventHolder(_loc4_,_loc5_);
               if(_loc4_.desc.logInput)
               {
                  _loc4_.desc.clearInput();
               }
            }
            if(_loc4_.desc.logInput)
            {
               _loc4_.onAutoFightToggle.add(_loc4_.desc.logAutoToggleEvent);
            }
         }
      }
      
      public function get_defenders() : Team
      {
         return teams[1];
      }
      
      public function get_attackers() : Team
      {
         return teams[0];
      }
      
      public function getTeamByDescription(param1:BattleTeamDescription) : Team
      {
         var _loc2_:int = teams.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(teams[_loc2_].desc == param1)
            {
               return teams[_loc2_];
            }
         }
         return null;
      }
      
      public function getHeroByBody(param1:MovingBody) : Hero
      {
         return heroesByBody[param1];
      }
      
      public function endBattle(param1:Team) : void
      {
         onTeamEmpty.data = param1;
         onTeamEmpty.fire();
      }
      
      public function disableAll() : void
      {
         var _loc2_:* = null as Vector.<Hero>;
         var _loc3_:int = 0;
         var _loc1_:int = teams.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            _loc2_ = teams[_loc1_].heroes;
            _loc3_ = _loc2_.length;
            while(true)
            {
               _loc3_--;
               if(_loc3_ <= 0)
               {
                  break;
               }
               _loc2_[_loc3_].skills.canCast.block(this);
               _loc2_[_loc3_].skills.canCastManual.block(this);
            }
         }
      }
      
      public function createTeam(param1:Team, param2:BattleTeamDescription, param3:BattleEngine) : Team
      {
         var _loc6_:int = 0;
         var _loc7_:* = null as Hero;
         param2.sortByOrder();
         param1.init(param2);
         param1.onEmpty.add(onTeamEmptyListener);
         var _loc4_:int = param2.heroes.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc5_++;
            _loc6_ = _loc5_;
            if(!(param2.heroes[_loc6_].state != null && param2.heroes[_loc6_].state.isDead))
            {
               _loc7_ = new Hero(param1,param3);
               _loc7_.loadData(param2.heroes[_loc6_]);
               Context.scene.addHero(_loc7_);
               Context.scene.addBody(_loc7_,param1);
            }
         }
         return param1;
      }
      
      public function createEmptyTeam(param1:BattleEngine, param2:int, param3:Boolean) : Team
      {
         var _loc4_:Team = new Team(param1,param2);
         _loc4_.immediateUltimates = param3;
         var _loc5_:int = teams.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            if(teams[_loc5_].direction != param2)
            {
               _loc4_.enemyTeam = teams[_loc5_];
               teams[_loc5_].enemyTeam = _loc4_;
            }
         }
         teams.push(_loc4_);
         return _loc4_;
      }
      
      public function bodiesToHeroes(param1:Vector.<MovingBody>) : Vector.<Hero>
      {
         var _loc5_:* = null as MovingBody;
         var _loc2_:Vector.<Hero> = new Vector.<Hero>();
         var _loc3_:Vector.<MovingBody> = param1;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            _loc2_.push(heroesByBody[_loc5_]);
         }
         return _loc2_;
      }
   }
}
