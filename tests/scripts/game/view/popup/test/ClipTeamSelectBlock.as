package game.view.popup.test
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.GuiClipLayoutContainer;
   import game.view.popup.team.TeamGatherPopupHeroList;
   
   public class ClipTeamSelectBlock extends GuiClipNestedContainer
   {
       
      
      public var heroList:TeamGatherPopupHeroList;
      
      public var hero_list_container:GuiClipLayoutContainer;
      
      public var team_list_container:GuiClipLayoutContainer;
      
      public function ClipTeamSelectBlock()
      {
         super();
      }
   }
}
