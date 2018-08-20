package game.view.popup.test.battlelist
{
   import battle.data.BattleData;
   import battle.utils.Version;
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import game.battle.controller.instant.BattleInstantPlay;
   import game.battle.controller.thread.BattlePresets;
   import game.battle.controller.thread.SingleBattleThread;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.mediator.gui.popup.mission.ITestBattleListValueObjectActions;
   import game.mediator.gui.popup.mission.TestBattleListValueObject;
   import game.view.popup.PopupBase;
   
   public class BattleTestListPopupMediator extends PopupMediator implements ITestBattleListValueObjectActions
   {
      
      private static var R:Dictionary = new Dictionary();
       
      
      private var _battles:Vector.<TestBattleListValueObject>;
      
      private var progressIndex:int;
      
      private var presets:BattlePresets;
      
      public const list:ListCollection = new ListCollection();
      
      private var someBattleInProgress:Boolean = false;
      
      private var _inProgress:BooleanPropertyWriteable;
      
      public function BattleTestListPopupMediator()
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         presets = new BattlePresets(false,false,true,DataStorage.battleConfig.pve);
         _inProgress = new BooleanPropertyWriteable(false);
         super(null);
         _battles = new Vector.<TestBattleListValueObject>();
         var _loc3_:int = DataStorage.battlePrototype.count;
         _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            _loc2_ = new TestBattleListValueObject(DataStorage.battlePrototype.getByIndex(_loc1_),this);
            _battles.push(_loc2_);
            _loc1_++;
         }
         list.data = _battles;
      }
      
      public function get inProgress() : BooleanProperty
      {
         return _inProgress;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BattleTestListPopup(this);
         return new BattleTestListPopup(this);
      }
      
      public function action_enterFrame() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_inProgress.value && !someBattleInProgress)
         {
            if(progressIndex < _battles.length)
            {
               _loc2_ = _battles[progressIndex];
               _loc1_ = _loc2_.d.createBattleData();
               if(_loc1_)
               {
                  testBattle(_loc2_,_loc1_);
               }
               else
               {
                  _loc2_.action_setFailed();
               }
               progressIndex = Number(progressIndex) + 1;
            }
            else
            {
               _inProgress.toggle();
               progressIndex = 0;
            }
         }
      }
      
      public function action_start(param1:Boolean) : void
      {
         if(param1 && !_inProgress.value && progressIndex == 0)
         {
            clearStates();
         }
         _inProgress.toggle();
      }
      
      public function action_select(param1:TestBattleListValueObject) : void
      {
         var _loc2_:SingleBattleThread = new SingleBattleThread(param1.d.createBattleData());
         _loc2_.run();
      }
      
      protected function clearStates() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = _battles;
         for each(var _loc1_ in _battles)
         {
            _loc1_.action_clear();
         }
      }
      
      private function testBattle(param1:TestBattleListValueObject, param2:BattleData) : void
      {
         param2.seed = 1000;
         param2.v = Version.last;
         var _loc3_:BattleInstantPlay = new BattleInstantPlay(param2,presets,param1);
         someBattleInProgress = true;
         _loc3_.sceneProxy = new BattleTestLogSceneProxy();
         _loc3_.signal_hasResult.add(handler_battleResult);
         _loc3_.start();
      }
      
      private function isEqual(param1:Vector.<Object>, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = Math.min(param1.length,param2.length);
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            if(param1[_loc3_] != param2[_loc3_])
            {
               return false;
            }
            _loc3_++;
         }
         if(param1.length != param2.length)
         {
            return false;
         }
         return true;
      }
      
      private function printLog(param1:int, param2:Vector.<Object>) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function handler_battleResult(param1:BattleInstantPlay) : void
      {
         someBattleInProgress = false;
         var _loc5_:TestBattleListValueObject = param1.data;
         var _loc4_:BattleTestLogSceneProxy = param1.sceneProxy as BattleTestLogSceneProxy;
         var _loc3_:Vector.<Object> = _loc4_.getLog();
         var _loc2_:Array = R[_loc5_.d.id];
         trace(isEqual(_loc3_,_loc2_));
         _loc5_.action_setCompleted();
      }
   }
}
