package battle.log
{
   public class BattleLogEncoder
   {
      
      public static var eventsIsIndexed:Boolean = false;
      
      public static var events:Array = [BattleLogEventString,BattleLogEventHeroInput,BattleLogEventInputAuto,BattleLogEventHeroSkillCast,BattleLogEventHeroUlt,BattleLogEventHeroUltImmediate,BattleLogEventHeroUltImmediateInterrupting,BattleLogEventTimesUp,BattleLogEventTeamEmpty,BattleLogEventHeroDead,BattleLogEventHeroMove,BattleLogEventHeroHp,BattleLogEventHeroEnergy,BattleLogEventHeroEffect,BattleLogEventHeroEffectRemove,BattleLogEventHeroDamage,BattleLogEventHeroDamageEvent,BattleLogEventCustomHeroInput,BattleLogEventTeamInput];
       
      
      public function BattleLogEncoder()
      {
      }
      
      public static function init() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:* = null as Array;
         var _loc4_:* = null as Class;
         if(!BattleLogEncoder.eventsIsIndexed)
         {
            BattleLogEncoder.eventsIsIndexed = true;
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = BattleLogEncoder.events;
            while(_loc2_ < int(_loc3_.length))
            {
               _loc4_ = _loc3_[_loc2_];
               _loc2_++;
               _loc4_.index = _loc1_;
               _loc1_++;
            }
         }
      }
      
      public static function read(param1:BattleLogReader) : Vector.<BattleLogEvent>
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as Class;
         var _loc6_:* = null as BattleLogEvent;
         var _loc2_:Vector.<BattleLogEvent> = new Vector.<BattleLogEvent>();
         param1.time = 0;
         var _loc3_:Array = [param1];
         while(int(param1.b.position) < int(param1.b.length))
         {
            _loc4_ = param1.readByte();
            param1.currentEventBytePosition = int(param1.b.position);
            param1.currentEventId = _loc4_;
            if(_loc4_ == BattleLogEvent.TIME_BLOCK_ID)
            {
               param1.time = int(param1.readInt16()) / 100;
            }
            else
            {
               _loc5_ = BattleLogEncoder.events[_loc4_];
               _loc6_ = Type.createInstance(_loc5_,_loc3_);
               _loc2_.push(_loc6_);
            }
            param1.lastEventId = _loc4_;
         }
         return _loc2_;
      }
      
      public static function decodeToString(param1:String) : String
      {
         var _loc7_:int = 0;
         var _loc8_:* = null as BattleLogEvent;
         param1 = new EReg("\n","g").replace(param1,"");
         var _loc2_:Vector.<BattleLogEvent> = BattleLogEncoder.read(new BattleLogReader(param1));
         var _loc3_:* = -1;
         var _loc4_:String = "";
         var _loc5_:int = 0;
         var _loc6_:int = _loc2_.length;
         while(_loc5_ < _loc6_)
         {
            _loc5_++;
            _loc7_ = _loc5_;
            _loc8_ = _loc2_[_loc7_];
            if(_loc3_ != -1)
            {
               _loc4_ = _loc4_ + "\n";
            }
            if(_loc3_ != _loc8_.time)
            {
               _loc3_ = Number(_loc8_.time);
               _loc4_ = _loc4_ + (_loc3_ + ":\n");
            }
            _loc4_ = _loc4_ + ("   " + _loc8_.toStringShort());
         }
         return _loc4_;
      }
   }
}
