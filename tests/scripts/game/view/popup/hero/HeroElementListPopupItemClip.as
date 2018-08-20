package game.view.popup.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.hero.rune.HeroElementClipProgressBar;
   
   public class HeroElementListPopupItemClip extends HeroListItemClipBase
   {
       
      
      public var red_dot:ClipSprite;
      
      public var tf_hero_name:ClipLabel;
      
      public var tf_hero_level:SpecialClipLabel;
      
      public var progress:HeroElementClipProgressBar;
      
      public function HeroElementListPopupItemClip()
      {
         tf_hero_name = new ClipLabel();
         tf_hero_level = new SpecialClipLabel();
         progress = new HeroElementClipProgressBar();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         marker_hero_portrait_inst0.graphics.touchable = false;
         tf_hero_name.touchable = false;
         tf_hero_level.touchable = false;
         progress.graphics.touchable = false;
      }
   }
}
