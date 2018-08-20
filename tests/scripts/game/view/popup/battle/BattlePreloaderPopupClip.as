package game.view.popup.battle
{
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.PopupClipBase;
   
   public class BattlePreloaderPopupClip extends PopupClipBase
   {
       
      
      public var animation:GuiAnimation;
      
      public var progress_bg:GuiClipScale3Image;
      
      public var progress_bar:GuiClipImage;
      
      public function BattlePreloaderPopupClip()
      {
         super();
      }
      
      public function setProgress(param1:Number) : void
      {
         var _loc3_:Number = progress_bg.image.width - 10;
         var _loc2_:* = 4;
         progress_bar.image.width = int(_loc2_ + (_loc3_ - _loc2_) * param1);
      }
   }
}
