package game.view.specialoffer.blackfriday2017
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class SpecialOfferBlackFriday2017PanelClip extends GuiClipNestedContainer
   {
       
      
      public const button:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const tf_header:ClipLabel = new ClipLabel();
      
      public const layout_header:ClipLayout = ClipLayout.verticalMiddleCenter(0,tf_header);
      
      public function SpecialOfferBlackFriday2017PanelClip()
      {
         super();
      }
   }
}
