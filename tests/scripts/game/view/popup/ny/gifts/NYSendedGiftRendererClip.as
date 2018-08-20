package game.view.popup.ny.gifts
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class NYSendedGiftRendererClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title:ClipLabel;
      
      public var tf_time:ClipLabel;
      
      public var gift_container:GuiClipLayoutContainer;
      
      public var bg:GuiClipScale9Image;
      
      public function NYSendedGiftRendererClip()
      {
         tf_title = new ClipLabel();
         tf_time = new ClipLabel();
         gift_container = new GuiClipLayoutContainer();
         bg = new GuiClipScale9Image(new Rectangle(16,16,16,16));
         super();
      }
   }
}
