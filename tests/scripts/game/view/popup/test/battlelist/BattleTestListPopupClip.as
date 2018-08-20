package game.view.popup.test.battlelist
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.battle.gui.BattleGuiToggleButton;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   
   public class BattleTestListPopupClip extends GuiClipNestedContainer
   {
       
      
      public const button_close:ClipButton = new ClipButton();
      
      public const button_start:BattleGuiToggleButton = new BattleGuiToggleButton();
      
      public const scrollbar:GameScrollBar = new GameScrollBar();
      
      public const list:GameScrolledList = new GameScrolledList(scrollbar,null,null);
      
      public const list_item:ClipDataProvider = new ClipDataProvider();
      
      public const frame:GuiClipScale9Image = new GuiClipScale9Image();
      
      public function BattleTestListPopupClip()
      {
         super();
      }
   }
}
