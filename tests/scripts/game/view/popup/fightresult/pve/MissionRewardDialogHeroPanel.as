package game.view.popup.fightresult.pve
{
   import game.view.gui.components.ClipProgressBar;
   import game.view.popup.fightresult.RewardDialogHeroPanelBase;
   
   public class MissionRewardDialogHeroPanel extends RewardDialogHeroPanelBase
   {
       
      
      public var hero_panel_progressbar_inst0:ClipProgressBar;
      
      public function MissionRewardDialogHeroPanel()
      {
         super();
         hero_panel_progressbar_inst0 = new ClipProgressBar();
      }
   }
}
