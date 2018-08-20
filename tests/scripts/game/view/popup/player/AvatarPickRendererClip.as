package game.view.popup.player
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import game.view.gui.components.ClipButton;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class AvatarPickRendererClip extends ClipButton
   {
       
      
      public var portrait:PlayerPortraitClip;
      
      public var lock:ClipSprite;
      
      public var check:ClipSprite;
      
      public var check_anim:GuiAnimation;
      
      public var red_marker:ClipSprite;
      
      public function AvatarPickRendererClip()
      {
         portrait = new PlayerPortraitClip();
         lock = new ClipSprite();
         check = new ClipSprite();
         check_anim = new GuiAnimation();
         super();
      }
   }
}
