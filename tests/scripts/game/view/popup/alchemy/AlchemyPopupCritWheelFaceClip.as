package game.view.popup.alchemy
{
   import engine.core.clipgui.GuiClipNestedContainer;
   
   public class AlchemyPopupCritWheelFaceClip extends GuiClipNestedContainer
   {
       
      
      public var sector:Vector.<AlchemyPopupCritWheelFaceSectorClip>;
      
      public function AlchemyPopupCritWheelFaceClip()
      {
         sector = new Vector.<AlchemyPopupCritWheelFaceSectorClip>();
         super();
      }
   }
}
