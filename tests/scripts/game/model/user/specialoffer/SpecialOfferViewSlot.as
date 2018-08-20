package game.model.user.specialoffer
{
   import game.model.user.specialoffer.viewslot.ViewSlotEntry;
   import game.view.popup.reward.GuiElementExternalStyle;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class SpecialOfferViewSlot
   {
       
      
      private var viewItemProvider:SpecialOfferViewEntryQueue;
      
      private var backContainer:DisplayObjectContainer;
      
      private var frontContainer:DisplayObjectContainer;
      
      private var target:DisplayObject;
      
      private var objectPositioning:GuiElementExternalStyle;
      
      public function SpecialOfferViewSlot(param1:DisplayObject, param2:SpecialOfferViewEntryQueue, param3:DisplayObjectContainer = null, param4:DisplayObjectContainer = null)
      {
         super();
         this.target = param1;
         this.viewItemProvider = param2;
         if(param3 == null)
         {
            param3 = param1.parent;
         }
         if(param4 == null)
         {
            param4 = param1.parent;
         }
         setContainers(param3,param4);
      }
      
      public function dispose() : void
      {
         if(viewItemProvider)
         {
            viewItemProvider.unsubscribeFirst(handler_slotEntry);
         }
         if(objectPositioning)
         {
            objectPositioning.dispose();
            objectPositioning = null;
         }
      }
      
      protected function setContainers(param1:DisplayObjectContainer, param2:DisplayObjectContainer) : void
      {
         this.backContainer = param1;
         this.frontContainer = param2;
         if(target)
         {
            viewItemProvider.firstElement.onValue(handler_slotEntry);
         }
      }
      
      private function handler_slotEntry(param1:ViewSlotEntry) : void
      {
         var _loc2_:* = null;
         if(objectPositioning)
         {
            objectPositioning.dispose();
            objectPositioning = null;
         }
         if(param1 != ViewSlotEntry.NULL)
         {
            _loc2_ = param1.createObject();
            if(_loc2_)
            {
               objectPositioning = _loc2_.externalStyle;
               if(objectPositioning)
               {
                  objectPositioning.apply(target,!!backContainer?backContainer:target as DisplayObjectContainer,!!frontContainer?frontContainer:target as DisplayObjectContainer);
               }
            }
         }
      }
   }
}
