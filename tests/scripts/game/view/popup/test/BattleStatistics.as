package game.view.popup.test
{
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import flash.utils.Dictionary;
   
   public class BattleStatistics
   {
       
      
      private var durationSamples:Vector.<Number>;
      
      private var heroesMap:Dictionary;
      
      private var _isEmpty:Boolean = true;
      
      public function BattleStatistics(param1:int)
      {
         heroesMap = new Dictionary();
         super();
         durationSamples = new Vector.<Number>();
      }
      
      public function get isEmpty() : Boolean
      {
         return _isEmpty;
      }
      
      public function get minUnitId() : int
      {
         var _loc2_:* = 2147483647;
         var _loc4_:int = 0;
         var _loc3_:* = heroesMap;
         for(var _loc1_ in heroesMap)
         {
            if(_loc1_ < _loc2_)
            {
               _loc2_ = _loc1_;
            }
         }
         return _loc2_;
      }
      
      public function get maxUnitId() : int
      {
         var _loc2_:* = 0;
         var _loc4_:int = 0;
         var _loc3_:* = heroesMap;
         for(var _loc1_ in heroesMap)
         {
            if(_loc1_ > _loc2_)
            {
               _loc2_ = _loc1_;
            }
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         _isEmpty = true;
         heroesMap = new Dictionary();
         durationSamples.length = 0;
      }
      
      public function collectDuration(param1:Number) : void
      {
         durationSamples.push(param1);
      }
      
      public function collect(param1:BattleData, param2:Boolean, param3:Boolean) : void
      {
         _isEmpty = false;
         var _loc4_:Vector.<BattleHeroDescription> = param1.attackers.heroes;
         var _loc5_:Vector.<BattleHeroDescription> = param1.defenders.heroes;
         if(!param2)
         {
            _loc4_ = null;
         }
         if(!param3)
         {
            _loc5_ = null;
         }
         if(param1.getStars() > 0)
         {
            collectFromTeams(_loc4_,_loc5_);
         }
         else
         {
            collectFromTeams(_loc5_,_loc4_);
         }
      }
      
      public function getReport() : String
      {
         var _loc3_:int = 0;
         if(_isEmpty)
         {
            return "";
         }
         var _loc5_:* = 2147483647;
         var _loc1_:* = 0;
         var _loc7_:int = 0;
         var _loc6_:* = heroesMap;
         for(var _loc4_ in heroesMap)
         {
            if(_loc4_ < _loc5_)
            {
               _loc5_ = _loc4_;
            }
            if(_loc4_ > _loc1_)
            {
               _loc1_ = _loc4_;
            }
         }
         var _loc2_:String = (heroesMap[_loc5_] as HeroStatisticsEntry).toString(_loc5_,_loc1_);
         _loc3_ = _loc5_ + 1;
         while(_loc3_ <= _loc1_)
         {
            if(heroesMap[_loc3_])
            {
               _loc2_ = _loc2_ + ("\n" + (heroesMap[_loc3_] as HeroStatisticsEntry).toString(_loc5_,_loc1_));
            }
            else
            {
               _loc2_ = _loc2_ + "\n";
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getHeroWinrate(param1:int) : String
      {
         if(_isEmpty)
         {
            return " - ";
         }
         var _loc4_:* = 2147483647;
         var _loc2_:* = 0;
         var _loc6_:int = 0;
         var _loc5_:* = heroesMap;
         for(var _loc3_ in heroesMap)
         {
            if(_loc3_ < _loc4_)
            {
               _loc4_ = _loc3_;
            }
            if(_loc3_ > _loc2_)
            {
               _loc2_ = _loc3_;
            }
         }
         return getHeroById(param1).toShortString(_loc4_,_loc2_);
      }
      
      public function getShortReport() : String
      {
         var _loc3_:int = 0;
         if(_isEmpty)
         {
            return "";
         }
         var _loc5_:* = 2147483647;
         var _loc1_:* = 0;
         var _loc7_:int = 0;
         var _loc6_:* = heroesMap;
         for(var _loc4_ in heroesMap)
         {
            if(_loc4_ < _loc5_)
            {
               _loc5_ = _loc4_;
            }
            if(_loc4_ > _loc1_)
            {
               _loc1_ = _loc4_;
            }
         }
         var _loc2_:String = (heroesMap[_loc5_] as HeroStatisticsEntry).toShortString(_loc5_,_loc1_);
         _loc3_ = _loc5_ + 1;
         while(_loc3_ <= _loc1_)
         {
            if(heroesMap[_loc3_])
            {
               _loc2_ = _loc2_ + ("\n" + (heroesMap[_loc3_] as HeroStatisticsEntry).toShortString(_loc5_,_loc1_));
            }
            else
            {
               _loc2_ = _loc2_ + "\n";
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getDurationReport() : String
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function collectFromTeams(param1:Vector.<BattleHeroDescription>, param2:Vector.<BattleHeroDescription>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function getHeroById(param1:uint) : HeroStatisticsEntry
      {
         var _loc2_:HeroStatisticsEntry = heroesMap[param1];
         if(_loc2_ == null)
         {
            _loc2_ = new HeroStatisticsEntry(param1);
            heroesMap[param1] = new HeroStatisticsEntry(param1);
         }
         return _loc2_;
      }
      
      protected function sec(param1:Number) : String
      {
         return String(Math.round(param1 * 10) / 10);
      }
   }
}

import flash.utils.Dictionary;

class HeroStatisticsEntry
{
    
   
   public var id:uint;
   
   public var K:Dictionary;
   
   public var S:Dictionary;
   
   public var kdr:RateCounter;
   
   function HeroStatisticsEntry(param1:uint)
   {
      K = new Dictionary();
      S = new Dictionary();
      super();
      this.id = param1;
      kdr = new RateCounter();
   }
   
   public function win(param1:HeroStatisticsEntry) : void
   {
      if(param1 == null)
      {
         return;
      }
      getCounter(K,param1.id).value++;
      getCounter(K,param1.id).total++;
      getCounter(param1.K,id).total++;
   }
   
   public function team(param1:HeroStatisticsEntry, param2:Boolean) : void
   {
      if(param1 == null)
      {
         return;
      }
      if(param2)
      {
         getCounter(S,param1.id).value++;
         getCounter(param1.S,id).value++;
      }
      getCounter(S,param1.id).total++;
      getCounter(param1.S,id).total++;
   }
   
   public function toShortString(param1:int, param2:int) : String
   {
      var _loc3_:Number = kdr.rate;
      var _loc4_:String = _loc3_ == 0?"":String(Math.round(_loc3_ * 100) / 100);
      return _loc4_;
   }
   
   public function toString(param1:int, param2:int) : String
   {
      var _loc7_:* = 0;
      var _loc10_:* = null;
      var _loc5_:* = null;
      var _loc6_:Number = kdr.rate;
      var _loc8_:String = _loc6_ == 0?"":String(Math.round(_loc6_ * 100) / 100);
      var _loc3_:String = id + "\t" + (kdr.total == 0?"":kdr.total) + "\t" + _loc8_ + "\t\t\t";
      var _loc9_:String = "";
      var _loc4_:String = "";
      _loc7_ = param1;
      while(_loc7_ <= param2)
      {
         _loc10_ = getCounter(K,_loc7_);
         _loc5_ = getCounter(S,_loc7_);
         if(_loc10_)
         {
            _loc9_ = _loc9_ + _loc10_;
         }
         if(_loc5_)
         {
            _loc4_ = _loc4_ + _loc5_;
         }
         if(_loc7_ != param2)
         {
            _loc9_ = _loc9_ + "\t";
            _loc4_ = _loc4_ + "\t";
         }
         _loc7_++;
      }
      _loc3_ = _loc3_ + (_loc9_ + "\t\t\t\t" + _loc4_);
      return _loc3_;
   }
   
   private function getCounter(param1:Dictionary, param2:int) : RateCounter
   {
      var _loc3_:RateCounter = param1[param2];
      if(_loc3_ == null)
      {
         _loc3_ = new RateCounter();
         param1[param2] = new RateCounter();
      }
      return _loc3_;
   }
   
   private function p(param1:Number) : String
   {
      if(param1 * 100 < 10)
      {
         return "0" + int(param1 * 100);
      }
      return String(int(param1 * 100));
   }
}

class RateCounter
{
    
   
   public var value:int;
   
   public var total:int;
   
   function RateCounter()
   {
      super();
      total = 0;
      value = 0;
   }
   
   public function get rate() : Number
   {
      return total == 0?0:Number(value / total * 100);
   }
   
   public function toString() : String
   {
      return total == 0?"":String(Math.round(value / total * 10000) / 100);
   }
}
