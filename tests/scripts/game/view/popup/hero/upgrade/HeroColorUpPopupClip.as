package game.view.popup.hero.upgrade
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class HeroColorUpPopupClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_hero_name:ClipLabel;
      
      public var tf_skill_name:ClipLabel;
      
      public var stat_1:UpgradeStatGroupClip;
      
      public var hero_portrait_1:GuiClipContainer;
      
      public var hero_portrait_2:GuiClipContainer;
      
      public var ArrowMed_inst0:ClipSprite;
      
      public var animation_EpicRays_inst0:ClipSprite;
      
      public var skillIcon:SkillIconClip;
      
      public var okButton:ClipButtonLabeled;
      
      public var button_close:ClipButton;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var layout_fragment_btns:ClipLayout;
      
      public function HeroColorUpPopupClip()
      {
         tf_header = new ClipLabel();
         tf_hero_name = new ClipLabel();
         tf_skill_name = new ClipLabel();
         stat_1 = new UpgradeStatGroupClip();
         hero_portrait_1 = new GuiClipContainer();
         hero_portrait_2 = new GuiClipContainer();
         ArrowMed_inst0 = new ClipSprite();
         animation_EpicRays_inst0 = new ClipSprite();
         skillIcon = new SkillIconClip();
         okButton = new ClipButtonLabeled();
         button_close = new ClipButton();
         ribbon_154_154_2_inst0 = new ClipSprite();
         layout_fragment_btns = ClipLayout.verticalCenter(16,stat_1,tf_skill_name,skillIcon,okButton);
         super();
      }
   }
}
