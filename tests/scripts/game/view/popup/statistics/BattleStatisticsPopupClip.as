package game.view.popup.statistics
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   
   public class BattleStatisticsPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var tf_header:ClipLabel;
      
      public var player_1:BattleStatisticsPopupTeamClip;
      
      public var player_2:BattleStatisticsPopupTeamClip;
      
      public var PopupBG_12_12_12_12_inst0:GuiClipScale9Image;
      
      public function BattleStatisticsPopupClip()
      {
         button_close = new ClipButton();
         tf_header = new ClipLabel();
         player_1 = new BattleStatisticsPopupTeamClip(false);
         player_2 = new BattleStatisticsPopupTeamClip(true);
         PopupBG_12_12_12_12_inst0 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         super();
      }
   }
}
