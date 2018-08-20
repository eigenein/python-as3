package game.view.popup.team
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class TeamGatherPopupEmptyTeamClip extends GuiClipNestedContainer
   {
       
      
      public var tf_label_empty_team:ClipLabel;
      
      public function TeamGatherPopupEmptyTeamClip()
      {
         tf_label_empty_team = new ClipLabel();
         super();
      }
   }
}
