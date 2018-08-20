package game.view.popup.merge
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class MergeInfoBonusRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_coin:ClipLabel;
      
      public var icon_coin:GuiClipImage;
      
      public function MergeInfoBonusRendererClip()
      {
         tf_coin = new ClipLabel(true);
         icon_coin = new GuiClipImage();
         super();
      }
   }
}
