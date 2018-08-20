package game.mechanics.grand.mediator
{
   import game.battle.controller.thread.GrandSingleBattleThread;
   import game.command.rpc.grand.GrandBattleResult;
   import game.data.storage.mechanic.MechanicStorage;
   import game.mechanics.grand.popup.GrandBattleResultFinalPopup;
   import game.mechanics.grand.popup.GrandBattleResultSinglePopup;
   import game.mediator.gui.popup.mission.MissionDefeatPopupMediator;
   import game.model.user.Player;
   
   public class GrandBattleThread
   {
       
      
      private var player:Player;
      
      private var battleIndex:int;
      
      private var entry:GrandBattleResult;
      
      public function GrandBattleThread(param1:Player, param2:GrandBattleResult)
      {
         super();
         this.player = param1;
         this.entry = param2;
      }
      
      protected function dispose() : void
      {
      }
      
      public function get replayIds() : Vector.<String>
      {
         var _loc2_:int = 0;
         var _loc1_:Vector.<String> = new Vector.<String>();
         var _loc3_:int = entry.battles.length;
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _loc1_.push(entry.battles[_loc2_].replayId);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function run() : void
      {
         battleIndex = 0;
         nextBattle();
      }
      
      protected function nextBattle() : void
      {
         var _loc1_:GrandSingleBattleThread = new GrandSingleBattleThread(this,entry.battles[battleIndex],entry.isDefensiveBattle);
         _loc1_.onComplete.addOnce(handler_battleComplete);
         _loc1_.onRetreat.addOnce(handler_battleRetreat);
         _loc1_.run();
      }
      
      protected function handler_battleComplete(param1:GrandSingleBattleThread) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         Game.instance.screen.hideBattle();
         entry.battles[battleIndex].result = param1.battleResult;
         var _loc5_:GrandBattleResultValueObject = new GrandBattleResultValueObject(player,entry,battleIndex);
         if(battleIndex + 1 < entry.battles.length)
         {
            _loc2_ = new GrandBattleResultSinglePopup(_loc5_);
            _loc2_.signal_continue.addOnce(handler_continue);
            _loc2_.open();
         }
         else
         {
            if(_loc5_.win)
            {
               _loc3_ = new GrandBattleResultFinalPopup(_loc5_);
               _loc3_.open();
            }
            else
            {
               _loc4_ = new MissionDefeatPopupMediator(player,entry.battles[battleIndex],MechanicStorage.GRAND);
               _loc4_.open();
            }
            Game.instance.screen.hideBattle();
            dispose();
         }
      }
      
      protected function handler_battleRetreat(param1:GrandSingleBattleThread) : void
      {
         dispose();
      }
      
      protected function handler_continue() : void
      {
         battleIndex = Number(battleIndex) + 1;
         if(battleIndex < entry.battles.length)
         {
            nextBattle();
         }
         else
         {
            Game.instance.screen.hideBattle();
            dispose();
         }
      }
   }
}
