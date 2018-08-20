package game.battle.gui.teamskill
{
   import starling.display.DisplayObject;
   
   public class BattleGuiFx
   {
       
      
      protected var _isDisposed:Boolean;
      
      public function BattleGuiFx()
      {
         super();
      }
      
      public function dispose() : void
      {
         _isDisposed = true;
      }
      
      public function get graphics() : DisplayObject
      {
         return null;
      }
      
      public function get isDisposed() : Boolean
      {
         return _isDisposed;
      }
      
      public function advanceTime(param1:Number) : void
      {
      }
   }
}
