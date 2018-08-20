package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.titan_arena.popup.reward.TitanArenaPointsProgressBarClip;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class TitanArenaPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButton;
      
      public var enemy_select_ui:TitanArenaPopupEnemySelectUIClip;
      
      public var defense_ui:TitanArenaPopupDefenseStatusUIClip;
      
      public var chest_button:TitanArenaChestButton;
      
      public var chest_marker:GuiClipImage;
      
      public var points_progressbar:TitanArenaPointsProgressBarClip;
      
      public var peace_time:TitanArenaPeaceTimeClip;
      
      public var header_layout_container:GuiClipLayoutContainer;
      
      public function TitanArenaPopupClip()
      {
         button_close = new ClipButton();
         enemy_select_ui = new TitanArenaPopupEnemySelectUIClip();
         defense_ui = new TitanArenaPopupDefenseStatusUIClip();
         chest_button = new TitanArenaChestButton();
         chest_marker = new GuiClipImage();
         points_progressbar = new TitanArenaPointsProgressBarClip();
         peace_time = new TitanArenaPeaceTimeClip();
         super();
      }
   }
}
