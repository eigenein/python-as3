package game.view.specialoffer.herochoice
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.SpecialClipLabel;
   
   public class SpecialOfferHeroChoiceSelectorPopupClip extends PopupClipBase
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_list_title:ClipLabel;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var scrollbar_heroes:GameScrollBar;
      
      public var list_heroes:GameScrolledList;
      
      public var button_select:ClipButtonLabeled;
      
      public var description_tf:ClipLabel;
      
      public var skills_description_tf:SpecialClipLabel;
      
      public var skills_tf:ClipLabel;
      
      public var title_tf:ClipLabel;
      
      public var HeroGlowBG_scale_inst0:ClipSprite;
      
      public var layout_hero:ClipSprite;
      
      public var hero_position_rays:ClipSprite;
      
      public var line2:ClipSprite;
      
      public var skills_layout:ClipLayout;
      
      public var description_layout:ClipLayout;
      
      public function SpecialOfferHeroChoiceSelectorPopupClip()
      {
         tf_header = new ClipLabel();
         tf_list_title = new ClipLabel();
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         scrollbar_heroes = new GameScrollBar();
         list_heroes = new GameScrolledList(scrollbar_heroes,gradient_top.graphics,gradient_bottom.graphics);
         button_select = new ClipButtonLabeled();
         description_tf = new ClipLabel();
         skills_description_tf = new SpecialClipLabel();
         skills_tf = new ClipLabel();
         title_tf = new ClipLabel();
         HeroGlowBG_scale_inst0 = new ClipSprite();
         layout_hero = new ClipSprite();
         hero_position_rays = new ClipSprite();
         line2 = new ClipSprite();
         skills_layout = ClipLayout.verticalMiddleCenter(10);
         description_layout = ClipLayout.verticalMiddleCenter(4,description_tf);
         super();
      }
   }
}
