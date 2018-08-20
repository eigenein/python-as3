package game.mechanics.grand.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.grand.popup.log.GrandLogInfoTeamClip;
   
   public class GrandBattleResultBattleClip extends GuiClipNestedContainer
   {
       
      
      public var block_attacker:GrandLogInfoTeamClip;
      
      public var block_defender:GrandLogInfoTeamClip;
      
      public var block_number:GrandTeamGatherTeamNumber;
      
      public function GrandBattleResultBattleClip()
      {
         super();
      }
   }
}
