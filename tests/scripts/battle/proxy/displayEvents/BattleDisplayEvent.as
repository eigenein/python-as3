package battle.proxy.displayEvents
{
   import flash.Boot;
   
   public class BattleDisplayEvent
   {
       
      
      public var type:String;
      
      public function BattleDisplayEvent(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         SmashGroundEvent;
         TeamEffectEvent;
         SimpleFxEvent;
         CustomManualActionEvent;
         BattleTextEvent;
         CustomAbilityEvent;
         GuiFxEvent;
         TeamUltAnimationEvent;
         TitanArtifactGuiFxEvent;
         type = param1;
      }
   }
}
