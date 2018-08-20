package game.mediator.gui.popup.tower
{
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.tower.PlayerTowerBattleFloor;
   import game.view.popup.PopupBase;
   import game.view.popup.tower.TowerSkipFloorPopup;
   import idv.cjcat.signals.Signal;
   
   public class TowerSkipFloorPopupMediator extends PopupMediator
   {
       
      
      private var battleFloor:PlayerTowerBattleFloor;
      
      private var _signal_skip:Signal;
      
      private var _signal_fight:Signal;
      
      private var _floor:int;
      
      private var _reward_points:int;
      
      private var _reward_skulls:int;
      
      public function TowerSkipFloorPopupMediator(param1:Player, param2:PlayerTowerBattleFloor)
      {
         _signal_skip = new Signal();
         _signal_fight = new Signal();
         super(param1);
         battleFloor = param2;
         _reward_points = param2.hardEnemy.maxPointReward;
         _reward_skulls = param2.hardEnemy.maxSkullReward;
         _floor = param1.tower.maySkipUpToFloor.value;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _signal_fight.clear();
         _signal_skip.clear();
      }
      
      public function get signal_skip() : Signal
      {
         return _signal_skip;
      }
      
      public function get signal_fight() : Signal
      {
         return _signal_fight;
      }
      
      public function get floor() : int
      {
         return _floor;
      }
      
      public function get reward_points() : int
      {
         return _reward_points;
      }
      
      public function get reward_skulls() : int
      {
         return _reward_skulls;
      }
      
      public function get maxSkipFloor() : int
      {
         return DataStorage.rule.towerRule.maxSkipFloor;
      }
      
      public function get skipBought() : Boolean
      {
         return player.tower.skipBought;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TowerSkipFloorPopup(this);
         return _popup;
      }
      
      public function action_skip() : void
      {
         _signal_skip.dispatch();
         close();
      }
      
      public function action_fight() : void
      {
         _signal_fight.dispatch();
         close();
      }
   }
}
