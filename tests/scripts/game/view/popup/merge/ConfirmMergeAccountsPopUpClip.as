package game.view.popup.merge
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ConfirmMergeAccountsPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var tf_title_1:ClipLabel;
      
      public var tf_title_2:ClipLabel;
      
      public var text_tf:SpecialClipLabel;
      
      public var account_renderer_container:GuiClipLayoutContainer;
      
      public var toggle:ConfirmMergeAccountsToogleButton;
      
      public var layout_container:ClipLayout;
      
      public var back_btn:ClipButtonLabeled;
      
      public var continue_btn:ClipButtonLabeled;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public var text_container:GuiClipLayoutContainer;
      
      public function ConfirmMergeAccountsPopUpClip()
      {
         tf_title_1 = new ClipLabel();
         tf_title_2 = new ClipLabel();
         text_tf = new SpecialClipLabel();
         account_renderer_container = new GuiClipLayoutContainer();
         toggle = new ConfirmMergeAccountsToogleButton();
         layout_container = ClipLayout.horizontalCentered(0,toggle);
         back_btn = new ClipButtonLabeled();
         continue_btn = new ClipButtonLabeled();
         scroll_slider_container = new GuiClipLayoutContainer();
         text_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
