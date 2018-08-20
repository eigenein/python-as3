package battle.data
{
   import battle.skills.Context;
   import flash.Boot;
   import haxe.ds.StringMap;
   import haxe.ds._StringMap.StringMapKeysIterator;
   
   public class HeroState
   {
      
      public static var INVALID:HeroState = new HeroState(0,1000,true);
      
      public static var DEAD_HEALTH:Number = 0;
       
      
      public var statistics:BattleHeroStatistics;
      
      public var isDead:Boolean;
      
      public var hpLastHashed:int;
      
      public var hp:int;
      
      public var flags:HeroStateFlags;
      
      public var energy:Number;
      
      public function HeroState(param1:int = 0, param2:Number = 0, param3:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         hp = 0;
         hpLastHashed = 1694084416;
         if((hp ^ 1694084416) != hpLastHashed)
         {
            Context.engine.data.b = 1;
         }
         hpLastHashed = param1 ^ 1694084416;
         hp = param1;
         energy = param2;
         isDead = param3;
         statistics = new BattleHeroStatistics();
      }
      
      public function toJSON(param1:*) : *
      {
         return serialize();
      }
      
      public function setValue(param1:String, param2:*) : void
      {
         if(flags == null)
         {
            flags = new HeroStateFlags();
         }
         var _loc3_:StringMap = flags.data;
         var _loc4_:* = param2;
         if(param1 in StringMap.reserved)
         {
            _loc3_.setReserved(param1,_loc4_);
         }
         else
         {
            _loc3_.h[param1] = _loc4_;
         }
      }
      
      public function setDead() : void
      {
         if((hp ^ 1694084416) != hpLastHashed)
         {
            Context.engine.data.b = 1;
         }
         hpLastHashed = 0 ^ 1694084416;
         hp = 0;
         isDead = true;
         energy = 0;
      }
      
      public function serialize() : *
      {
         var _loc2_:* = null;
         var _loc3_:* = null as StringMap;
         var _loc4_:* = null;
         var _loc5_:* = null as String;
         var _loc1_:* = {
            "hp":hp,
            "energy":energy,
            "isDead":isDead
         };
         if(flags != null)
         {
            _loc2_ = {};
            _loc3_ = flags.data;
            _loc4_ = new StringMapKeysIterator(_loc3_.h,_loc3_.rh);
            while(_loc4_.hasNext())
            {
               _loc5_ = _loc4_.next();
               _loc3_ = flags.data;
               if(_loc5_ in StringMap.reserved)
               {
                  _loc2_[_loc5_] = _loc3_.getReserved(_loc5_);
               }
               else
               {
                  _loc2_[_loc5_] = _loc3_.h[_loc5_];
               }
            }
            _loc1_["extra"] = _loc2_;
         }
         return _loc1_;
      }
      
      public function getValue(param1:String) : *
      {
         if(flags == null)
         {
            return 0;
         }
         var _loc2_:StringMap = flags.data;
         if(param1 in StringMap.reserved)
         {
            return _loc2_.getReserved(param1);
         }
         return _loc2_.h[param1];
      }
      
      public function equalRaw(param1:*) : Boolean
      {
         if(param1 == null)
         {
            return isDead;
         }
         if(int(hp) != int(Number(param1.hp)))
         {
            return false;
         }
         if(int(energy) != int(Number(param1.energy)))
         {
            return false;
         }
         if(isDead != param1.isDead)
         {
            return false;
         }
         var _loc2_:* = null;
         if(Reflect.hasField(param1,"extra"))
         {
            _loc2_ = param1.extra;
         }
         if(flags != null)
         {
            if(_loc2_ != null)
            {
               return Boolean(flags.equalRaw(_loc2_));
            }
            return false;
         }
         return _loc2_ == null;
      }
      
      public function equal(param1:HeroState) : Boolean
      {
         if(!(hp == param1.hp && energy == param1.energy && isDead == param1.isDead))
         {
            return false;
         }
         if(flags == null && param1.flags == null)
         {
            return true;
         }
         if(flags != null || param1.flags != null)
         {
            return false;
         }
         return Boolean(flags.equal(param1.flags));
      }
      
      public function apply(param1:HeroState) : void
      {
         var _loc2_:int = hp;
         if((param1.hp ^ 1694084416) != param1.hpLastHashed)
         {
            Context.engine.data.b = 1;
         }
         param1.hpLastHashed = _loc2_ ^ 1694084416;
         param1.hp = _loc2_;
         param1.energy = energy;
         param1.isDead = isDead;
      }
   }
}
