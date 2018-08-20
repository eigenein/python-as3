package battle.log
{
   import battle.Hero;
   import battle.Team;
   import battle.data.BattleSkillDescription;
   import flash.Boot;
   
   public class BattleLogEvent
   {
      
      public static var TIME_BLOCK_ID:int = 255;
       
      
      public var time:Number;
      
      public function BattleLogEvent(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         time = param1.time;
      }
      
      public static function writeHero(param1:BattleLogWriter, param2:Hero) : void
      {
         if(param2 == null)
         {
            param1.writeInt16(0);
         }
         else
         {
            param1.writeInt16(param2.team.direction > 0?param2.desc.id:-param2.desc.id);
         }
      }
      
      public static function writeSkill(param1:BattleLogWriter, param2:BattleSkillDescription) : void
      {
         if(param2 == null)
         {
            param1.writeByte(0);
         }
         else
         {
            param1.writeByte(param2.tier);
         }
      }
      
      public static function writeTeam(param1:BattleLogWriter, param2:Team) : void
      {
         var _loc5_:int = 0;
         param1.writeByte(int(param2.heroes.length));
         var _loc3_:int = 0;
         var _loc4_:int = param2.heroes.length;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            param1.writeByte(param2.heroes[_loc5_].desc.id);
         }
      }
      
      public function toStringShort() : String
      {
         return "";
      }
      
      public function toString(param1:BattleLogNameResolver) : String
      {
         return "";
      }
      
      public function readTeam(param1:BattleLogReader) : Vector.<int>
      {
         var _loc5_:int = 0;
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:int = param1.readByte();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc4_++;
            _loc5_ = _loc4_;
            _loc2_.push(int(param1.readByte()));
         }
         return _loc2_;
      }
      
      public function readSkill(param1:BattleLogReader) : int
      {
         return int(param1.readByte());
      }
   }
}
