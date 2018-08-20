package game.view.popup.hero
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class HeroPopupStatListItemRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label:SpecialClipLabel;
      
      public function HeroPopupStatListItemRendererClip()
      {
         tf_label = new SpecialClipLabel(true);
         super();
      }
   }
}
