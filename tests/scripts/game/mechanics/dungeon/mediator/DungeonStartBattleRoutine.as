package game.mechanics.dungeon.mediator
{
   import game.battle.controller.instant.BattleInstantPlay;
   import game.battle.controller.thread.BattlePresets;
   import game.data.storage.DataStorage;
   import game.mechanics.dungeon.model.command.CommandDungeonEndBattle;
   import game.mechanics.dungeon.model.command.CommandDungeonStartBattle;
   import game.mechanics.dungeon.storage.DungeonFloorType;
   import game.mediator.gui.popup.PopupStashEventParams;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.UnitEntry;
   import game.stat.Stash;
   import org.osflash.signals.Signal;
   
   public class DungeonStartBattleRoutine
   {
       
      
      private var player:Player;
      
      private var units:Vector.<UnitEntry>;
      
      private var enemyIndex:int;
      
      private var stashParams:PopupStashEventParams;
      
      private var cmd:CommandDungeonStartBattle;
      
      private var instantBattle:BattleInstantPlay;
      
      private var skipPopup:DungeonSkipBattlePopupMediator;
      
      public const signal_battleIsInProgress:Signal = new Signal();
      
      public function DungeonStartBattleRoutine(param1:Player, param2:Vector.<UnitEntry>, param3:int, param4:PopupStashEventParams)
      {
         super();
         this.player = param1;
         this.units = param2;
         this.enemyIndex = param3;
         this.stashParams = param4;
      }
      
      public function start() : void
      {
         cmd = GameModel.instance.actionManager.dungeon.dungeonStartBattle(units,enemyIndex);
         cmd.onClientExecute(handler_commandStartBattle);
      }
      
      private function get isHeroBattle() : Boolean
      {
         return player.dungeon.currentFloor.type == DungeonFloorType.BATTLE_HERO;
      }
      
      private function getAtackersPower() : Number
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = units;
         for each(var _loc1_ in units)
         {
            _loc2_ = _loc2_ + _loc1_.getPower();
         }
         return _loc2_;
      }
      
      private function canSkipHeroBattleByPower() : Boolean
      {
         var _loc1_:int = getAtackersPower();
         var _loc2_:int = player.dungeon.currentFloor.getEnemyByIndex(enemyIndex).power;
         var _loc3_:Number = 1 + DataStorage.rule.dungeonRule.heroBattlePowerOverwhelmingPercent / 100;
         return _loc1_ > _loc2_ * _loc3_;
      }
      
      private function tryInstantBattle() : void
      {
         var _loc2_:* = null;
         if(isHeroBattle)
         {
            _loc2_ = new BattlePresets(false,false,true,DataStorage.battleConfig.tower,false);
         }
         else
         {
            _loc2_ = new BattlePresets(false,false,true,DataStorage.battleConfig.titan,false);
         }
         var _loc1_:BattleInstantPlay = new BattleInstantPlay(cmd.battleInfo,_loc2_);
         _loc1_.signal_hasResult.add(handler_instantBattleComplete);
         _loc1_.start();
      }
      
      private function startBattle() : void
      {
         signal_battleIsInProgress.dispatch();
         cmd.startBattle(player);
      }
      
      private function instantEndBattle() : void
      {
         var _loc1_:CommandDungeonEndBattle = player.dungeon.action_instantBattle(instantBattle.result);
         _loc1_.onClientExecute(handler_instantDungeonEndBattle);
      }
      
      private function handler_commandStartBattle(param1:CommandDungeonStartBattle) : void
      {
         startBattle();
      }
      
      private function handler_instantBattleComplete(param1:BattleInstantPlay) : void
      {
         if(param1.result.victory)
         {
            this.instantBattle = param1;
            skipPopup = new DungeonSkipBattlePopupMediator(player,cmd);
            skipPopup.open(Stash.click("dungeonSkipBattle",stashParams));
            skipPopup.signal_confirm.add(handler_heroBattleSkipConfirm);
            skipPopup.signal_decline.add(handler_heroBattleSkipDecline);
         }
         else
         {
            startBattle();
         }
      }
      
      private function handler_heroBattleSkipConfirm() : void
      {
         instantEndBattle();
      }
      
      private function handler_heroBattleSkipDecline() : void
      {
         startBattle();
         if(skipPopup)
         {
            skipPopup.close();
         }
      }
      
      private function handler_instantDungeonEndBattle(param1:CommandDungeonEndBattle) : void
      {
         signal_battleIsInProgress.dispatch();
         if(skipPopup)
         {
            skipPopup.close();
         }
      }
   }
}
