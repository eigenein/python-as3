package game.mediator.gui.popup.hero.skin
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class SkinLevelUpPopUpClip extends GuiClipNestedContainer
   {
       
      
      public var tf_desc:SpecialClipLabel;
      
      public var tf_header:ClipLabel;
      
      public var tf_hero_name:ClipLabel;
      
      public var tf_level:ClipLabel;
      
      public var okButton:ClipButtonLabeled;
      
      public var rays_inst0:GuiAnimation;
      
      public var rays_inst1:GuiAnimation;
      
      public var hero_position:ClipSprite;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var bottom_bg:ClipSprite;
      
      public var line_top:ClipSprite;
      
      public var line_bottom:ClipSprite;
      
      public var tf_recieve_hero:ClipLabel;
      
      public var recieve_info_btn:ClipButtonLabeled;
      
      public var recieve_hero_group:ClipLayout;
      
      public function SkinLevelUpPopUpClip()
      {
         tf_desc = new SpecialClipLabel();
         tf_header = new ClipLabel();
         tf_hero_name = new ClipLabel();
         tf_level = new ClipLabel();
         okButton = new ClipButtonLabeled();
         rays_inst0 = new GuiAnimation();
         rays_inst1 = new GuiAnimation();
         hero_position = new ClipSprite();
         ribbon_154_154_2_inst0 = new ClipSprite();
         bottom_bg = new ClipSprite();
         line_top = new ClipSprite();
         line_bottom = new ClipSprite();
         tf_recieve_hero = new ClipLabel(true);
         recieve_info_btn = new ClipButtonLabeled();
         recieve_hero_group = ClipLayout.horizontalMiddleCentered(8,tf_recieve_hero,recieve_info_btn);
         super();
      }
   }
}
