package game.mechanics.titan_arena.popup.raid
{
   import game.battle.gui.BattleUserPanel;
   import game.view.PopupClipBase;
   
   public class TitanArenaRaidBattlesInfoPopupClip extends PopupClipBase
   {
       
      
      public const attacker:BattleUserPanel = new BattleUserPanel();
      
      public const defender:BattleUserPanel = new BattleUserPanel();
      
      public const block_attack:TitanArenaRaidBattlesInfoTeamBlockClip = new TitanArenaRaidBattlesInfoTeamBlockClip();
      
      public const block_defence:TitanArenaRaidBattlesInfoTeamBlockClip = new TitanArenaRaidBattlesInfoTeamBlockClip();
      
      public function TitanArenaRaidBattlesInfoPopupClip()
      {
         super();
         defender.portrait.portrait.direction = -1;
      }
   }
}
