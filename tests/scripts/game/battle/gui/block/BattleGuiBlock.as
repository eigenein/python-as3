package game.battle.gui.block
{
   import game.battle.gui.BattleGuiViewBase;
   
   public class BattleGuiBlock
   {
       
      
      protected var base:BattleGuiViewBase;
      
      public function BattleGuiBlock()
      {
         super();
      }
      
      public function dispose() : void
      {
         if(base)
         {
            unsubscribe(base);
            base = null;
         }
      }
      
      public function init(param1:BattleGuiViewBase) : void
      {
         this.base = param1;
         subscribe(param1);
      }
      
      public function advanceTime(param1:Number, param2:Number) : void
      {
      }
      
      protected function subscribe(param1:BattleGuiViewBase) : void
      {
      }
      
      protected function unsubscribe(param1:BattleGuiViewBase) : void
      {
      }
   }
}
