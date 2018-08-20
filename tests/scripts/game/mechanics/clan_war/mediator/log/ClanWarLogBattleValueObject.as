package game.mechanics.clan_war.mediator.log
{
   import game.data.storage.DataStorage;
   import game.mechanics.clan_war.model.ClanWarDefenderValueObject;
   import game.mechanics.clan_war.storage.ClanWarSlotDescription;
   
   public class ClanWarLogBattleValueObject extends ClanWarLogBattleValueObjectBase
   {
       
      
      public function ClanWarLogBattleValueObject(param1:ClanWarLogBattlePopupMediator, param2:ClanWarLogBattleEntry)
      {
         super(param1,param2);
      }
      
      public function get isHeroBattle() : Boolean
      {
         var _loc1_:ClanWarSlotDescription = DataStorage.clanWar.getSlotById(entry.slotId);
         return !!_loc1_?_loc1_.isHeroSlot:true;
      }
      
      public function get isVictory() : Boolean
      {
         return !entry.wasEmpty && entry.victory;
      }
      
      public function get isDefeat() : Boolean
      {
         return !entry.wasEmpty && !entry.victory;
      }
      
      public function get isDraw() : Boolean
      {
         return false;
      }
      
      public function get rawReplay() : Object
      {
         return entry.replay;
      }
      
      public function get attacker() : ClanWarDefenderValueObject
      {
         return entry.attacker;
      }
      
      public function get defender() : ClanWarDefenderValueObject
      {
         return entry.defender;
      }
      
      public function action_chat() : void
      {
         mediator.action_chat(this);
      }
      
      public function action_info() : void
      {
         mediator.action_info(this);
      }
      
      public function action_replay() : void
      {
         mediator.action_replay(this);
      }
   }
}
