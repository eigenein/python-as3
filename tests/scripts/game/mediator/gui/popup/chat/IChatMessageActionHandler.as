package game.mediator.gui.popup.chat
{
   import game.model.user.chat.ChatLogMessage;
   
   public interface IChatMessageActionHandler
   {
       
      
      function action_replayMessage(param1:ChatLogMessage) : void;
      
      function action_showResponses(param1:ChatPopupLogValueObject) : void;
   }
}
