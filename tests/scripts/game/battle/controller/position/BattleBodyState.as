package game.battle.controller.position
{
   import battle.objects.BattleBody;
   
   public class BattleBodyState
   {
       
      
      public var position:Number;
      
      public var direction:int;
      
      public var canMove:Boolean;
      
      public var size:Number;
      
      public var mass:Number;
      
      public var speed:Number;
      
      public var target:BattleBody;
      
      public var meleeTypeTargetingRange:Number;
      
      public function BattleBodyState(param1:Number = 1)
      {
         super();
         canMove = true;
         speed = 100;
         this.mass = param1;
         target = null;
         meleeTypeTargetingRange = -1;
      }
   }
}
