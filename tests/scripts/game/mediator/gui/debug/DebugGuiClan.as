package game.mediator.gui.debug
{
   import flash.utils.Dictionary;
   import game.mediator.gui.popup.chat.ChatPopupMediator;
   import game.mediator.gui.popup.clan.ClanCreatePopupMediator;
   import game.mediator.gui.popup.clan.ClanInfoPopupMediator;
   import game.mediator.gui.popup.clan.ClanSearchPopupMediator;
   import game.model.GameModel;
   
   public class DebugGuiClan
   {
       
      
      public var actions:Dictionary;
      
      public function DebugGuiClan()
      {
         actions = new Dictionary();
         super();
         actions["defeat"] = function():void
         {
         };
         actions["hi friends"] = function():void
         {
            var _loc1_:ClanInfoPopupMediator = new ClanInfoPopupMediator(GameModel.instance.player);
            _loc1_.open();
         };
         actions["make friends"] = function():void
         {
            var _loc1_:ClanCreatePopupMediator = new ClanCreatePopupMediator(GameModel.instance.player);
            _loc1_.open();
         };
         actions["find friends"] = function():void
         {
            var _loc1_:ClanSearchPopupMediator = new ClanSearchPopupMediator(GameModel.instance.player);
            _loc1_.open();
         };
         actions["ay lmao"] = function():void
         {
            var _loc1_:ChatPopupMediator = new ChatPopupMediator(GameModel.instance.player);
            _loc1_.open();
         };
      }
   }
}
