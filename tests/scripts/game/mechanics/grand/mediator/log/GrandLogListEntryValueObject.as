package game.mechanics.grand.mediator.log
{
   import game.command.rpc.grand.GrandBattleResult;
   
   public class GrandLogListEntryValueObject
   {
       
      
      private var mediator:GrandLogListPopupMediator;
      
      private var _entry:GrandBattleResult;
      
      public function GrandLogListEntryValueObject(param1:GrandLogListPopupMediator, param2:GrandBattleResult)
      {
         super();
         this.mediator = param1;
         this._entry = param2;
      }
      
      public function get entry() : GrandBattleResult
      {
         return _entry;
      }
      
      public function action_select() : void
      {
         mediator.action_select(this);
      }
   }
}
