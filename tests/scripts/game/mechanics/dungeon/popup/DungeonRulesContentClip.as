package game.mechanics.dungeon.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class DungeonRulesContentClip extends GuiClipNestedContainer
   {
       
      
      public var tf_rules:ClipLabel;
      
      public var layout:ClipLayout;
      
      public function DungeonRulesContentClip()
      {
         tf_rules = new ClipLabel();
         layout = ClipLayout.verticalCenter(8,tf_rules);
         super();
      }
   }
}
