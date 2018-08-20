package game.battle.controller.position
{
   import battle.Team;
   import battle.objects.BattleBody;
   import battle.proxy.IBattleBodyProxy;
   import battle.proxy.ViewPosition;
   import game.battle.view.hero.HeroView;
   
   public class BattleBodyEntry implements IBattleBodyProxy
   {
       
      
      public var body:BattleBody;
      
      public var team:Team;
      
      public var modelState:BattleBodyState;
      
      public var viewState:BattleBodyViewState;
      
      public var viewPosition:HeroViewPositionValue;
      
      public var view:HeroView;
      
      public var position:BattleBodyViewPosition;
      
      public var meleeTypeTargeting:Boolean;
      
      public var rangeTypeTargeting:Boolean;
      
      public var autoAttackRange:Number;
      
      public var meleeTargetingRange:Number;
      
      public var size:Number;
      
      public var ySpeedTarget:Number = 0;
      
      public var ySpeedIntensity:Number = 0.3;
      
      public var ySpeedDuration:Number = 0;
      
      public var ySpeedOldK:Number = 0;
      
      public var ySpeedNewK:Number = 0.5;
      
      public function BattleBodyEntry()
      {
         super();
      }
      
      public function setYPosition(param1:Number) : void
      {
         position.y = param1;
      }
      
      public function setYSpeed(param1:Number, param2:Number, param3:Number = 0, param4:Number = 1) : void
      {
         this.ySpeedTarget = param1;
         this.ySpeedDuration = param2;
         this.ySpeedOldK = param3;
         this.ySpeedNewK = param4;
      }
      
      public function getViewPosition() : ViewPosition
      {
         return position;
      }
   }
}
