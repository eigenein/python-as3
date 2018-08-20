package game.mechanics.titan_arena.mediator.halloffame
{
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameUserInfo;
   import game.mechanics.titan_arena.popup.halloffame.TitanArenaBestPlayersPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class TitanArenaBestPlayersPopupMediator extends PopupMediator
   {
       
      
      public var title:String;
      
      public var list:Vector.<TitanArenaHallOfFameUserInfo>;
      
      public function TitanArenaBestPlayersPopupMediator(param1:Player, param2:String, param3:Vector.<TitanArenaHallOfFameUserInfo>)
      {
         super(param1);
         this.list = param3;
         this.title = param2;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaBestPlayersPopup(this);
         return _popup;
      }
   }
}
