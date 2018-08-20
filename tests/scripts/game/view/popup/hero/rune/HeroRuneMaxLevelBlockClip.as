package game.view.popup.hero.rune
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class HeroRuneMaxLevelBlockClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_max_level:ClipLabel;
      
      public var tf_label_next_level:ClipLabel;
      
      public var layout:ClipLayout;
      
      public function HeroRuneMaxLevelBlockClip()
      {
         tf_label_max_level = new ClipLabel();
         tf_label_next_level = new ClipLabel();
         layout = ClipLayout.verticalMiddleCenter(0,tf_label_max_level,tf_label_next_level);
         super();
      }
   }
}
