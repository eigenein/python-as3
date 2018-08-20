package game.view.gui.components.hero
{
   import com.progrestar.framework.ares.core.Node;
   import com.progrestar.framework.ares.starling.StarlingClipNode;
   import engine.core.clipgui.IGuiClip;
   import game.view.gui.components.HeroPreview;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class ClipHeroPreview extends Sprite implements IGuiClip
   {
       
      
      public const hero:HeroPreview = new HeroPreview();
      
      public function ClipHeroPreview()
      {
         super();
         addChild(hero.graphics);
         touchable = false;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         hero.dispose();
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function setNode(param1:Node) : void
      {
         StarlingClipNode.applyState(graphics,param1.state);
      }
   }
}
