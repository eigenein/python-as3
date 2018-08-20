package game.view.specialoffer.bundlecarousel
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   
   public class SpecialOfferBundleCarouselClip extends GuiClipNestedContainer
   {
       
      
      public var button_next:ClipButtonLabeledVerticalLayoutMiddle;
      
      public var tf_title:ClipLabel;
      
      public var tf_description:SpecialClipLabel;
      
      public var tf_timer:ClipLabel;
      
      public var tf_offer_num:ClipLabel;
      
      public var layout_description:ClipLayout;
      
      public function SpecialOfferBundleCarouselClip()
      {
         tf_description = new SpecialClipLabel();
         layout_description = ClipLayout.verticalMiddleCenter(0,tf_description);
         super();
      }
   }
}
