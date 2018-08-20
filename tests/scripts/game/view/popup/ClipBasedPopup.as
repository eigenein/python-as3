package game.view.popup
{
   import feathers.core.PopUpManager;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.PopupMediator;
   import starling.display.DisplayObject;
   import starling.events.Event;
   
   public class ClipBasedPopup extends PopupBase
   {
       
      
      protected var _popupMediator:PopupMediator;
      
      private var whenDisplayedCallback:Function;
      
      public function ClipBasedPopup(param1:PopupMediator)
      {
         super();
         this._popupMediator = param1;
      }
      
      public function get popupMediator() : PopupMediator
      {
         return _popupMediator;
      }
      
      override public function close() : void
      {
         if(_popupMediator)
         {
            _popupMediator.close();
         }
         else
         {
            PopUpManager.removePopUp(this);
            dispose();
         }
      }
      
      protected function whenDisplayed(param1:Function) : void
      {
         callback = param1;
         if(callback.length != 0)
         {
            throw "0 arguments expected but " + callback.length + " received.";
         }
         if(whenDisplayedCallback == null)
         {
            addEventListener("enterFrame",handler_enterFrameWhenDisplayed);
            whenDisplayedCallback = callback;
         }
         else
         {
            var t:Function = whenDisplayedCallback;
            whenDisplayedCallback = function():void
            {
               t();
            };
         }
      }
      
      protected function centerPopupBy(param1:DisplayObject, param2:Number = 0, param3:Number = 0) : void
      {
         var _loc4_:Rectangle = param1.getBounds(this);
         width = _loc4_.width + (_loc4_.x - param2) * 2;
         height = _loc4_.height + (_loc4_.y - param3) * 2;
      }
      
      private function handler_enterFrameWhenDisplayed(param1:Event) : void
      {
         removeEventListener("enterFrame",handler_enterFrameWhenDisplayed);
         if(whenDisplayed != null)
         {
            whenDisplayedCallback();
         }
      }
   }
}
