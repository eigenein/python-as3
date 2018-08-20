package game.view.popup.ny.gifts
{
   import com.progrestar.common.lang.Translate;
   import game.model.GameModel;
   import game.model.user.Player;
   import idv.cjcat.signals.Signal;
   
   public class NYGiftsPopupTabRendererMediator
   {
       
      
      private var player:Player;
      
      private var _tabElement:NYGiftsPopupTabRendererVO;
      
      private var _signalUpdate:Signal;
      
      public function NYGiftsPopupTabRendererMediator()
      {
         _signalUpdate = new Signal();
         super();
         player = GameModel.instance.player;
         player.ny.signal_giftsToOpenChange.add(handler_giftReceivedChange);
      }
      
      public function dispose() : void
      {
         signalUpdate.clear();
         player.ny.signal_giftsToOpenChange.add(handler_giftReceivedChange);
         player = null;
         tabElement = null;
      }
      
      public function get tabElement() : NYGiftsPopupTabRendererVO
      {
         return _tabElement;
      }
      
      public function set tabElement(param1:NYGiftsPopupTabRendererVO) : void
      {
         if(tabElement == param1)
         {
            return;
         }
         _tabElement = param1;
      }
      
      public function get tabName() : String
      {
         return Translate.translate(tabElement.name);
      }
      
      public function get giftsToOpenAvaliable() : Boolean
      {
         return tabElement.id == 1 && player.ny.giftsToOpen > 0;
      }
      
      public function get signalUpdate() : Signal
      {
         return _signalUpdate;
      }
      
      private function handler_giftReceivedChange() : void
      {
         signalUpdate.dispatch();
      }
   }
}
