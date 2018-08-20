package game.mechanics.clan_war.popup.log
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   
   public class ClanWarLogPopupClip extends PopupClipBase
   {
       
      
      public var scrollbar:GameScrollBar;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var list:GameScrolledList;
      
      public var sideBGLight_inst0:ClipSprite;
      
      public var sideBGLight_inst1:ClipSprite;
      
      public var sideBGLight_inst2:ClipSprite;
      
      public var tf_message:ClipLabel;
      
      public function ClanWarLogPopupClip()
      {
         scrollbar = new GameScrollBar();
         gradient_bottom = new ClipSpriteUntouchable();
         gradient_top = new ClipSpriteUntouchable();
         list = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
         sideBGLight_inst0 = new ClipSprite();
         sideBGLight_inst1 = new ClipSprite();
         sideBGLight_inst2 = new ClipSprite();
         tf_message = new ClipLabel();
         super();
      }
   }
}
