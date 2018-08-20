package game.view.popup.chestrewardheroeslist
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.herodescription.HeroDescriptionInfoClip;
   
   public class ChestRewardHeroesListPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var list_title_tf:ClipLabel;
      
      public var button_close:ClipButton;
      
      public var info:HeroDescriptionInfoClip;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var skin_list_container:GuiClipLayoutContainer;
      
      public var scroll_slider_container:GuiClipLayoutContainer;
      
      public function ChestRewardHeroesListPopUpClip()
      {
         list_title_tf = new ClipLabel();
         button_close = new ClipButton();
         info = new HeroDescriptionInfoClip();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         skin_list_container = new GuiClipLayoutContainer();
         scroll_slider_container = new GuiClipLayoutContainer();
         super();
      }
   }
}
