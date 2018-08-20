package game.battle.view.hero.crowd
{
   import battle.Team;
   import battle.objects.BattleBody;
   import game.battle.controller.position.BattleBodyState;
   import game.battle.view.hero.HeroView;
   import org.osflash.signals.Signal;
   
   public class CrowdHeroInstance
   {
       
      
      public var body:BattleBody;
      
      public var view:HeroView;
      
      public var state:BattleBodyState;
      
      public var team:Team;
      
      public var hp:int;
      
      public var attackRange:Number;
      
      public var spawnHoldPositionDuration:Number;
      
      public const signal_dispose:Signal = new Signal(CrowdHeroInstance);
      
      public function CrowdHeroInstance()
      {
         super();
      }
      
      public function dispose() : void
      {
         signal_dispose.dispatch(this);
      }
   }
}
