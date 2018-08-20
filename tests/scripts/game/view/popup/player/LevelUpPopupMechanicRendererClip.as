package game.view.popup.player
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   
   public class LevelUpPopupMechanicRendererClip extends GuiClipNestedContainer
   {
       
      
      public var avaliable_label:SpecialClipLabel;
      
      public var desc_label:ClipLabel;
      
      public var title_label:ClipLabel;
      
      public var check:ClipSprite;
      
      public var image_item:GuiClipImage;
      
      public function LevelUpPopupMechanicRendererClip()
      {
         avaliable_label = new SpecialClipLabel();
         desc_label = new ClipLabel();
         title_label = new ClipLabel();
         check = new ClipSprite();
         image_item = new GuiClipImage();
         super();
      }
   }
}
