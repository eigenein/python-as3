package battle.data
{
   import battle.HeroStats;
   import battle.utils.Version;
   import flash.Boot;
   
   public class BattleData
   {
       
      
      public var v:int;
      
      public var seed:uint;
      
      public var defenders:BattleTeamDescription;
      
      public var b:int;
      
      public var attackers:BattleTeamDescription;
      
      public function BattleData()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         b = 0;
         v = Version.current;
      }
      
      public static function parseRawTeamDescription(param1:*, param2:int) : BattleTeamDescription
      {
         var _loc6_:* = null;
         var _loc7_:* = null as HeroStats;
         var _loc8_:* = null as Vector.<BattleSkillDescription>;
         var _loc9_:* = null as Array;
         var _loc10_:* = null as BattleHeroDescription;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:* = null;
         var _loc14_:* = null as HeroState;
         var _loc15_:* = null as Array;
         var _loc16_:* = null as String;
         var _loc3_:BattleTeamDescription = new BattleTeamDescription();
         _loc3_.direction = param2;
         _loc3_.libver = param1.libver;
         _loc3_.owner = param1.owner;
         var _loc4_:Array = param1.heroes;
         var _loc5_:int = 0;
         while(_loc5_ < int(_loc4_.length))
         {
            _loc6_ = _loc4_[_loc5_];
            _loc5_++;
            _loc7_ = HeroStats.fromRawData(_loc6_.stats);
            _loc8_ = new Vector.<BattleSkillDescription>();
            _loc9_ = _loc6_.skills;
            _loc10_ = new BattleHeroDescription();
            _loc11_ = 0;
            while(_loc11_ < int(_loc9_.length))
            {
               _loc12_ = _loc9_[_loc11_];
               _loc11_++;
               if(!!_loc12_ && _loc12_.h)
               {
                  _loc12_ = _loc12_.h;
               }
               else
               {
                  null;
               }
               _loc13_ = _loc12_;
               if(!!_loc13_["params"] && _loc13_["params"].h)
               {
                  _loc13_["params"] = _loc13_["params"].h;
               }
               else
               {
                  null;
               }
               if(!!_loc13_["calculatedParams"] && _loc13_["calculatedParams"].h)
               {
                  _loc13_["calculatedParams"] = _loc13_["calculatedParams"].h;
               }
               else
               {
                  null;
               }
               _loc8_.push(new BattleSkillDescription(_loc12_.level,_loc10_,_loc12_.tier,_loc13_));
            }
            _loc14_ = null;
            if(_loc6_.state != null)
            {
               _loc14_ = new HeroState(_loc6_.state.hp,_loc6_.state.energy,_loc6_.state.isDead);
               if(_loc6_.extra != null)
               {
                  _loc15_ = _loc6_.extra;
                  _loc11_ = 0;
                  for(_loc16_ in _loc6_.extra)
                  {
                     _loc14_.setValue(_loc16_,_loc15_[_loc16_]);
                  }
               }
            }
            _loc10_.stats = _loc7_.cloneHeroStats();
            _loc10_.heroId = _loc6_.heroId;
            _loc10_.skin = _loc6_.skin;
            _loc10_.id = _loc6_.id;
            _loc10_.name = _loc6_.name;
            _loc10_.state = _loc14_;
            _loc10_.level = _loc6_.level;
            _loc10_.battleOrder = _loc6_.battleOrder;
            _loc10_.skills = _loc8_;
            _loc3_.heroes.push(_loc10_);
         }
         return _loc3_;
      }
      
      public function setAttackers(param1:BattleTeamDescription) : void
      {
      }
      
      public function serializeResult() : *
      {
         return {
            "v":v,
            "b":b,
            "seed":seed,
            "attackers":{
               "input":InputParser.encode(attackers.input),
               "heroes":attackers.getStatesArray()
            },
            "defenders":{
               "input":InputParser.encode(defenders.input),
               "heroes":defenders.getStatesArray()
            }
         };
      }
      
      public function serialize() : *
      {
         return {
            "v":v,
            "b":b,
            "seed":seed,
            "attackers":{
               "input":InputParser.encode(attackers.input),
               "heroes":attackers.heroes
            },
            "defenders":{
               "input":InputParser.encode(defenders.input),
               "heroes":defenders.heroes
            }
         };
      }
      
      public function parseRawTeamResult(param1:BattleTeamDescription, param2:*) : Boolean
      {
         var _loc3_:* = null;
         var _loc5_:* = null as BattleHeroDescription;
         if(param1 == null || param2 == null)
         {
            return false;
         }
         if(param1.heroes == null)
         {
            return false;
         }
         if(int(param1.input.length) > 0)
         {
            param1.input = new Vector.<InputEventDescription>();
         }
         if(Reflect.hasField(param2,"input"))
         {
            _loc3_ = param2.input;
            if(_loc3_ != null)
            {
               if(!InputParser.parse(_loc3_,param1.input))
               {
                  return false;
               }
            }
         }
         _loc3_ = param2.heroes;
         if(_loc3_ == null)
         {
            return true;
         }
         var _loc4_:int = param1.heroes.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = param1.heroes[_loc4_];
            if(_loc5_ == null)
            {
               return false;
            }
            _loc5_.finalState = null;
            if(_loc3_[_loc5_.id])
            {
               _loc5_.finalState = _loc3_[_loc5_.id];
            }
         }
         return true;
      }
      
      public function parseRawResult(param1:*) : Boolean
      {
         return !!parseRawTeamResult(attackers,param1.attackers) && parseRawTeamResult(defenders,param1.defenders);
      }
      
      public function parseRawDescription(param1:*) : void
      {
         v = param1.v;
         seed = param1.seed;
         attackers = BattleData.parseRawTeamDescription(param1.attackers,1);
         defenders = BattleData.parseRawTeamDescription(param1.defenders,-1);
      }
      
      public function isValid() : Boolean
      {
         var _loc2_:* = null as BattleHeroDescription;
         var _loc1_:int = attackers.heroes.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            _loc2_ = attackers.heroes[_loc1_];
            if(!_loc2_.state.equalRaw(_loc2_.finalState))
            {
               return false;
            }
         }
         _loc1_ = defenders.heroes.length;
         while(true)
         {
            _loc1_--;
            if(_loc1_ <= 0)
            {
               break;
            }
            _loc2_ = defenders.heroes[_loc1_];
            if(!_loc2_.state.equalRaw(_loc2_.finalState))
            {
               return false;
            }
         }
         return true;
      }
      
      public function isOver() : Boolean
      {
         var _loc2_:BattleTeamDescription = attackers;
         var _loc3_:int = 0;
         var _loc4_:int = _loc2_.heroes.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            if(!_loc2_.heroes[_loc4_].state.isDead)
            {
               _loc3_++;
            }
         }
         var _loc1_:int = _loc3_;
         _loc2_ = defenders;
         _loc4_ = 0;
         var _loc5_:int = _loc2_.heroes.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            if(!_loc2_.heroes[_loc5_].state.isDead)
            {
               _loc4_++;
            }
         }
         _loc3_ = _loc4_;
         return _loc1_ == 0 || _loc3_ == 0;
      }
      
      public function isActualVersion() : Boolean
      {
         return Boolean(Version.isActualVersion(v));
      }
      
      public function getStars() : int
      {
         var _loc1_:int = attackers.heroes.length;
         var _loc3_:BattleTeamDescription = attackers;
         var _loc4_:int = 0;
         var _loc5_:int = _loc3_.heroes.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= 0)
            {
               break;
            }
            if(!_loc3_.heroes[_loc5_].state.isDead)
            {
               _loc4_++;
            }
         }
         var _loc2_:int = _loc4_;
         if(_loc2_ == _loc1_)
         {
            return 3;
         }
         if(_loc2_ == 0)
         {
            return 0;
         }
         if(_loc2_ == _loc1_ - 1)
         {
            return 2;
         }
         return 1;
      }
      
      public function getAliveTeamMembersCount(param1:BattleTeamDescription) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.heroes.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= 0)
            {
               break;
            }
            if(!param1.heroes[_loc3_].state.isDead)
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
      
      public function clearInput() : void
      {
         attackers.clearInput();
         defenders.clearInput();
      }
   }
}
