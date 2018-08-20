package game.mediator.gui.popup.mission
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import game.data.storage.battle.BattleDescription;
   
   public class TestBattleListValueObject
   {
       
      
      private var _actions:ITestBattleListValueObjectActions;
      
      private var _d:BattleDescription;
      
      private var _completed:BooleanPropertyWriteable;
      
      private var _failed:BooleanPropertyWriteable;
      
      public function TestBattleListValueObject(param1:BattleDescription, param2:ITestBattleListValueObjectActions = null)
      {
         _completed = new BooleanPropertyWriteable(false);
         _failed = new BooleanPropertyWriteable(false);
         super();
         this._d = param1;
         this._actions = param2;
      }
      
      public function get d() : BattleDescription
      {
         return _d;
      }
      
      public function get name() : String
      {
         return _d.name;
      }
      
      public function get completed() : BooleanProperty
      {
         return _completed;
      }
      
      public function get failed() : BooleanProperty
      {
         return _failed;
      }
      
      public function action_select() : void
      {
         if(_actions)
         {
            _actions.action_select(this);
         }
      }
      
      public function action_setCompleted() : void
      {
         _completed.value = true;
      }
      
      public function action_setFailed() : void
      {
         _failed.value = true;
      }
      
      public function action_clear() : void
      {
         _completed.value = false;
         _failed.value = false;
      }
   }
}
