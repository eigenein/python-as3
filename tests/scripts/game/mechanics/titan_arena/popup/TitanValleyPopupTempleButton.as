package game.mechanics.titan_arena.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.mechanics.zeppelin.popup.clip.ZeppelinPopupButton;
   
   public class TitanValleyPopupTempleButton extends ZeppelinPopupButton
   {
       
      
      public var nested_animation:GuiClipNestedContainer;
      
      public function TitanValleyPopupTempleButton()
      {
         nested_animation = new GuiClipNestedContainer();
         super();
      }
   }
}
