package battle.data
{
   import battle.BattleConfig;
   import battle.HeroStats;
   import battle.stats.ElementStats;
   import battle.utils.Util;
   import flash.Boot;
   
   public class BattleHeroDescription
   {
       
      
      public var stats:HeroStats;
      
      public var state:HeroState;
      
      public var skin:int;
      
      public var skills:Vector.<BattleSkillDescription>;
      
      public var scale:Number;
      
      public var name:String;
      
      public var level:int;
      
      public var id:int;
      
      public var heroId:int;
      
      public var finalState;
      
      public var element:ElementStats;
      
      public var battleOrder:int;
      
      public function BattleHeroDescription()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         scale = 0;
         skills = new Vector.<BattleSkillDescription>();
      }
      
      public static function inTeamSortFunction(param1:BattleHeroDescription, param2:BattleHeroDescription) : int
      {
         if(param1.battleOrder == param2.battleOrder)
         {
            if(param1.id > param2.id)
            {
               return 1;
            }
            return -1;
         }
         if(param1.battleOrder > param2.battleOrder)
         {
            return 1;
         }
         return -1;
      }
      
      public static function create(param1:BattleHeroDataObject) : BattleHeroDescription
      {
         var _loc2_:BattleHeroDescription = new BattleHeroDescription();
         _loc2_.stats = param1.cloneHeroStats();
         _loc2_.id = param1.id;
         _loc2_.name = param1.name;
         _loc2_.level = param1.level;
         _loc2_.skin = param1.skin;
         _loc2_.scale = param1.scale;
         if(param1.element != null)
         {
            _loc2_.element = new ElementStats();
            _loc2_.element.element = param1.element;
            _loc2_.element.elementAttack = param1.elementAttack;
            _loc2_.element.elementArmor = param1.elementArmor;
            _loc2_.element.elementSpiritLevel = param1.elementSpiritLevel;
            _loc2_.element.elementSpiritPower = param1.elementSpiritPower;
         }
         return _loc2_;
      }
      
      public function setState(param1:*) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null as String;
         if(param1 == null)
         {
            return;
         }
         state = new HeroState(param1.hp,param1.energy,param1.isDead);
         if(param1.extra != null)
         {
            _loc2_ = param1.extra;
            _loc3_ = 0;
            for(_loc4_ in param1.extra)
            {
               state.setValue(_loc4_,_loc2_[_loc4_]);
            }
         }
      }
      
      public function getInitialState(param1:BattleConfig) : HeroState
      {
         var _loc5_:* = null as BattleSkillDescription;
         var _loc6_:int = 0;
         var _loc2_:HeroStats = stats.cloneHeroStats();
         var _loc3_:Vector.<BattleSkillDescription> = skills;
         var _loc4_:int = _loc3_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc5_ = _loc3_[_loc4_];
            if(_loc5_.behaviorProvider == null)
            {
               return HeroState.INVALID;
            }
            if(int(param1.passiveHpBuffs.indexOf(_loc5_.behavior)) != -1)
            {
               if(_loc5_.behavior == "PassiveSelfBuff" || _loc5_.behavior == "PassiveAllyTeamBuff")
               {
                  _loc2_.addBuff(_loc5_.behaviorProvider.statName,Number(_loc5_.prime.getValue(_loc2_,_loc5_.level)));
               }
               else if(_loc5_.behavior == "PveModifier")
               {
                  _loc6_ = Util.skillInt((int(Number(_loc2_.hp + 40 * _loc2_.strength))) * _loc5_.prime.getValue(_loc2_,_loc5_.level));
                  _loc2_.addBuff("hp",_loc6_);
               }
            }
         }
         return new HeroState(int(Number(_loc2_.hp + 40 * _loc2_.strength)));
      }
      
      public function createStatSkills() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         if(element != null && element.elementSpiritPower > 0)
         {
            _loc1_ = element.elementSpiritPower;
            _loc2_ = element.elementSpiritLevel;
            skills.push(ArtifactSkillDescriptionFactory.createTitan(this,element.element,_loc1_,_loc2_));
         }
      }
   }
}
