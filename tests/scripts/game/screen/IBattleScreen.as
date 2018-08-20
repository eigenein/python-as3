package game.screen
{
   import game.battle.controller.BattleMediatorObjects;
   import game.battle.controller.thread.BattleThread;
   import game.battle.gui.BattleGuiViewBase;
   import game.battle.view.BattleScene;
   import starling.animation.Juggler;
   
   public interface IBattleScreen
   {
       
      
      function get gui() : BattleGuiViewBase;
      
      function get scene() : BattleScene;
      
      function get objects() : BattleMediatorObjects;
      
      function get juggler() : Juggler;
      
      function get thread() : BattleThread;
   }
}
