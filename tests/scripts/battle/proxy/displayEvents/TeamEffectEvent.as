package battle.proxy.displayEvents
{
   import battle.skills.TeamEffect;
   import flash.Boot;
   
   public class TeamEffectEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "TeamEffect";
       
      
      public var icon:String;
      
      public var effect:TeamEffect;
      
      public function TeamEffectEvent(param1:TeamEffect = undefined, param2:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(TeamEffectEvent.TYPE);
         effect = param1;
         icon = param2;
      }
   }
}
