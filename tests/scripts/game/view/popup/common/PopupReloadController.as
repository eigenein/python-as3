package game.view.popup.common
{
   import feathers.core.PopUpManager;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.GameModel;
   import game.view.popup.PopupBase;
   import starling.events.Event;
   
   public class PopupReloadController
   {
       
      
      private var popup:PopupBase;
      
      private var mediator:PopupMediator;
      
      private var reloadDelayed:Boolean;
      
      public function PopupReloadController(param1:PopupBase, param2:PopupMediator, param3:Boolean = true)
      {
         super();
         this.popup = param1;
         this.mediator = param2;
         if(param3)
         {
            GameModel.instance.player.specialOffer.signal_updated.add(handler_specialOfferUpdate);
         }
      }
      
      public function dispose() : void
      {
         if(reloadDelayed)
         {
            reloadDelayed = false;
            popup.removeEventListener("addedToStage",handler_addedToStage);
         }
         GameModel.instance.player.specialOffer.signal_updated.remove(handler_specialOfferUpdate);
      }
      
      public function requestReload() : void
      {
         if(popup.stage)
         {
            reopen();
         }
         else
         {
            reloadDelayed = true;
         }
      }
      
      private function reopen() : void
      {
         if(popup.stage)
         {
            mediator.open(popup.stashParams);
            PopUpManager.removePopUp(popup);
            popup.dispose();
         }
         else
         {
            reloadDelayed = true;
            popup.addEventListener("addedToStage",handler_addedToStage);
         }
      }
      
      private function handler_addedToStage(param1:Event) : void
      {
         if(reloadDelayed)
         {
            reopen();
         }
      }
      
      private function handler_specialOfferUpdate() : void
      {
         requestReload();
      }
   }
}
