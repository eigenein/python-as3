package game.battle.gui
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.battle.gui.hero.BattleGuiHeroTeamPanelLayoutGroup;
   
   public class BattleGuiReplayTeamsClip extends GuiClipNestedContainer
   {
       
      
      public var layout_attackers:BattleGuiHeroTeamPanelLayoutGroup;
      
      public var layout_defenders:BattleGuiHeroTeamPanelLayoutGroup;
      
      public function BattleGuiReplayTeamsClip()
      {
         layout_attackers = new BattleGuiHeroTeamPanelLayoutGroup("right");
         layout_defenders = new BattleGuiHeroTeamPanelLayoutGroup("left");
         super();
      }
   }
}
