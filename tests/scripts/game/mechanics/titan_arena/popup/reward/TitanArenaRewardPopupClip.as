package game.mechanics.titan_arena.popup.reward
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.fightresult.RewardDialogRibbonHeader;
   
   public class TitanArenaRewardPopupClip extends GuiClipNestedContainer
   {
       
      
      public var ribbon:RewardDialogRibbonHeader;
      
      public var content_container:ClipLayout;
      
      public function TitanArenaRewardPopupClip()
      {
         ribbon = new RewardDialogRibbonHeader();
         content_container = ClipLayout.verticalCenter(15);
         super();
      }
   }
}
