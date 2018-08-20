package game.view.popup.hero
{
   import game.view.gui.components.ClipLayout;
   
   public class HeroListForgeDialogClip extends HeroListDialogClip
   {
       
      
      public var layout_tabs:ClipLayout;
      
      public function HeroListForgeDialogClip()
      {
         layout_tabs = ClipLayout.vertical(-16);
         super();
      }
   }
}
