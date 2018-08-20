package game.view.popup.test.stattask
{
   import battle.BattleConfig;
   import engine.core.utils.property.StringPropertyWriteable;
   import flash.utils.getTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.UnitDescription;
   import game.view.popup.test.BattleTestSetup;
   import game.view.popup.test.grade.BattleTestGradeModel;
   import org.osflash.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class BattleStatTaskExecutor implements IAnimatable
   {
       
      
      public var testSetup:BattleTestSetup;
      
      public var attGrade:BattleTestGradeModel;
      
      public var defGrade:BattleTestGradeModel;
      
      public var config:BattleConfig;
      
      public var attackerIds:Vector.<int>;
      
      public var defenderIds:Vector.<int>;
      
      public const progressReport:StringPropertyWriteable = new StringPropertyWriteable("");
      
      public const resultReport:StringPropertyWriteable = new StringPropertyWriteable("");
      
      private var isBusy:Boolean = false;
      
      private var inProgress:Boolean = false;
      
      private var taskList:Vector.<String>;
      
      private var battlesLeft:int;
      
      private var battlesToDo:int;
      
      private var actions:BattleStatTaskActions;
      
      public const progress:Signal = new Signal(Number);
      
      public function BattleStatTaskExecutor(param1:BattleTestSetup, param2:BattleTestGradeModel, param3:BattleTestGradeModel, param4:BattleConfig)
      {
         attackerIds = new Vector.<int>();
         defenderIds = new Vector.<int>();
         taskList = new Vector.<String>();
         super();
         this.testSetup = param1;
         this.attGrade = param2;
         this.defGrade = param3;
         this.config = param4;
         this.actions = new BattleStatTaskActions(this);
      }
      
      public function execute(param1:String) : void
      {
         var _loc2_:Array = param1.split("\r");
         taskList = Vector.<String>(_loc2_);
         progressReport.value = "START";
         inProgress = true;
         isBusy = true;
         Starling.juggler.add(this);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc2_:Number = getTimer();
         while(getTimer() - _loc2_ < 100 && hasTasksLeft())
         {
            if(battlesLeft > 0)
            {
               nextBattle();
            }
            else
            {
               nextTask();
            }
         }
         if(!hasTasksLeft())
         {
            progress.dispatch(1);
            finish();
         }
      }
      
      public function startBattles(param1:int) : void
      {
         progressReport.value = progressReport.value + "\n ";
         battlesLeft = param1;
         battlesToDo = param1;
      }
      
      protected function nextBattle() : void
      {
         battlesLeft = Number(battlesLeft) - 1;
         var _loc1_:Array = progressReport.value.split("\n");
         _loc1_.pop();
         _loc1_.push(battlesToDo - battlesLeft + " из " + battlesToDo);
         progressReport.value = _loc1_.join("\n");
         doBattle();
      }
      
      protected function doBattle() : void
      {
         var _loc3_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc1_:Vector.<UnitDescription> = new Vector.<UnitDescription>();
         var _loc6_:int = 0;
         var _loc5_:* = attackerIds;
         for each(var _loc4_ in attackerIds)
         {
            _loc3_.push(DataStorage.hero.getUnitById(_loc4_));
         }
         var _loc8_:int = 0;
         var _loc7_:* = defenderIds;
         for each(_loc4_ in defenderIds)
         {
            _loc1_.push(DataStorage.hero.getUnitById(_loc4_));
         }
         var _loc2_:Boolean = false;
         testSetup.fillEmptySlotsLeft = true;
         testSetup.fillEmptySlotsRight = true && !_loc2_;
         testSetup.collectStatisticsRight = !_loc2_;
         testSetup.setupTeams(_loc3_,_loc1_);
         testSetup.run(attGrade,defGrade,config);
      }
      
      protected function hasTasksLeft() : Boolean
      {
         return taskList.length > 0 || battlesLeft > 0;
      }
      
      protected function nextTask() : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc1_:String = taskList.shift();
         var _loc3_:int = _loc1_.indexOf(" ");
         if(_loc3_ >= 0)
         {
            _loc4_ = _loc1_.slice(0,_loc3_);
            _loc2_ = _loc1_.slice(_loc3_ + 1);
         }
         else
         {
            _loc4_ = _loc1_;
            _loc2_ = "";
         }
         if(actions.hasOwnProperty(_loc4_) && actions[_loc4_] is Function)
         {
            progressReport.value = progressReport.value + ("\n" + _loc1_);
            actions[_loc4_].apply(actions,[_loc2_]);
         }
         else if(_loc1_.length > 0)
         {
            progressReport.value = progressReport.value + ("\n FAILED " + _loc1_);
         }
      }
      
      protected function finish() : void
      {
         progressReport.value = progressReport.value + "\nDONE";
         inProgress = false;
         isBusy = false;
         Starling.juggler.remove(this);
      }
   }
}
