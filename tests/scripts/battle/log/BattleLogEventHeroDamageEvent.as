package battle.log
{
   import battle.DamageValue;
   import flash.Boot;
   
   public class BattleLogEventHeroDamageEvent extends BattleLogEvent
   {
      
      public static var index:int;
      
      public static var TYPE_NULL:DamageEventType = new DamageEventType(0,"unknown","Не применён по неизвестной причине");
      
      public static var TYPE_MISS:DamageEventType = new DamageEventType(1,"miss","Мимо (miss)");
      
      public static var TYPE_DODGE:DamageEventType = new DamageEventType(2,"dodge","Уворот (dodge)");
      
      public static var TYPE_ZERO:DamageEventType = new DamageEventType(3,"zero","Нулевой урон");
       
      
      public var type:DamageEventType;
      
      public function BattleLogEventHeroDamageEvent(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         var _loc2_:int = param1.readByte();
         if(_loc2_ == BattleLogEventHeroDamageEvent.TYPE_MISS.id)
         {
            type = BattleLogEventHeroDamageEvent.TYPE_MISS;
         }
         else if(_loc2_ == BattleLogEventHeroDamageEvent.TYPE_DODGE.id)
         {
            type = BattleLogEventHeroDamageEvent.TYPE_DODGE;
         }
         else if(_loc2_ == BattleLogEventHeroDamageEvent.TYPE_ZERO.id)
         {
            type = BattleLogEventHeroDamageEvent.TYPE_ZERO;
         }
         else
         {
            type = BattleLogEventHeroDamageEvent.TYPE_NULL;
         }
      }
      
      public static function write(param1:BattleLogWriter, param2:DamageValue) : void
      {
         if(param2.missed)
         {
            param1.writeByte(BattleLogEventHeroDamageEvent.TYPE_MISS.id);
         }
         else if(param2.dodged)
         {
            param1.writeByte(BattleLogEventHeroDamageEvent.TYPE_DODGE.id);
         }
         else if(param2.resultValue <= 0)
         {
            param1.writeByte(BattleLogEventHeroDamageEvent.TYPE_ZERO.id);
         }
         else
         {
            param1.writeByte(BattleLogEventHeroDamageEvent.TYPE_NULL.id);
         }
      }
      
      override public function toStringShort() : String
      {
         return "   " + type.name;
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return type.locale;
      }
   }
}
