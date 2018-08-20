package game.view.popup.herodescription
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeledResizeable;
   
   public class HeroDescriptionPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var info:HeroDescriptionInfoClip;
      
      public var recieveInfoBtn:ClipButtonLabeledResizeable;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function HeroDescriptionPopUpClip()
      {
         button_close = new ClipButton();
         info = new HeroDescriptionInfoClip();
         recieveInfoBtn = new ClipButtonLabeledResizeable();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
