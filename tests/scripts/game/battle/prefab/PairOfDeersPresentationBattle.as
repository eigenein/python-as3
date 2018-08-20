package game.battle.prefab
{
   import battle.data.BattleData;
   import game.assets.battle.BattlegroundAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.thread.BattleThread;
   import game.battle.controller.thread.DemoBattleThread;
   import game.data.storage.battle.BattleTeam;
   import game.data.storage.tutorial.TutorialTaskDescription;
   import game.screen.IBattleScreen;
   import game.view.gui.tutorial.CustomTutorialTask;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialTask;
   import game.view.gui.tutorial.condition.TutorialCondition;
   import game.view.gui.tutorial.condition.TutorialLibCondition;
   
   public class PairOfDeersPresentationBattle
   {
       
      
      public function PairOfDeersPresentationBattle()
      {
         super();
      }
      
      public function start() : void
      {
         var _loc5_:int = 0;
         var _loc1_:BattleData = new BattleData();
         var _loc9_:Object = {
            "teams":[{"heroes":[{
               "id":33,
               "color":10,
               "star":5,
               "lvl":80,
               "hpPercent":100,
               "energy":800,
               "cooldowns":null
            },{
               "id":34,
               "color":10,
               "star":6,
               "lvl":80,
               "hpPercent":100,
               "energy":570,
               "cooldowns":{
                  "2":2,
                  "3":0.2
               }
            }]},{"heroes":[{
               "id":2,
               "color":10,
               "star":5,
               "lvl":80
            },{
               "id":32,
               "color":10,
               "star":5,
               "lvl":80
            },{
               "id":15,
               "color":10,
               "star":5,
               "lvl":80
            },{
               "id":35,
               "color":10,
               "star":5,
               "lvl":80
            },{
               "id":20,
               "color":10,
               "star":5,
               "lvl":80
            }]}],
            "seed":0,
            "advanceTime":2
         };
         var _loc6_:Array = _loc9_.teams;
         var _loc2_:Vector.<BattleTeam> = new Vector.<BattleTeam>();
         var _loc3_:int = _loc6_.length;
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_[_loc5_] = new BattleTeam(_loc6_[_loc5_]);
            _loc5_++;
         }
         if(_loc2_.length < 2)
         {
            return;
         }
         _loc1_.attackers = _loc2_[0].createBattleTeamDescription();
         _loc1_.attackers.direction = 1;
         _loc1_.defenders = _loc2_[1].createBattleTeamDescription();
         _loc1_.defenders.direction = -1;
         _loc1_.seed = int(_loc9_.seed);
         var _loc4_:BattlegroundAsset = AssetStorage.battleground.getById(18);
         var _loc10_:DemoBattleThread = new DemoBattleThread(_loc1_,_loc4_,null,_loc9_);
         _loc10_.onComplete.add(reveal);
         _loc10_.onRetreat.add(reveal);
         _loc10_.run();
         var _loc7_:CustomTutorialTask = createTaskUltWithHeroAt(5.4);
         var _loc8_:CustomTutorialTask = createTaskUltWithHeroAt(7.3);
         var _loc11_:CustomTutorialTask = createTaskUltWithHeroAt(10.7);
         _loc7_.next(_loc8_).next(_loc11_);
         Tutorial.startCustomTask(_loc7_);
      }
      
      private function createTaskUltWithHeroAt(param1:Number) : CustomTutorialTask
      {
         time = param1;
         var desc:TutorialTaskDescription = new TutorialTaskDescription({});
         var task:TutorialTask = new TutorialTask(desc,null);
         desc = new TutorialTaskDescription({});
         var baseTask:CustomTutorialTask = new CustomTutorialTask(desc,null);
         baseTask.startCondition = new TutorialLibCondition("battleTiming","1,0");
         baseTask.completeCondition = new TutorialCondition("battleUserAction");
         baseTask.signal_onStart.add(function(param1:TutorialTask):*
         {
            var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
            var _loc3_:BattleThread = _loc2_.thread;
            _loc3_.controller.lock();
            (_loc3_ as DemoBattleThread).pauseAt(time);
            Tutorial.startCustomTask(task);
         });
         task.startCondition = new TutorialLibCondition("battlePauseReached",null);
         task.setGuiTarget(null,TutorialNavigator.ACTION_BATTLE_HERO);
         task.completeCondition = new TutorialCondition("battleUserAction");
         task.signal_onStart.add(handler_onStartUltTask);
         task.signal_onComplete.add(handler_onCompleteUltTask);
         return baseTask;
      }
      
      private function reveal(param1:BattleThread) : void
      {
         Game.instance.screen.hideBattle();
      }
      
      private function handler_onStartUltTask(param1:TutorialTask) : *
      {
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:BattleThread = _loc2_.thread;
         if(!_loc3_)
         {
            return;
         }
         (_loc3_ as DemoBattleThread).pauseAt(NaN);
         _loc3_.controller.unlock();
         _loc3_.controller.pause();
      }
      
      private function handler_onCompleteUltTask(param1:TutorialTask) : *
      {
         var _loc2_:IBattleScreen = Game.instance.screen.getBattleScreen();
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:BattleThread = _loc2_.thread;
         if(!_loc3_)
         {
            return;
         }
         _loc3_.controller.play();
      }
   }
}
