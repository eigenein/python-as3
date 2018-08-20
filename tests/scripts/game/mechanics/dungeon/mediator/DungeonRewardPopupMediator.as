package game.mechanics.dungeon.mediator
{
   import game.mechanics.dungeon.model.command.CommandDungeonSaveProgress;
   import game.mechanics.dungeon.popup.reward.DungeonRewardPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.model.user.inventory.InventoryItem;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class DungeonRewardPopupMediator extends PopupMediator
   {
       
      
      private var cmd:CommandDungeonSaveProgress;
      
      private var _signal_complete:Signal;
      
      private var _reward:Vector.<InventoryItem>;
      
      public function DungeonRewardPopupMediator(param1:Player, param2:CommandDungeonSaveProgress)
      {
         _signal_complete = new Signal(CommandDungeonSaveProgress);
         super(param1);
         this.cmd = param2;
         _reward = param2.reward.outputDisplay;
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         _signal_complete.dispatch(cmd);
         cmd = null;
      }
      
      public function get signal_complete() : Signal
      {
         return _signal_complete;
      }
      
      public function get reward() : Vector.<InventoryItem>
      {
         return _reward;
      }
      
      public function get floorNumber() : int
      {
         return cmd.respawnFloor;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new DungeonRewardPopup(this);
         return _popup;
      }
   }
}
