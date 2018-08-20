package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import game.view.gui.components.HeroPortrait;
   
   public class HeroPortraitClip extends GuiClipContainer
   {
       
      
      public const portrait:HeroPortrait = new HeroPortrait();
      
      public function HeroPortraitClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         container.addChild(portrait);
         container.touchable = false;
      }
   }
}
