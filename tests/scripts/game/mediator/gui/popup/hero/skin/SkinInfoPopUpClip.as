package game.mediator.gui.popup.hero.skin
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class SkinInfoPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_desc:ClipLabel;
      
      public var tf_recieve_hero:ClipLabel;
      
      public var tf_level:SpecialClipLabel;
      
      public var tf_skill:SpecialClipLabel;
      
      public var tf_skill_to:SpecialClipLabel;
      
      public var tf_upgrade_cost_label:ClipLabel;
      
      public var title_tf:ClipLabel;
      
      public var border:ClipSprite;
      
      public var hero_bg:ClipSprite;
      
      public var hero_position_after:ClipSprite;
      
      public var hero_position_rays:ClipSprite;
      
      public var image_item:ClipSprite;
      
      public var line1:ClipSprite;
      
      public var line2:ClipSprite;
      
      public var icon_upgrade_cost:GuiClipImage;
      
      public var line_top:ClipSprite;
      
      public var line_bottom:ClipSprite;
      
      public var okButton:ClipButtonLabeled;
      
      public var recieve_info_btn:ClipButtonLabeled;
      
      public var skin_bg:GuiClipContainer;
      
      public var recieve_hero_group:ClipLayout;
      
      public var layout_upgrade_cost:ClipLayout;
      
      public var GlowRed_100_100_2_inst0:GuiClipScale3Image;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var bg:GuiClipScale9Image;
      
      public function SkinInfoPopUpClip()
      {
         button_close = new ClipButton();
         tf_desc = new ClipLabel();
         tf_recieve_hero = new ClipLabel();
         tf_level = new SpecialClipLabel();
         tf_skill = new SpecialClipLabel();
         tf_skill_to = new SpecialClipLabel();
         tf_upgrade_cost_label = new ClipLabel(true);
         title_tf = new ClipLabel();
         border = new ClipSprite();
         hero_bg = new ClipSprite();
         hero_position_after = new ClipSprite();
         hero_position_rays = new ClipSprite();
         image_item = new ClipSprite();
         line1 = new ClipSprite();
         line2 = new ClipSprite();
         icon_upgrade_cost = new GuiClipImage();
         line_top = new ClipSprite();
         line_bottom = new ClipSprite();
         okButton = new ClipButtonLabeled();
         recieve_info_btn = new ClipButtonLabeled();
         skin_bg = new GuiClipContainer();
         recieve_hero_group = ClipLayout.horizontalMiddleCentered(8,tf_recieve_hero,recieve_info_btn);
         layout_upgrade_cost = ClipLayout.horizontalMiddleCentered(3,tf_upgrade_cost_label,icon_upgrade_cost);
         GlowRed_100_100_2_inst0 = new GuiClipScale3Image();
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image();
         bg = new GuiClipScale9Image();
         super();
      }
   }
}
