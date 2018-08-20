package game.mechanics.grand.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.MiniHeroTeamRenderer;
   
   public class TooltipGrandEnemyTeamClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label:ClipLabel;
      
      public var team:MiniHeroTeamRenderer;
      
      public function TooltipGrandEnemyTeamClip()
      {
         super();
      }
   }
}
