package game.view.popup.artifacts
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class HeroArtifactStatsClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:ClipLabel;
      
      public var tf_stats:SpecialClipLabel;
      
      public var layout_container:ClipLayout;
      
      public function HeroArtifactStatsClip()
      {
         tf_title = new ClipLabel();
         tf_stats = new SpecialClipLabel();
         layout_container = ClipLayout.horizontalMiddleCentered(0,tf_stats);
         super();
      }
   }
}
