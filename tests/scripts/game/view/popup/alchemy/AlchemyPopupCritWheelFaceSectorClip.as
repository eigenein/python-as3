package game.view.popup.alchemy
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mediator.gui.popup.alchemy.AlchemyPopupCritWheelValueObject;
   import game.view.gui.components.ClipLabel;
   
   public class AlchemyPopupCritWheelFaceSectorClip extends GuiClipNestedContainer
   {
       
      
      public var tf_multiplier:ClipLabel;
      
      public var sector:GuiAnimation;
      
      private var _data:AlchemyPopupCritWheelValueObject;
      
      private var _highlight:Boolean;
      
      public function AlchemyPopupCritWheelFaceSectorClip()
      {
         tf_multiplier = new ClipLabel();
         sector = new GuiAnimation();
         super();
      }
      
      public function get data() : AlchemyPopupCritWheelValueObject
      {
         return _data;
      }
      
      public function set data(param1:AlchemyPopupCritWheelValueObject) : void
      {
         if(_data == param1)
         {
            return;
         }
         _data = param1;
         tf_multiplier.text = "x" + _data.crit.toString();
         highlight = false;
      }
      
      public function get highlight() : Boolean
      {
         return _highlight;
      }
      
      public function set highlight(param1:Boolean) : void
      {
         _highlight = param1;
         if(!param1)
         {
            sector.hide();
         }
         else
         {
            sector.show(container);
            sector.playOnce();
         }
      }
   }
}
