package battle.log
{
   import battle.Hero;
   import battle.skills.Effect;
   import flash.Boot;
   
   public class BattleLogEventHeroEffectRemove extends BattleLogEventHero
   {
      
      public static var index:int;
       
      
      public var effect:String;
      
      public function BattleLogEventHeroEffectRemove(param1:BattleLogReader = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1);
         effect = param1.readEncodedString();
      }
      
      public static function write(param1:BattleLogWriter, param2:Hero, param3:Effect) : void
      {
         BattleLogEvent.writeHero(param1,param2);
         param1.writeEncodedString(param3.ident);
      }
      
      override public function toStringShort() : String
      {
         return "effect " + heroId + " " + effect + " remove";
      }
      
      override public function toString(param1:BattleLogNameResolver) : String
      {
         return "С героя " + param1.hero(heroId) + " снят эффект " + effect;
      }
   }
}
