package game.view.popup.herodescription
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class HeroDescriptionInfoClip extends GuiClipNestedContainer
   {
       
      
      public var description_tf:ClipLabel;
      
      public var skills_description_tf:SpecialClipLabel;
      
      public var skills_tf:ClipLabel;
      
      public var title_tf:ClipLabel;
      
      public var bg:GuiClipScale9Image;
      
      public var HeroGlowBG_scale_inst0:ClipSprite;
      
      public var hero_position_after:ClipSprite;
      
      public var hero_position_rays:ClipSprite;
      
      public var line2:ClipSprite;
      
      public var skills_layout:ClipLayout;
      
      public var description_layout:ClipLayout;
      
      public function HeroDescriptionInfoClip()
      {
         description_tf = new ClipLabel();
         skills_description_tf = new SpecialClipLabel();
         skills_tf = new ClipLabel();
         title_tf = new ClipLabel();
         bg = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         HeroGlowBG_scale_inst0 = new ClipSprite();
         hero_position_after = new ClipSprite();
         hero_position_rays = new ClipSprite();
         line2 = new ClipSprite();
         skills_layout = ClipLayout.verticalMiddleCenter(10);
         description_layout = ClipLayout.verticalMiddleCenter(4,description_tf);
         super();
      }
   }
}
