package game.battle.controller.position
{
   import battle.proxy.ViewPosition;
   
   public class BattleBodyViewPosition extends ViewPosition
   {
       
      
      public var vy:Number = 0;
      
      public var mobility:Number = 0;
      
      public var movementDirection:int = 0;
      
      public var allyCollision:Number = 0;
      
      public var targetYAiming:Number = 0;
      
      public var targetYAimingCount:int = 0;
      
      public function BattleBodyViewPosition(param1:Number = 0, param2:Number = 0, param3:Number = 0)
      {
         super(param1,param2,param3);
      }
   }
}
