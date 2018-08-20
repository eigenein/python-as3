package game.view.gui
{
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import game.command.timer.GameTimer;
   import game.data.storage.DataStorage;
   import game.data.storage.mechanic.MechanicDescription;
   import game.data.storage.quest.QuestHeroAdviceDescription;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerHeroSkill;
   import game.model.user.quest.PlayerQuestEntry;
   import game.view.gui.homescreen.HomeScreenHeroes;
   
   public class HomeScreenSceneHeroAdviceController
   {
       
      
      private var currentAdvice:QuestHeroAdviceValueObject;
      
      private var adviceFirstTimer:Timer;
      
      private var adviceDisappearTimer:Timer;
      
      private var adviceTimer:Timer;
      
      private var heroes:HomeScreenHeroes;
      
      private var player:Player;
      
      public function HomeScreenSceneHeroAdviceController(param1:Player, param2:HomeScreenHeroes)
      {
         super();
         this.player = param1;
         this.heroes = param2;
         var _loc5_:int = GameTimer.instance.currentServerTime;
         _loc5_ = _loc5_ - param1.lastLoginTime;
         var _loc3_:int = DataStorage.rule.questHeroAdviceTimerConfig.getInitialInterval(_loc5_);
         adviceFirstTimer = new Timer(_loc3_,1);
         var _loc4_:int = DataStorage.rule.questHeroAdviceTimerConfig.getRepeatInterval(_loc5_);
         adviceTimer = new Timer(_loc4_,1);
         adviceDisappearTimer = new Timer(DataStorage.rule.questHeroAdviceTimerConfig.onScreenTime,1);
         adviceFirstTimer.addEventListener("timer",handler_adviceFirstTimer);
         adviceDisappearTimer.addEventListener("timer",handler_adviceDisappearTimer);
         adviceTimer.addEventListener("timer",handler_adviceTimer);
      }
      
      public function action_start() : void
      {
         if(player.levelData.level.level > DataStorage.rule.questHeroAdviceTimerConfig.minPlayerLevel)
         {
            adviceFirstTimer.start();
         }
      }
      
      public function action_stop() : void
      {
         currentAdvice = null;
         heroes.controller.adviceClear();
         adviceFirstTimer.reset();
         adviceDisappearTimer.reset();
         adviceTimer.reset();
      }
      
      protected function _action_showAdvice() : void
      {
         resetTimers();
         currentAdvice = rollAdvice();
         if(currentAdvice)
         {
            heroes.controller.adviceAdd(currentAdvice);
            adviceDisappearTimer.start();
         }
      }
      
      protected function _action_hideAdvice() : void
      {
         resetTimers();
         if(currentAdvice)
         {
            heroes.controller.adviceClear();
            currentAdvice = null;
         }
      }
      
      protected function rollAdvice() : QuestHeroAdviceValueObject
      {
         var _loc7_:int = 0;
         var _loc15_:int = 0;
         var _loc4_:int = 0;
         var _loc18_:* = undefined;
         var _loc10_:int = 0;
         var _loc9_:int = 0;
         var _loc5_:Boolean = false;
         var _loc3_:* = null;
         var _loc11_:int = 0;
         var _loc6_:int = 0;
         var _loc16_:* = null;
         var _loc13_:* = undefined;
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc17_:* = null;
         var _loc2_:Vector.<QuestHeroAdviceValueObject> = new Vector.<QuestHeroAdviceValueObject>();
         var _loc1_:Vector.<PlayerQuestEntry> = player.questData.getDailyList();
         var _loc12_:int = _loc1_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc12_)
         {
            if(!_loc1_[_loc7_].canFarm)
            {
               _loc15_ = heroes.activeHeroes.length;
               _loc4_ = 0;
               while(_loc4_ < _loc15_)
               {
                  _loc18_ = DataStorage.quest.getQuestAdvice(_loc1_[_loc7_],heroes.activeHeroes[_loc4_]);
                  _loc10_ = _loc18_.length;
                  _loc9_ = 0;
                  while(_loc9_ < _loc10_)
                  {
                     _loc5_ = true;
                     if(_loc18_[_loc9_].requirement_mechanicIdent)
                     {
                        _loc3_ = DataStorage.mechanic.getByType(_loc18_[_loc9_].requirement_mechanicIdent);
                        if(_loc3_.teamLevel > player.levelData.level.level)
                        {
                           _loc5_ = false;
                        }
                     }
                     if(_loc18_[_loc9_].requirement_refillableId)
                     {
                        _loc5_ = false;
                        _loc11_ = _loc18_[_loc9_].requirement_refillableId.length;
                        _loc6_ = 0;
                        while(_loc6_ < _loc11_)
                        {
                           if(player.refillable.getById(_loc18_[_loc9_].requirement_refillableId[_loc6_]).value > 0)
                           {
                              _loc5_ = true;
                           }
                           _loc6_++;
                        }
                     }
                     if(_loc18_[_loc9_].requirement_skillsNotMaxed)
                     {
                        _loc5_ = false;
                        _loc16_ = player.heroes.getById(heroes.activeHeroes[_loc4_].id);
                        _loc13_ = _loc16_.skillData.getSkillList();
                        _loc14_ = _loc13_.length;
                        _loc8_ = 0;
                        while(_loc8_ < _loc14_)
                        {
                           _loc5_ = _loc5_ || _loc16_.canUpgradeSkill(_loc13_[_loc8_].skill);
                           _loc8_++;
                        }
                     }
                     if(_loc5_)
                     {
                        _loc17_ = new QuestHeroAdviceValueObject(_loc1_[_loc7_],heroes.activeHeroes[_loc4_],_loc18_[_loc9_]);
                        _loc2_.push(_loc17_);
                     }
                     _loc9_++;
                  }
                  _loc4_++;
               }
            }
            _loc7_++;
         }
         if(_loc2_.length > 0)
         {
            return _loc2_[int(Math.random() * _loc2_.length)];
         }
         return null;
      }
      
      private function resetTimers() : void
      {
         adviceFirstTimer.reset();
         adviceDisappearTimer.reset();
         adviceTimer.reset();
      }
      
      protected function handler_adviceFirstTimer(param1:TimerEvent) : void
      {
         _action_showAdvice();
      }
      
      protected function handler_adviceTimer(param1:TimerEvent) : void
      {
         _action_showAdvice();
      }
      
      protected function handler_adviceDisappearTimer(param1:TimerEvent) : void
      {
         _action_hideAdvice();
         adviceTimer.start();
      }
   }
}
