package game.mechanics.clan_war.popup.log
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.mechanics.clan_war.popup.ClanWarEnemiesStateCip;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class ClanWarLogBattlePopupClip extends PopupClipBase
   {
       
      
      public var vs_header:ClanWarEnemiesStateCip;
      
      public var tab_layout_container:GuiClipLayoutContainer;
      
      public var tf_message:ClipLabel;
      
      public var tf_date:ClipLabel;
      
      public var scrollbar:GameScrollBar;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var list:GameScrolledList;
      
      public function ClanWarLogBattlePopupClip()
      {
         vs_header = new ClanWarEnemiesStateCip();
         tab_layout_container = new GuiClipLayoutContainer();
         tf_message = new ClipLabel();
         tf_date = new ClipLabel();
         scrollbar = new GameScrollBar();
         gradient_top = new ClipSpriteUntouchable();
         gradient_bottom = new ClipSpriteUntouchable();
         list = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
         super();
      }
   }
}
