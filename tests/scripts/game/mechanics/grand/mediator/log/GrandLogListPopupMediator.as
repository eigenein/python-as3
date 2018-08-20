package game.mechanics.grand.mediator.log
{
   import feathers.data.ListCollection;
   import game.command.rpc.grand.GrandBattleResult;
   import game.mechanics.grand.popup.log.GrandLogInfoPopupMediator;
   import game.mechanics.grand.popup.log.GrandLogListPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   
   public class GrandLogListPopupMediator extends PopupMediator
   {
       
      
      public const logData:ListCollection = new ListCollection();
      
      public function GrandLogListPopupMediator(param1:Player, param2:Vector.<GrandBattleResult>)
      {
         super(param1);
         var _loc4_:Vector.<GrandLogListEntryValueObject> = new Vector.<GrandLogListEntryValueObject>();
         var _loc6_:int = 0;
         var _loc5_:* = param2;
         for each(var _loc3_ in param2)
         {
            _loc4_.push(new GrandLogListEntryValueObject(this,_loc3_));
         }
         this.logData.data = _loc4_;
      }
      
      public function action_select(param1:GrandLogListEntryValueObject) : void
      {
         new GrandLogInfoPopupMediator(player,param1.entry).open();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new GrandLogListPopup(this);
         return _popup;
      }
   }
}
