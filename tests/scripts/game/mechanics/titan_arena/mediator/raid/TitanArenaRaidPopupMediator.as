package game.mechanics.titan_arena.mediator.raid
{
   import engine.core.utils.property.BooleanProperty;
   import engine.core.utils.property.BooleanPropertyWriteable;
   import engine.core.utils.property.VectorProperty;
   import engine.core.utils.property.VectorPropertyWriteable;
   import feathers.data.ListCollection;
   import game.data.storage.hero.UnitDescription;
   import game.mechanics.titan_arena.model.TitanArenaRaid;
   import game.mechanics.titan_arena.model.TitanArenaRaidBattleItem;
   import game.mechanics.titan_arena.popup.raid.TitanArenaRaidPopup;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.stat.Stash;
   import game.view.popup.PopupBase;
   
   public class TitanArenaRaidPopupMediator extends PopupMediator
   {
       
      
      private var raid:TitanArenaRaid;
      
      private var _isPending:BooleanPropertyWriteable;
      
      private var _invalidBattle:BooleanPropertyWriteable;
      
      private var _battles:VectorPropertyWriteable;
      
      public const enemyList:ListCollection = new ListCollection();
      
      public function TitanArenaRaidPopupMediator(param1:Player, param2:Vector.<UnitDescription>)
      {
         _isPending = new BooleanPropertyWriteable(true);
         _invalidBattle = new BooleanPropertyWriteable(false);
         _battles = new VectorPropertyWriteable(new Vector.<TitanArenaRaidBattleItem>() as Vector.<*>);
         super(param1);
         raid = new TitanArenaRaid(param1,param2);
         raid.signal_raidResult.add(handler_raidResult);
         raid.signal_invalidBattle.add(handler_invalidBattle);
         raid.signal_nextBattle.add(handler_nextBattle);
         raid.start();
      }
      
      override protected function dispose() : void
      {
         super.dispose();
         raid.stop();
         raid.signal_raidResult.remove(handler_raidResult);
         raid.signal_invalidBattle.remove(handler_invalidBattle);
         raid.signal_nextBattle.remove(handler_nextBattle);
      }
      
      public function get stage() : int
      {
         return player.titanArenaData.property_tier.value;
      }
      
      public function get isFinalStage() : Boolean
      {
         return player.titanArenaData.isFinalStage;
      }
      
      public function get isPending() : BooleanProperty
      {
         return _isPending;
      }
      
      public function get invalidBattle() : BooleanProperty
      {
         return _invalidBattle;
      }
      
      public function get battles() : VectorProperty
      {
         return _battles;
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new TitanArenaRaidPopup(this);
         return new TitanArenaRaidPopup(this);
      }
      
      public function action_finish() : void
      {
         close();
      }
      
      override public function close() : void
      {
         player.titanArenaData.action_checkForNextRound();
         super.close();
      }
      
      public function getFirstLossIndex() : int
      {
         var _loc1_:int = 0;
         var _loc3_:Vector.<TitanArenaRaidBattleItem> = enemyList.data as Vector.<TitanArenaRaidBattleItem>;
         if(!_loc3_)
         {
            return 0;
         }
         var _loc2_:int = _loc3_.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            if(!_loc3_[_loc1_].fullVictory)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return _loc2_ - 1;
      }
      
      public function action_info(param1:TitanArenaRaidBattleItem) : void
      {
         new TitanArenaRaidBattlesInfoPopupMediator(player,param1).open(Stash.click("info",popup.stashParams));
      }
      
      private function handler_nextBattle(param1:TitanArenaRaid) : void
      {
      }
      
      private function handler_raidResult(param1:TitanArenaRaid) : void
      {
         var _loc2_:Vector.<TitanArenaRaidBattleItem> = param1.results;
         _loc2_.sort(TitanArenaRaidBattleItem.sort_enemyPowerAndReward);
         _battles.value = _loc2_ as Vector.<*>;
         enemyList.data = _loc2_;
         _isPending.value = false;
      }
      
      private function handler_invalidBattle(param1:TitanArenaRaid) : void
      {
         _isPending.value = false;
         _invalidBattle.value = true;
      }
   }
}
