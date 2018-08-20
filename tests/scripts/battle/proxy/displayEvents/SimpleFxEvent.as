package battle.proxy.displayEvents
{
   import battle.Hero;
   import battle.data.BattleSkillDescription;
   import battle.proxy.idents.EffectAnimationIdent;
   import flash.Boot;
   
   public class SimpleFxEvent extends BattleDisplayEvent
   {
      
      public static var TYPE:String = "SimpleFx";
       
      
      public var zOffset:Number;
      
      public var yTargetHero:Hero;
      
      public var targetHero:Hero;
      
      public var position:Number;
      
      public var playOnPause:Boolean;
      
      public var fxSkill:BattleSkillDescription;
      
      public var fx:EffectAnimationIdent;
      
      public var explicitDirection:int;
      
      public function SimpleFxEvent()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(SimpleFxEvent.TYPE);
      }
   }
}
