package game.battle.gui
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class BattleGuiReplayUsersClip extends GuiClipNestedContainer
   {
       
      
      public var attacker:BattleUserPanel;
      
      public var defender:BattleUserPanel;
      
      public var tf_timer:ClipLabel;
      
      public function BattleGuiReplayUsersClip()
      {
         attacker = new BattleUserPanel();
         defender = new BattleUserPanel();
         tf_timer = new ClipLabel();
         super();
         defender.portrait.portrait.direction = -1;
         graphics.touchable = false;
      }
   }
}
