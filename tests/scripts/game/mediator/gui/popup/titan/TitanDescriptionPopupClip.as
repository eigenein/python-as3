package game.mediator.gui.popup.titan
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.SpecialClipLabel;
   
   public class TitanDescriptionPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var title_tf:ClipLabel;
      
      public var titul_tf:ClipLabel;
      
      public var element_icon:GuiClipImage;
      
      public var layout_title:ClipLayout;
      
      public var titan_back:GuiClipImage;
      
      public var hero_position_after:ClipSprite;
      
      public var hero_position_rays:ClipSprite;
      
      public var progressbar_fragments:ClipProgressBar;
      
      public var tf_label_fragments:SpecialClipLabel;
      
      public var tf_label_fragments_desc:ClipLabel;
      
      public var find_group_1:TitanFrgmentFindGroup1Clip;
      
      public var find_group_2:TitanFrgmentFindGroup2Clip;
      
      public function TitanDescriptionPopupClip()
      {
         title_tf = new ClipLabel(true);
         titul_tf = new ClipLabel();
         element_icon = new GuiClipImage();
         layout_title = ClipLayout.horizontalMiddleCentered(10,element_icon,title_tf);
         hero_position_after = new ClipSprite();
         hero_position_rays = new ClipSprite();
         tf_label_fragments = new SpecialClipLabel();
         tf_label_fragments_desc = new ClipLabel();
         find_group_1 = new TitanFrgmentFindGroup1Clip();
         find_group_2 = new TitanFrgmentFindGroup2Clip();
         super();
      }
   }
}
