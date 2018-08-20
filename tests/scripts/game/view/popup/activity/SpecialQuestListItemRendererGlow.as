package game.view.popup.activity
{
   import engine.core.clipgui.ClipAnimatedContainer;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipScale9Image;
   
   public class SpecialQuestListItemRendererGlow extends ClipAnimatedContainer
   {
       
      
      public const glow:ClipSprite = new ClipSprite();
      
      public const glow1:ClipSprite = new ClipSprite();
      
      public const bgScale9:GuiClipScale9Image = new GuiClipScale9Image();
      
      public const bgScale92:GuiClipScale9Image = new GuiClipScale9Image();
      
      public function SpecialQuestListItemRendererGlow(param1:Boolean = false)
      {
         super(param1);
      }
   }
}
