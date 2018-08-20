package game.view.popup.artifacts
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class HeroArtifactLevelClip extends GuiClipNestedContainer
   {
       
      
      public var tf:ClipLabel;
      
      public var bg:GuiClipImage;
      
      public function HeroArtifactLevelClip()
      {
         tf = new ClipLabel();
         bg = new GuiClipImage();
         super();
      }
   }
}
