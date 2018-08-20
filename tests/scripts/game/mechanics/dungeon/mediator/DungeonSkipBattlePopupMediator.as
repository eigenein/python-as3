package game.mechanics.dungeon.mediator
{
   import game.mechanics.dungeon.model.command.CommandDungeonStartBattle;
   import game.mechanics.dungeon.popup.battle.DungeonSkipBattlePopup;
   import game.mediator.gui.popup.clan.ClanPopupMediatorBase;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.hero.UnitUtils;
   import game.model.user.Player;
   import game.model.user.hero.UnitEntry;
   import game.view.popup.PopupBase;
   import org.osflash.signals.Signal;
   
   public class DungeonSkipBattlePopupMediator extends ClanPopupMediatorBase
   {
       
      
      private var _cmd:CommandDungeonStartBattle;
      
      public const signal_confirm:Signal = new Signal();
      
      public const signal_decline:Signal = new Signal();
      
      public function DungeonSkipBattlePopupMediator(param1:Player, param2:CommandDungeonStartBattle)
      {
         super(param1);
         this._cmd = param2;
      }
      
      public function get team() : Vector.<UnitEntryValueObject>
      {
         var _loc2_:Vector.<UnitEntryValueObject> = new Vector.<UnitEntryValueObject>();
         var _loc4_:int = 0;
         var _loc3_:* = _cmd.units;
         for each(var _loc1_ in _cmd.units)
         {
            _loc2_.push(UnitUtils.createEntryValueObject(_loc1_));
         }
         return _loc2_;
      }
      
      public function action_confirm() : void
      {
         signal_confirm.dispatch();
      }
      
      public function action_decline() : void
      {
         signal_decline.dispatch();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new DungeonSkipBattlePopup(this);
         return new DungeonSkipBattlePopup(this);
      }
   }
}
