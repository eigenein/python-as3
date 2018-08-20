package game.view.specialoffer
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.model.user.specialoffer.ISpecialOfferViewSlotObject;
   import game.model.user.specialoffer.PlayerSpecialOfferWithTimer;
   import game.model.user.specialoffer.SpecialOfferViewSlotEntry;
   import game.view.popup.reward.GuiElementExternalStyle;
   
   public class SpecialOfferViewClipBase extends GuiClipNestedContainer implements ISpecialOfferViewSlotObject
   {
       
      
      protected var _offer:PlayerSpecialOfferWithTimer;
      
      protected var _entry:SpecialOfferViewSlotEntry;
      
      protected var _externalStyle:GuiElementExternalStyle;
      
      public function SpecialOfferViewClipBase(param1:PlayerSpecialOfferWithTimer, param2:SpecialOfferViewSlotEntry)
      {
         super();
         _offer = param1;
         _entry = param2;
         _externalStyle = new GuiElementExternalStyle();
         _externalStyle.setNextAbove(graphics,_entry.createAlignment());
         _externalStyle.signal_dispose.add(dispose);
         _offer.signal_updated.remove(handler_updated);
         _offer.signal_removed.add(handler_removed);
      }
      
      public function dispose() : void
      {
         _externalStyle.signal_dispose.remove(dispose);
         _offer.signal_updated.remove(handler_updated);
         _offer.signal_removed.remove(handler_removed);
         graphics.removeFromParent(true);
      }
      
      public function get externalStyle() : GuiElementExternalStyle
      {
         return _externalStyle;
      }
      
      protected function handler_updated() : void
      {
      }
      
      protected function handler_removed() : void
      {
         _externalStyle.dispose();
      }
   }
}
