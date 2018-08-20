package battle.data
{
   import battle.Hero;
   import battle.Team;
   import flash.Boot;
   
   public class BattleTeamDescription
   {
      
      public static var EMPTY_ARRAY:Array = [];
       
      
      public var owner:String;
      
      public var logInput:Boolean;
      
      public var libver:String;
      
      public var input:Vector.<InputEventDescription>;
      
      public var initialized:Boolean;
      
      public var heroes:Vector.<BattleHeroDescription>;
      
      public var effectsObject;
      
      public var direction:int;
      
      public var autoCastOnStart:Boolean;
      
      public function BattleTeamDescription()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         initialized = false;
         autoCastOnStart = true;
         heroes = new Vector.<BattleHeroDescription>();
         input = new Vector.<InputEventDescription>();
         logInput = false;
      }
      
      public static function initializeHeroSkills(param1:BattleHeroDescription) : void
      {
         var _loc3_:* = null as BattleSkillDescription;
         var _loc4_:int = 0;
         var _loc7_:* = null as Class;
         var _loc2_:Vector.<BattleSkillDescription> = param1.skills;
         var _loc5_:int = 0;
         var _loc6_:int = _loc2_.length;
         while(true)
         {
            _loc5_++;
            if(_loc5_ >= _loc6_)
            {
               break;
            }
            _loc3_ = _loc2_[_loc5_];
            _loc4_ = _loc5_;
            while(_loc4_ > 0 && _loc2_[_loc4_ - 1].tier > _loc3_.tier)
            {
               _loc2_[_loc4_] = _loc2_[_loc4_ - 1];
               _loc4_--;
            }
            _loc2_[_loc4_] = _loc3_;
         }
         _loc4_ = _loc2_.length;
         while(true)
         {
            _loc4_--;
            if(_loc4_ <= 0)
            {
               break;
            }
            _loc7_ = Type.resolveClass("code." + _loc2_[_loc4_].behavior);
            _loc2_[_loc4_].initialize(Type.createInstance(_loc7_,BattleTeamDescription.EMPTY_ARRAY));
         }
      }
      
      public function sortByOrder() : void
      {
         var _loc1_:* = null as BattleHeroDescription;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = heroes.length;
         while(true)
         {
            _loc3_++;
            if(_loc3_ >= _loc4_)
            {
               break;
            }
            _loc1_ = heroes[_loc3_];
            _loc2_ = _loc3_;
            while(_loc2_ > 0 && heroes[_loc2_ - 1].battleOrder > _loc1_.battleOrder)
            {
               heroes[_loc2_] = heroes[_loc2_ - 1];
               _loc2_--;
            }
            heroes[_loc2_] = _loc1_;
         }
      }
      
      public function setUserInput(param1:Boolean) : void
      {
         if(param1)
         {
            autoCastOnStart = false;
            input.push(new InputEventDescription(0,"auto",-1,0));
         }
         logInput = true;
      }
      
      public function logTeamInput(param1:int, param2:Number, param3:int) : void
      {
         input.push(new InputEventDescription(param2,"teamCustom",-1,param3,param1));
      }
      
      public function logCustomEvent(param1:Hero, param2:int, param3:Number, param4:int) : void
      {
         input.push(new InputEventDescription(param3,"custom",param1.desc.id,param4,param2));
      }
      
      public function logCastEvent(param1:Hero, param2:Number, param3:int) : void
      {
         input.push(new InputEventDescription(param2,"cast",param1.desc.id,param3));
      }
      
      public function logAutoToggleEvent(param1:Team) : void
      {
         input.push(new InputEventDescription(param1.engine.timeline.time,"auto",-1,param1.engine.timeline.eventIndex));
      }
      
      public function initialize(param1:Function) : void
      {
         var _loc3_:* = null as Vector.<BattleSkillDescription>;
         var _loc4_:* = null as BattleSkillDescription;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as String;
         if(initialized)
         {
            return;
         }
         initialized = true;
         var _loc2_:int = heroes.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            _loc3_ = heroes[_loc2_].skills;
            _loc6_ = 0;
            _loc7_ = _loc3_.length;
            while(true)
            {
               _loc6_++;
               if(_loc6_ >= _loc7_)
               {
                  break;
               }
               _loc4_ = _loc3_[_loc6_];
               _loc5_ = _loc6_;
               while(_loc5_ > 0 && _loc3_[_loc5_ - 1].tier > _loc4_.tier)
               {
                  _loc3_[_loc5_] = _loc3_[_loc5_ - 1];
                  _loc5_--;
               }
               _loc3_[_loc5_] = _loc4_;
            }
            _loc5_ = _loc3_.length;
            while(true)
            {
               _loc5_--;
               if(_loc5_ <= 0)
               {
                  break;
               }
               _loc8_ = _loc3_[_loc5_].behavior;
               _loc8_ = _loc8_.charAt(0).toUpperCase() + _loc8_.substr(1);
               _loc3_[_loc5_].initialize(param1(_loc8_));
            }
         }
      }
      
      public function getStatesArray() : *
      {
         var _loc3_:* = null as BattleHeroDescription;
         var _loc1_:* = {};
         var _loc2_:int = heroes.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            _loc3_ = heroes[_loc2_];
            if(!_loc3_.state.isDead)
            {
               _loc1_[_loc3_.id] = _loc3_.state.toJSON(null);
            }
         }
         return _loc1_;
      }
      
      public function getHeroById(param1:int) : BattleHeroDescription
      {
         var _loc2_:int = heroes.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(heroes[_loc2_].id == param1)
            {
               return heroes[_loc2_];
            }
         }
         return null;
      }
      
      public function clearInput() : void
      {
         input = new Vector.<InputEventDescription>();
      }
      
      public function applyEffects(param1:*) : void
      {
         if(param1 == null)
         {
            effectsObject = null;
            return;
         }
         effectsObject = param1;
      }
   }
}
