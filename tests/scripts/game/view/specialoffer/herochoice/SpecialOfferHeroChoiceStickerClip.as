package game.view.specialoffer.herochoice
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class SpecialOfferHeroChoiceStickerClip extends GuiClipNestedContainer
   {
       
      
      public var tf_header:ClipLabel;
      
      public var tf_text:ClipLabel;
      
      public function SpecialOfferHeroChoiceStickerClip()
      {
         tf_header = new ClipLabel();
         tf_text = new ClipLabel();
         super();
      }
   }
}
