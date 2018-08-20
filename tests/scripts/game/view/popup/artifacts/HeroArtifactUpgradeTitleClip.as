package game.view.popup.artifacts
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class HeroArtifactUpgradeTitleClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:SpecialClipLabel;
      
      public function HeroArtifactUpgradeTitleClip()
      {
         tf_title = new SpecialClipLabel();
         super();
      }
   }
}
