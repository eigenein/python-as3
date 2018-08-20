package game.assets.battle
{
   public class BattleSideAsset
   {
       
      
      private var _icons:BattlePlayerTeamIconDescription;
      
      public function BattleSideAsset()
      {
         super();
      }
      
      public function set icons(param1:BattlePlayerTeamIconDescription) : void
      {
         _icons = param1;
      }
      
      public function get icons() : BattlePlayerTeamIconDescription
      {
         return _icons;
      }
   }
}
