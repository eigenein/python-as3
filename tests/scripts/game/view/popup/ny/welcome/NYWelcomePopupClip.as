package game.view.popup.ny.welcome
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipButtonMultiLineLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   
   public class NYWelcomePopupClip extends GuiClipNestedContainer
   {
       
      
      public var btn_close:ClipButton;
      
      public var tf_title:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var tf_timout:SpecialClipLabel;
      
      public var tf_welcome_1:ClipLabel;
      
      public var tf_welcome_2:ClipLabel;
      
      public var tf_welcome_3:ClipLabel;
      
      public var tf_welcome_4:ClipLabel;
      
      public var btn_1:ClipButtonLabeled;
      
      public var btn_2:ClipButtonLabeled;
      
      public var btn_3:ClipButtonMultiLineLabeled;
      
      public var btn_4:ClipButtonLabeled;
      
      public var bg_tf_welcome_1:GuiClipImage;
      
      public var bg_tf_welcome_2:GuiClipImage;
      
      public var bg_tf_welcome_3:GuiClipImage;
      
      public var plate_1:NYWelcomePopupPlate;
      
      public var plate_2:NYWelcomePopupPlate;
      
      public var plate_3:NYWelcomePopupPlate;
      
      public var not_opened_gifts_marker:GuiClipImage;
      
      public function NYWelcomePopupClip()
      {
         btn_close = new ClipButton();
         tf_title = new ClipLabel();
         tf_desc = new ClipLabel();
         tf_timout = new SpecialClipLabel();
         tf_welcome_1 = new ClipLabel();
         tf_welcome_2 = new ClipLabel();
         tf_welcome_3 = new ClipLabel();
         tf_welcome_4 = new ClipLabel();
         btn_1 = new ClipButtonLabeled();
         btn_2 = new ClipButtonLabeled();
         btn_3 = new ClipButtonMultiLineLabeled();
         btn_4 = new ClipButtonLabeled();
         bg_tf_welcome_1 = new GuiClipImage();
         bg_tf_welcome_2 = new GuiClipImage();
         bg_tf_welcome_3 = new GuiClipImage();
         plate_1 = new NYWelcomePopupPlate();
         plate_2 = new NYWelcomePopupPlate();
         plate_3 = new NYWelcomePopupPlate();
         not_opened_gifts_marker = new GuiClipImage();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         bg_tf_welcome_1.graphics.touchable = false;
         bg_tf_welcome_2.graphics.touchable = false;
         bg_tf_welcome_3.graphics.touchable = false;
         tf_welcome_1.touchable = false;
         tf_welcome_2.touchable = false;
         tf_welcome_3.touchable = false;
         btn_1.graphics.touchable = false;
         btn_2.graphics.touchable = false;
         btn_3.graphics.touchable = false;
      }
   }
}
