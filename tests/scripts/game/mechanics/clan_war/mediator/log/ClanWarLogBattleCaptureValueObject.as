package game.mechanics.clan_war.mediator.log
{
   public class ClanWarLogBattleCaptureValueObject extends ClanWarLogBattleValueObjectBase
   {
       
      
      public function ClanWarLogBattleCaptureValueObject(param1:ClanWarLogBattlePopupMediator, param2:ClanWarLogBattleEntry)
      {
         super(param1,param2);
      }
      
      override public function get wasEmpty() : Boolean
      {
         return false;
      }
      
      override public function get fortificationIsCaptured() : Boolean
      {
         return true;
      }
      
      override public function get points() : int
      {
         return entry.fortificationPoints;
      }
   }
}
