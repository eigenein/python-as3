package game.view.popup.social
{
   import engine.core.clipgui.GuiClipImage;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.SpecialClipLabel;
   
   public class CommunityPromoPopupClip extends PopupClipBase
   {
       
      
      public var tf_0:SpecialClipLabel;
      
      public var tf_1:SpecialClipLabel;
      
      public var tf_2:SpecialClipLabel;
      
      public var tf_3:SpecialClipLabel;
      
      public var button_go:ClipButtonLabeled;
      
      public var image_hero:GuiClipImage;
      
      public function CommunityPromoPopupClip()
      {
         tf_0 = new SpecialClipLabel();
         tf_1 = new SpecialClipLabel();
         tf_2 = new SpecialClipLabel();
         tf_3 = new SpecialClipLabel();
         button_go = new ClipButtonLabeled();
         image_hero = new GuiClipImage();
         super();
      }
   }
}
