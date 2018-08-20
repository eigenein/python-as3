package battle.data
{
   import battle.action.Action;
   import flash.Boot;
   import flash.utils.Dictionary;
   import haxe.ds.StringMap;
   
   public class BattleSkillDescription
   {
      
      public static var TIER_AUTO_ATTACK:int = 0;
      
      public static var TIER_ULTIMATE:int = 1;
      
      public static var TIER_GREEN:int = 2;
      
      public static var TIER_BLUE:int = 3;
      
      public static var TIER_PURPLE:int = 4;
      
      public static var TIER_ARTIFACT:int = 6;
       
      
      public var tier:int;
      
      public var startCast:Function;
      
      public var secondary:Action;
      
      public var rawDescription;
      
      public var range:int;
      
      public var projectile:ProjectileParam;
      
      public var prime:Action;
      
      public var params:Array;
      
      public var modifyRangeByTeamPosition:Boolean;
      
      public var modify:Function;
      
      public var manualCastAvailable:Boolean;
      
      public var level:int;
      
      public var initSkillConditions:Function;
      
      public var initCast:Function;
      
      public var hits:int;
      
      public var hitrate:int;
      
      public var hero:BattleHeroDescription;
      
      public var effect:String;
      
      public var duration:Number;
      
      public var delay:Number;
      
      public var cooldownInitial:Number;
      
      public var cooldown:Number;
      
      public var calculatedParams;
      
      public var behaviorProvider;
      
      public var behavior:String;
      
      public var area:Number;
      
      public var applyCast:Function;
      
      public var animationDelay:Number;
      
      public function BattleSkillDescription(param1:int = 0, param2:BattleHeroDescription = undefined, param3:int = 0, param4:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         modifyRangeByTeamPosition = true;
         animationDelay = 0;
         cooldownInitial = 0;
         cooldown = 0;
         level = param1;
         hero = param2;
         tier = param3;
         if(param4 != null)
         {
            rawDescription = param4;
            parseRawDescription(param4,param1);
         }
         manualCastAvailable = param3 == 1 && cooldown <= 0;
      }
      
      public function toJSON(param1:*) : *
      {
         var _loc3_:* = null;
         var _loc2_:StringMap = new StringMap();
         if(level == level)
         {
            _loc3_ = level;
            if("level" in StringMap.reserved)
            {
               _loc2_.setReserved("level",_loc3_);
            }
            else
            {
               _loc2_.h["level"] = _loc3_;
            }
         }
         if(tier == tier)
         {
            _loc3_ = tier;
            if("tier" in StringMap.reserved)
            {
               _loc2_.setReserved("tier",_loc3_);
            }
            else
            {
               _loc2_.h["tier"] = _loc3_;
            }
         }
         if(behavior != null)
         {
            _loc3_ = behavior;
            if("behavior" in StringMap.reserved)
            {
               _loc2_.setReserved("behavior",_loc3_);
            }
            else
            {
               _loc2_.h["behavior"] = _loc3_;
            }
         }
         if(range != 0 && range == range)
         {
            _loc3_ = range;
            if("range" in StringMap.reserved)
            {
               _loc2_.setReserved("range",_loc3_);
            }
            else
            {
               _loc2_.h["range"] = _loc3_;
            }
         }
         if(cooldown == cooldown)
         {
            _loc3_ = cooldown;
            if("cooldown" in StringMap.reserved)
            {
               _loc2_.setReserved("cooldown",_loc3_);
            }
            else
            {
               _loc2_.h["cooldown"] = _loc3_;
            }
         }
         if(cooldownInitial != 0 && cooldownInitial == cooldownInitial)
         {
            _loc3_ = cooldownInitial;
            if("cooldownInitial" in StringMap.reserved)
            {
               _loc2_.setReserved("cooldownInitial",_loc3_);
            }
            else
            {
               _loc2_.h["cooldownInitial"] = _loc3_;
            }
         }
         if(animationDelay == animationDelay)
         {
            _loc3_ = animationDelay;
            if("animationDelay" in StringMap.reserved)
            {
               _loc2_.setReserved("animationDelay",_loc3_);
            }
            else
            {
               _loc2_.h["animationDelay"] = _loc3_;
            }
         }
         if(prime != null)
         {
            _loc3_ = prime;
            if("prime" in StringMap.reserved)
            {
               _loc2_.setReserved("prime",_loc3_);
            }
            else
            {
               _loc2_.h["prime"] = _loc3_;
            }
         }
         if(secondary != null)
         {
            _loc3_ = secondary;
            if("secondary" in StringMap.reserved)
            {
               _loc2_.setReserved("secondary",_loc3_);
            }
            else
            {
               _loc2_.h["secondary"] = _loc3_;
            }
         }
         if(projectile != null)
         {
            _loc3_ = projectile;
            if("projectile" in StringMap.reserved)
            {
               _loc2_.setReserved("projectile",_loc3_);
            }
            else
            {
               _loc2_.h["projectile"] = _loc3_;
            }
         }
         if(effect != null)
         {
            _loc3_ = effect;
            if("effect" in StringMap.reserved)
            {
               _loc2_.setReserved("effect",_loc3_);
            }
            else
            {
               _loc2_.h["effect"] = _loc3_;
            }
         }
         if(rawDescription != null)
         {
            if(Reflect.hasField(rawDescription,"hitrate"))
            {
               _loc3_ = rawDescription.hitrate;
               if("hitrate" in StringMap.reserved)
               {
                  _loc2_.setReserved("hitrate",_loc3_);
               }
               else
               {
                  _loc2_.h["hitrate"] = _loc3_;
               }
            }
         }
         else
         {
            _loc3_ = hitrate;
            if("hitrate" in StringMap.reserved)
            {
               _loc2_.setReserved("hitrate",_loc3_);
            }
            else
            {
               _loc2_.h["hitrate"] = _loc3_;
            }
         }
         if(duration != 0 && duration == duration)
         {
            _loc3_ = duration;
            if("duration" in StringMap.reserved)
            {
               _loc2_.setReserved("duration",_loc3_);
            }
            else
            {
               _loc2_.h["duration"] = _loc3_;
            }
         }
         if(hits != 0 && hits == hits)
         {
            _loc3_ = hits;
            if("hits" in StringMap.reserved)
            {
               _loc2_.setReserved("hits",_loc3_);
            }
            else
            {
               _loc2_.h["hits"] = _loc3_;
            }
         }
         if(area != 0 && area == area)
         {
            _loc3_ = area;
            if("area" in StringMap.reserved)
            {
               _loc2_.setReserved("area",_loc3_);
            }
            else
            {
               _loc2_.h["area"] = _loc3_;
            }
         }
         if(delay != 0 && delay == delay)
         {
            _loc3_ = delay;
            if("delay" in StringMap.reserved)
            {
               _loc2_.setReserved("delay",_loc3_);
            }
            else
            {
               _loc2_.h["delay"] = _loc3_;
            }
         }
         _loc3_ = getCalculatedParams();
         if("calculatedParams" in StringMap.reserved)
         {
            _loc2_.setReserved("calculatedParams",_loc3_);
         }
         else
         {
            _loc2_.h["calculatedParams"] = _loc3_;
         }
         return _loc2_;
      }
      
      public function setFromCalculatedParams(param1:*) : void
      {
         var _loc4_:* = null as String;
         var _loc2_:* = calculatedParams;
         var _loc3_:int = 0;
         for(_loc4_ in calculatedParams)
         {
            if(Reflect.hasField(param1,_loc4_))
            {
               param1[_loc4_] = calculatedParams[_loc4_];
            }
         }
      }
      
      public function replicateWithLevel(param1:int) : BattleSkillDescription
      {
         var _loc2_:BattleSkillDescription = new BattleSkillDescription(param1,hero,tier,rawDescription);
         return _loc2_;
      }
      
      public function parseRawDescription(param1:*, param2:int) : void
      {
         var _loc3_:int = 0;
         if(!!Reflect.hasField(param1,"behavior") && param1.behavior)
         {
            behavior = param1.behavior;
         }
         if(!!Reflect.hasField(param1,"range") && param1.range)
         {
            range = int(param1.range);
         }
         if(!!Reflect.hasField(param1,"cooldown") && param1.cooldown)
         {
            cooldown = Number(param1.cooldown);
         }
         if(!!Reflect.hasField(param1,"cooldownInitial") && param1.cooldownInitial)
         {
            cooldownInitial = Number(param1.cooldownInitial);
         }
         if(!!Reflect.hasField(param1,"animationDelay") && param1.animationDelay)
         {
            animationDelay = Number(param1.animationDelay);
         }
         if(param1["prime"])
         {
            prime = Action.create(param1.prime);
         }
         if(param1["secondary"])
         {
            secondary = Action.create(param1.secondary);
         }
         if(param1["projectile"])
         {
            projectile = new ProjectileParam(param1.projectile);
         }
         if(!!Reflect.hasField(param1,"effect") && param1.effect)
         {
            effect = param1.effect;
         }
         if(Reflect.hasField(param1,"hitrate"))
         {
            _loc3_ = param1.hitrate;
            hitrate = _loc3_;
         }
         if(!!Reflect.hasField(param1,"duration") && param1.duration)
         {
            duration = Number(param1.duration);
         }
         if(!!Reflect.hasField(param1,"hits") && param1.hits)
         {
            hits = int(param1.hits);
         }
         if(!!Reflect.hasField(param1,"area") && param1.area)
         {
            area = Number(param1.area);
         }
         if(!!Reflect.hasField(param1,"delay") && param1.delay)
         {
            delay = Number(param1.delay);
         }
         if(!!Reflect.hasField(param1,"calculatedParams") && param1.calculatedParams)
         {
            calculatedParams = param1.calculatedParams;
         }
         if(param1["params"])
         {
            params = param1["params"];
         }
      }
      
      public function initialize(param1:*) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as Array;
         var _loc4_:* = null;
         var _loc5_:* = null as String;
         var _loc6_:* = null;
         behaviorProvider = param1;
         if(Reflect.hasField(param1,"initCast"))
         {
            initCast = param1["initCast"];
         }
         if(Reflect.hasField(param1,"startCast"))
         {
            startCast = param1["startCast"];
         }
         if(Reflect.hasField(param1,"applyCast"))
         {
            applyCast = param1["applyCast"];
         }
         if(Reflect.hasField(param1,"modify"))
         {
            modify = param1["modify"];
         }
         if(Reflect.hasField(param1,"initSkillConditions"))
         {
            initSkillConditions = param1["initSkillConditions"];
         }
         if(params != null)
         {
            _loc2_ = 0;
            _loc3_ = params;
            while(_loc2_ < int(_loc3_.length))
            {
               _loc4_ = _loc3_[_loc2_];
               _loc2_++;
               _loc5_ = _loc4_.name;
               if(param1.hasOwnProperty(_loc5_))
               {
                  _loc6_ = getSkillParam(_loc4_);
                  param1[_loc5_] = _loc6_;
               }
            }
         }
         else if(calculatedParams != null)
         {
            setFromCalculatedParams(param1);
         }
      }
      
      public function getSkillParam(param1:*) : *
      {
         var _loc2_:* = null;
         if(param1.value)
         {
            _loc2_ = param1.value;
         }
         else
         {
            _loc2_ = 0;
         }
         if(param1.scale * 0 == 0)
         {
            return _loc2_ + level * param1.scale;
         }
         return _loc2_;
      }
      
      public function getCalculatedParams() : StringMap
      {
         var _loc1_:* = null as StringMap;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc6_:* = null as Array;
         if(calculatedParams != null)
         {
            if(!(calculatedParams is Dictionary))
            {
               _loc1_ = new StringMap();
               _loc2_ = calculatedParams;
               _loc3_ = 0;
               for each(_loc4_ in calculatedParams)
               {
                  _loc5_ = calculatedParams[_loc4_];
                  if(_loc4_ in StringMap.reserved)
                  {
                     _loc1_.setReserved(_loc4_,_loc5_);
                  }
                  else
                  {
                     _loc1_.h[_loc4_] = _loc5_;
                  }
               }
               return _loc1_;
            }
            return calculatedParams.toSerializeable();
         }
         _loc1_ = new StringMap();
         _loc6_ = params;
         _loc3_ = 0;
         for each(_loc2_ in params)
         {
            _loc4_ = _loc2_.name;
            _loc5_ = getSkillParam(_loc2_);
            if(_loc4_ in StringMap.reserved)
            {
               _loc1_.setReserved(_loc4_,_loc5_);
            }
            else
            {
               _loc1_.h[_loc4_] = _loc5_;
            }
         }
         return _loc1_;
      }
      
      public function clone(param1:BattleHeroDescription) : BattleSkillDescription
      {
         var _loc2_:BattleSkillDescription = new BattleSkillDescription(level,param1,tier,null);
         _loc2_.behavior = behavior;
         _loc2_.range = range;
         _loc2_.cooldown = cooldown;
         _loc2_.cooldownInitial = cooldownInitial;
         _loc2_.animationDelay = animationDelay;
         _loc2_.prime = prime;
         _loc2_.secondary = secondary;
         _loc2_.projectile = projectile;
         _loc2_.effect = effect;
         _loc2_.hitrate = hitrate;
         _loc2_.duration = duration;
         _loc2_.hits = hits;
         _loc2_.area = area;
         _loc2_.delay = delay;
         return _loc2_;
      }
   }
}
