package game.view.popup.hero.upgrade
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class HeroStarUpPopupClip extends GuiClipNestedContainer
   {
       
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var stat_1:UpgradeStatGroupClip;
      
      public var stat_2:UpgradeStatGroupClip;
      
      public var stat_3:UpgradeStatGroupClip;
      
      public var stat_4:UpgradeStatGroupClip;
      
      public var tf_hero_name:ClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var hero_portrait_1:GuiClipContainer;
      
      public var hero_portrait_2:GuiClipContainer;
      
      public var okButton:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public function HeroStarUpPopupClip()
      {
         ribbon_154_154_2_inst0 = new ClipSprite();
         stat_1 = new UpgradeStatGroupClip();
         stat_2 = new UpgradeStatGroupClip();
         stat_3 = new UpgradeStatGroupClip();
         stat_4 = new UpgradeStatGroupClip();
         tf_hero_name = new ClipLabel();
         tf_header = new ClipLabel();
         hero_portrait_1 = new GuiClipContainer();
         hero_portrait_2 = new GuiClipContainer();
         button_close = new ClipButton();
         super();
      }
   }
}
