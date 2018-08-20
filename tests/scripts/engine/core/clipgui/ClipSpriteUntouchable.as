package engine.core.clipgui
{
   public class ClipSpriteUntouchable extends ClipSprite
   {
       
      
      public function ClipSpriteUntouchable()
      {
         super();
         animation.graphics.touchable = false;
      }
   }
}
