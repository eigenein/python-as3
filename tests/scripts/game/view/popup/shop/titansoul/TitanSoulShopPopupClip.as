package game.view.popup.shop.titansoul
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   
   public class TitanSoulShopPopupClip extends PopupClipBase
   {
       
      
      public const scrollbar:GameScrollBar = new GameScrollBar();
      
      public const gradient_top:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const gradient_bottom:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const list:GameScrolledList = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
      
      public const vertDivider_inst0:ClipSprite = new ClipSprite();
      
      public function TitanSoulShopPopupClip()
      {
         super();
      }
   }
}
