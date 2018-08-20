package game.view.popup.test
{
   import game.assets.battle.BattlegroundAsset;
   
   public class BattleTestStatsBattlegroundValueObject
   {
       
      
      private var battleground:BattlegroundAsset;
      
      public function BattleTestStatsBattlegroundValueObject(param1:BattlegroundAsset)
      {
         super();
         this.battleground = param1;
      }
      
      public function get name() : String
      {
         return battleground.internalName;
      }
      
      public function get id() : int
      {
         return int(battleground.ident);
      }
   }
}
